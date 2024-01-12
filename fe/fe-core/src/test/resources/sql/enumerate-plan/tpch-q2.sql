[planCount]
12
[plan-1]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                INNER JOIN (join-predicate [1: P_PARTKEY = 19: PS_PARTKEY AND 11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                    CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                        SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-2]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                INNER JOIN (join-predicate [1: P_PARTKEY = 19: PS_PARTKEY AND 11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                    CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                        SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                    EXCHANGE SHUFFLE[20]
                                        SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-3]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                    SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                    EXCHANGE BROADCAST
                                        INNER JOIN (join-predicate [1: P_PARTKEY = 19: PS_PARTKEY] post-join-predicate [null])
                                            SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                            EXCHANGE SHUFFLE[19]
                                                SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                EXCHANGE BROADCAST
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-4]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                    SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                    EXCHANGE SHUFFLE[20]
                                        EXCHANGE SHUFFLE[20]
                                            INNER JOIN (join-predicate [19: PS_PARTKEY = 1: P_PARTKEY] post-join-predicate [null])
                                                SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                                EXCHANGE BROADCAST
                                                    SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                EXCHANGE BROADCAST
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-5]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                    SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                    EXCHANGE SHUFFLE[20]
                                        EXCHANGE SHUFFLE[20]
                                            INNER JOIN (join-predicate [19: PS_PARTKEY = 1: P_PARTKEY] post-join-predicate [null])
                                                SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                                EXCHANGE SHUFFLE[1]
                                                    SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                EXCHANGE BROADCAST
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                            EXCHANGE BROADCAST
                                SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-6]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [1: P_PARTKEY = 19: PS_PARTKEY AND 11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                    SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                EXCHANGE BROADCAST
                                    SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[plan-7]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [1: P_PARTKEY = 19: PS_PARTKEY AND 11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                CROSS JOIN (join-predicate [null] post-join-predicate [null])
                                    SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                EXCHANGE SHUFFLE[20]
                                    SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-8]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                EXCHANGE BROADCAST
                                    INNER JOIN (join-predicate [1: P_PARTKEY = 19: PS_PARTKEY] post-join-predicate [null])
                                        SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                                        EXCHANGE SHUFFLE[19]
                                            SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-9]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                EXCHANGE SHUFFLE[20]
                                    EXCHANGE SHUFFLE[20]
                                        INNER JOIN (join-predicate [19: PS_PARTKEY = 1: P_PARTKEY] post-join-predicate [null])
                                            SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                            EXCHANGE BROADCAST
                                                SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-10]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                                SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                EXCHANGE SHUFFLE[20]
                                    EXCHANGE SHUFFLE[20]
                                        INNER JOIN (join-predicate [19: PS_PARTKEY = 1: P_PARTKEY] post-join-predicate [null])
                                            SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                            EXCHANGE SHUFFLE[1]
                                                SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
                            EXCHANGE BROADCAST
                                INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                    SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                    EXCHANGE BROADCAST
                                        SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
[end]
[plan-11]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                EXCHANGE BROADCAST
                                    INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                        SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
                            EXCHANGE SHUFFLE[20]
                                EXCHANGE SHUFFLE[20]
                                    INNER JOIN (join-predicate [19: PS_PARTKEY = 1: P_PARTKEY] post-join-predicate [null])
                                        SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
[end]
[plan-12]
TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
    TOP-N (order by [[16: S_ACCTBAL DESC NULLS LAST, 26: N_NAME ASC NULLS FIRST, 12: S_NAME ASC NULLS FIRST, 1: P_PARTKEY ASC NULLS FIRST]])
        PREDICATE 22: PS_SUPPLYCOST = 59: min
            ANALYTIC ({59: min=min(22: PS_SUPPLYCOST)} [1: P_PARTKEY] [] )
                TOP-N (order by [[1: P_PARTKEY ASC NULLS FIRST]])
                    EXCHANGE SHUFFLE[1]
                        INNER JOIN (join-predicate [11: S_SUPPKEY = 20: PS_SUPPKEY] post-join-predicate [null])
                            INNER JOIN (join-predicate [14: S_NATIONKEY = 25: N_NATIONKEY] post-join-predicate [null])
                                SCAN (columns[17: S_COMMENT, 11: S_SUPPKEY, 12: S_NAME, 13: S_ADDRESS, 14: S_NATIONKEY, 15: S_PHONE, 16: S_ACCTBAL] predicate[null])
                                EXCHANGE BROADCAST
                                    INNER JOIN (join-predicate [27: N_REGIONKEY = 30: R_REGIONKEY] post-join-predicate [null])
                                        SCAN (columns[25: N_NATIONKEY, 26: N_NAME, 27: N_REGIONKEY] predicate[null])
                                        EXCHANGE BROADCAST
                                            SCAN (columns[30: R_REGIONKEY, 31: R_NAME] predicate[31: R_NAME = AMERICA])
                            EXCHANGE SHUFFLE[20]
                                EXCHANGE SHUFFLE[20]
                                    INNER JOIN (join-predicate [19: PS_PARTKEY = 1: P_PARTKEY] post-join-predicate [null])
                                        SCAN (columns[19: PS_PARTKEY, 20: PS_SUPPKEY, 22: PS_SUPPLYCOST] predicate[null])
                                        EXCHANGE SHUFFLE[1]
                                            SCAN (columns[1: P_PARTKEY, 3: P_MFGR, 5: P_TYPE, 6: P_SIZE] predicate[6: P_SIZE = 12 AND 5: P_TYPE LIKE %COPPER])
[end]