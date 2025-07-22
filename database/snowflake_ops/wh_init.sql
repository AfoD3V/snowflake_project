CREATE OR REPLACE WAREHOUSE roman_wh
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;

--  Rozmiar	    vCPU	Threads	       Typowe zastosowanie	                        Koszt (w kredytach) / godz.
--  X-Small     1	    8	           Testy, ma³e zadania SQL, development	                    ~1
--  Small       2	    16	           Œrednie przetwarzanie, ma³e ETL	                        ~2
--  Medium      4	    32	           ETL, wiêksze ³¹czenia, produkcyjne zapytania	            ~4
--  Large       8	    64	           Du¿e ETL, ML preprocessing, hurtownie	                ~8
--  X-Large	    16      128	           Big Data, intensywne analizy	                            ~16
--  2X-Large	32	    256	           Mega skale, OLAP, agregacje w TB danych	                ~32
--  3X-Large	64	    512	           Rzadko potrzebne, high-throughput pipelines	            ~64
--  4X-Large    128	    1024	       High-end korporacyjne scenariusze	                    ~128