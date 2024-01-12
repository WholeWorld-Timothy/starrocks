// Copyright 2021-present StarRocks, Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "io/cache_input_stream.h"

#include <gtest/gtest.h>

#include "block_cache/block_cache.h"
#include "fs/fs_util.h"
#include "testutil/assert.h"

namespace starrocks::io {

class MockSeekableInputStream : public io::SeekableInputStream {
public:
    explicit MockSeekableInputStream(char* contents, int64_t size) : _contents(contents), _size(size) {}

    StatusOr<int64_t> read(void* data, int64_t count) override {
        count = std::min(count, _size - _offset);
        memcpy(data, &_contents[_offset], count);
        _offset += count;
        return count;
    }

    Status seek(int64_t position) override {
        _offset = std::min<int64_t>(position, _size);
        return Status::OK();
    }

    StatusOr<int64_t> position() override { return _offset; }

    StatusOr<int64_t> get_size() override { return _size; }

private:
    const char* _contents;
    int64_t _size;
    int64_t _offset{0};
};

class CacheInputStreamTest : public ::testing::Test {
public:
    static void SetUpTestCase() {
        auto cache = BlockCache::instance();
        CacheOptions options;
        options.mem_space_size = 100 * 1024 * 1024;
#ifdef WITH_STARCACHE
        options.engine = "starcache";
#else
        options.engine = "cachelib";
#endif
        options.enable_checksum = false;
        options.max_concurrent_inserts = 1500000;
        options.block_size = block_size;
        ASSERT_OK(cache->init(options));
    }

    static void TearDownTestCase() { BlockCache::instance()->shutdown(); }

    void SetUp() override {}
    void TearDown() override {}

    static void read_stream_data(io::SeekableInputStream* stream, int64_t offset, int64_t size, char* data) {
        ASSERT_OK(stream->seek(offset));
        auto res = stream->read(data, size);
        ASSERT_TRUE(res.ok());
    }

    static void gen_test_data(char* data, int64_t size, int64_t block_size) {
        for (int i = 0; i <= (size - 1) / block_size; ++i) {
            int64_t offset = i * block_size;
            int64_t count = std::min(block_size, size - offset);
            memset(data + offset, 'a' + i, count);
        }
    }

    static bool check_data_content(char* data, int64_t size, char content) {
        for (int i = 0; i < size; ++i) {
            if (data[i] != content) {
                return false;
            }
        }
        return true;
    }

