

--------------------------------------------EXPERIMENT 05 (HARD LEVEL)------------------------------
CREATE VIEW vW_ORDER_SUMMARY
AS
SELECT 
    O.order_id,
    O.order_date,
    P.product_name,
    C.full_name,
    (P.unit_price * O.quantity) - ((P.unit_price * O.quantity) * O.discount_percent / 100) AS final_cost
FROM customer_master AS C
JOIN sales_orders AS O 
    ON O.customer_id = C.customer_id
JOIN product_catalog AS P
    ON P.product_id = O.product_id;


	--ACCESSING THE VIEW
SELECT * FROM vW_ORDER_SUMMARY;
-- STILL WE THE CLIENT CAN ACCESS THE CONTENTS OF THE TABLE BY ACCESSING THE SCRIPT FROM LEFT SIDE OBJECT EXPLORER
-- IN THAT CASE, WE WILL USE ACCESS RIGHTS - CREATE USER FOR CLIENT - AND WILL GIVE PERMISSION TO THE CLIENT

--APPLYING THE ACCESS RIGHTS TO THE VIEW FOR THE CLIENT

--1. CREATE USER
CREATE ROLE ALOK
LOGIN
PASSWORD 'alok';
--now instead of sharing the credentials of my database to the client, i'll share with the specific user 'ALOK' in this case
/*
	open new query window -> connect to new user / sign in as new user
	and in that query window try to access the newly created view

	this will give error

	now we will giev access to the client
*/

GRANT SELECT ON vW_ORDER_SUMMARY TO ALOK;
--client will only be able to do the select, no alteration, and he can not see the sql
REVOKE SELECT ON vW_ORDER_SUMMARY FROM ALOK;

CREATE TABLE EMPLOYEE (
  empId INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  dept TEXT NOT NULL
);

-- insert
INSERT INTO EMPLOYEE VALUES (0001, 'Clark', 'Sales');
INSERT INTO EMPLOYEE VALUES (0002, 'Dave', 'Accounting');
INSERT INTO EMPLOYEE VALUES (0003, 'Ava', 'Sales');

select *from employee;

CREATE VIEW vW_STORE_SALES_DATA
AS
	SELECT EMPID, NAME, DEPT 
	FROM EMPLOYEE
	WHERE DEPT = 'Sales'
	WITH CHECK OPTION;

SELECT *FROM vW_STORE_SALES_DATA;

INSERT INTO vW_STORE_SALES_DATA(EMPID, NAME, DEPT) VALUES (5, 'Aman', 'Admin'); --VIOLATION CONDITION

