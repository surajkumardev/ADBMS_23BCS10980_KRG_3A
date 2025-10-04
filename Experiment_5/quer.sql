----------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------EXPERIMENT 05 (MEDIUM LEVEL)------------------------------

CREATE TABLE transaction_data (
    id INT,
    value INT
);

-- For id = 1
INSERT INTO transaction_data (id, value)
SELECT 1, random() * 1000  -- simulate transaction amounts 0-1000
FROM generate_series(1, 1000000);

-- For id = 2
INSERT INTO transaction_data (id, value)
SELECT 2, random() * 1000
FROM generate_series(1, 1000000);

SELECT *FROM transaction_data



--WITH NORMAL VIEW
CREATE OR REPLACE VIEW sales_summary_view AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;


EXPLAIN ANALYZE
SELECT * FROM sales_summary_view;



--WITH MATERIALIZED VIEW
CREATE MATERIALIZED VIEW sales_summary_mv AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;



EXPLAIN ANALYZE
SELECT * FROM sales_summary_mv;



create table random_tabl (id int, val decimal)

insert into random_tabl 
select 1, random() from generate_series(1,1000000);


insert into random_tabl 
select 2, random() from generate_series(1,1000000);



--normal execution
select id, avg(val), count(*)
from random_tabl
group by id;


--execution by materialized view
create materialized view mv_random_tabl
as
select id, avg(val), count(*)
from random_tabl
group by id;

select *from mv_random_tabl


--if you update anything in table, the mv doesn't gets updated
---for that we have to refresh it

refresh materialized view mv_random_tabl;