    static const int64_t block_size;
};

const int64_t CacheInputStreamTest::block_size = 1024 * 1024;

TEST_F(CacheInputStreamTest, test_aligned_read) {
    const int64_t block_count = 3;

    int64_t data_size = block_size * block_count;
    char data[data_size + 1];
    gen_test_data(data, data_size, block_size);

    const std::string file_name = "test_file1";
    std::shared_ptr<io::SeekableInputStream> stream(new MockSeekableInputStream(data, data_size));
    std::shared_ptr<io::SharedBufferedInputStream> sb_stream(
            new io::SharedBufferedInputStream(stream, file_name, data_size));
    io::CacheInputStream cache_stream(sb_stream, file_name, data_size, 1000000);
    cache_stream.set_enable_populate_cache(true);
    auto& stats = cache_stream.stats();

    // first read from backend
    for (int i = 0; i < block_count; ++i) {
        char buffer[block_size];
        read_stream_data(&cache_stream, i * block_size, block_size, buffer);
        ASSERT_TRUE(check_data_content(buffer, block_size, 'a' + i));
    }
    ASSERT_EQ(stats.read_cache_count, 0);
    ASSERT_EQ(stats.write_cache_count, block_count);

    // first read from cache
    for (int i = 0; i < block_count; ++i) {
        char buffer[block_size];
        read_stream_data(&cache_stream, i * block_size, block_size, buffer);
        ASSERT_TRUE(check_data_content(buffer, block_size, 'a' + i));
    }
    ASSERT_EQ(stats.read_cache_count, block_count);
}

TEST_F(CacheInputStreamTest, test_random_read) {
    const int64_t block_count = 3;

    const int64_t data_size = block_size * block_count;
    char data[data_size + 1];
    gen_test_data(data, data_size, block_size);

    const std::string file_name = "test_file2";
    std::shared_ptr<io::SeekableInputStream> stream(new MockSeekableInputStream(data, data_size));
    std::shared_ptr<io::SharedBufferedInputStream> sb_stream(
            new io::SharedBufferedInputStream(stream, file_name, data_size));
    io::CacheInputStream cache_stream(sb_stream, file_name, data_size, 1000000);
    cache_stream.set_enable_populate_cache(true);
    auto& stats = cache_stream.stats();

    // first read from backend
    for (int i = 0; i < block_count; ++i) {
        char buffer[block_size];
        read_stream_data(&cache_stream, i * block_size, block_size, buffer);
        ASSERT_TRUE(check_data_content(buffer, block_size, 'a' + i));
    }
    ASSERT_EQ(stats.read_cache_count, 0);
    ASSERT_EQ(stats.write_cache_count, block_count);

    // seek to a custom postion in second block, and read multiple block
    int64_t off_in_block = 100;
    ASSERT_OK(cache_stream.seek(block_size + off_in_block));
    ASSERT_EQ(cache_stream.position().value(), block_size + off_in_block);

    char buffer[block_size * 2];
    auto res = cache_stream.read(buffer, block_size * 2);
    ASSERT_TRUE(res.ok());

    ASSERT_TRUE(check_data_content(buffer, block_size - off_in_block, 'a' + 1));
    ASSERT_TRUE(check_data_content(buffer + block_size - off_in_block, block_size, 'a' + 2));

    ASSERT_EQ(stats.read_cache_count, 2);
}

TEST_F(CacheInputStreamTest, test_file_overwrite) {
    const int64_t block_count = 3;

    int64_t data_size = block_size * block_count;
    char data[data_size + 1];
    gen_test_data(data, data_size, block_size);

    const std::string file_name = "test_file3";
    std::shared_ptr<io::SeekableInputStream> stream(new MockSeekableInputStream(data, data_size));
    std::shared_ptr<io::SharedBufferedInputStream> sb_stream(
            new io::SharedBufferedInputStream(stream, file_name, data_size));
    io::CacheInputStream cache_stream(sb_stream, file_name, data_size, 1000000);
    cache_stream.set_enable_populate_cache(true);
    auto& stats = cache_stream.stats();

    // first read from backend
    for (int i = 0; i < block_count; ++i) {
        char buffer[block_size];
        read_stream_data(&cache_stream, i * block_size, block_size, buffer);
        ASSERT_TRUE(check_data_content(buffer, block_size, 'a' + i));
    }
    ASSERT_EQ(stats.read_cache_count, 0);
    ASSERT_EQ(stats.write_cache_count, block_count);

    // first read from cache
    for (int i = 0; i < block_count; ++i) {
        char buffer[block_size];
        read_stream_data(&cache_stream, i * block_size, block_size, buffer);
        ASSERT_TRUE(check_data_content(buffer, block_size, 'a' + i));
    }
    ASSERT_EQ(stats.read_cache_count, block_count);

    // With different modification time, the old cache cannot be used
    io::CacheInputStream cache_stream2(sb_stream, file_name, data_size, 2000000);
    cache_stream2.set_enable_populate_cache(true);
    auto& stats2 = cache_stream2.stats();
    for (int i = 0; i < block_count; ++i) {
        char buffer[block_size];
        read_stream_data(&cache_stream2, i * block_size, block_size, buffer);
        ASSERT_TRUE(check_data_content(buffer, block_size, 'a' + i));
    }
    ASSERT_EQ(stats2.read_cache_count, 0);
}

TEST_F(CacheInputStreamTest, test_read_from_io_buffer) {
    const int64_t block_count = 1;

    int64_t data_size = block_size * block_count;
    char data[data_size + 1];
    gen_test_data(data, data_size, block_size);

    const std::string file_name = "test_file3";
    std::shared_ptr<io::SeekableInputStream> stream(new MockSeekableInputStream(data, data_size));
    std::shared_ptr<io::SharedBufferedInputStream> sb_stream(
            new io::SharedBufferedInputStream(stream, file_name, data_size));
    io::CacheInputStream cache_stream(sb_stream, file_name, data_size, 1000);
    cache_stream.set_enable_populate_cache(true);
    cache_stream.set_enable_block_buffer(true);
    auto& stats = cache_stream.stats();

    // read from backend, cache the data
    char buffer[block_size];
    read_stream_data(&cache_stream, 0, block_size, buffer);
    ASSERT_TRUE(check_data_content(buffer, block_size, 'a'));
    ASSERT_EQ(stats.read_cache_count, 0);
    ASSERT_EQ(stats.write_cache_count, 1);

    // read the first 1024 bytes from cache, actually it will read the whole block from cache
    // and save it to block buffer.
    read_stream_data(&cache_stream, 0, 1024, buffer);
    ASSERT_TRUE(check_data_content(buffer, block_size, 'a'));
    ASSERT_EQ(stats.read_cache_count, 1);

    read_stream_data(&cache_stream, 1024, 1024, buffer);
    ASSERT_TRUE(check_data_content(buffer, block_size, 'a'));
    ASSERT_EQ(stats.read_block_buffer_count, 1);
}

TEST_F(CacheInputStreamTest, test_read_zero_copy) {
    int64_t data_size = block_size + 1024;
    char data[data_size + 1];
    gen_test_data(data, data_size, block_size);

    const std::string file_name = "test_file3";
    std::shared_ptr<io::SeekableInputStream> stream(new MockSeekableInputStream(data, data_size));
    std::shared_ptr<io::SharedBufferedInputStream> sb_stream(
            new io::SharedBufferedInputStream(stream, file_name, data_size));
    io::CacheInputStream cache_stream(sb_stream, file_name, data_size, 1000);
    cache_stream.set_enable_populate_cache(true);
    cache_stream.set_enable_block_buffer(false);

    // read from backend, cache the data
    size_t count = data_size - 10;
    char buffer[count];
    read_stream_data(&cache_stream, 10, count, buffer);
    ASSERT_TRUE(check_data_content(buffer, block_size - 10, 'a'));
    ASSERT_TRUE(check_data_content(buffer + block_size - 10, 1024, 'b'));
}

TEST_F(CacheInputStreamTest, test_read_with_zero_range) {
    const int64_t block_count = 1;
    int64_t data_size = block_size * block_count;
    char data[data_size + 1];
    gen_test_data(data, data_size, block_size);

    const std::string file_name = "test_file4";
    std::shared_ptr<io::SeekableInputStream> stream(new MockSeekableInputStream(data, data_size));
    std::shared_ptr<io::SharedBufferedInputStream> sb_stream(
            new io::SharedBufferedInputStream(stream, file_name, data_size));
    io::CacheInputStream cache_stream(sb_stream, file_name, data_size, 1000);
    cache_stream.set_enable_populate_cache(true);
    cache_stream.set_enable_block_buffer(true);
    auto& stats = cache_stream.stats();

    // read from backend, cache the data
    char buffer[block_size];
    read_stream_data(&cache_stream, 0, block_size, buffer);
    ASSERT_TRUE(check_data_content(buffer, block_size, 'a'));
    ASSERT_EQ(stats.read_cache_count, 0);
    ASSERT_EQ(stats.write_cache_count, 1);

    // try read zero length data, expect no crash
    read_stream_data(&cache_stream, 0, 0, nullptr);
    ASSERT_EQ(stats.read_cache_count, 0);
}

} // namespace starrocks::io
