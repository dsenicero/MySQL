-- Identifier
-- D'Angelo Senicero 20/FA ITSE-2309-10X1
-- -----------------------------------------------------
-- Verifies use of my database
-- 		THE USE STATEMENT IS USED TO SELECT MY DATABASE
-- -----------------------------------------------------
use senicero;
-- -----------------------------------------------------
-- 4A Write select statements to list all records and all fields from each table
-- 		QUERIES USED TO DISPLAY ALL DATA OF TABLES, DRAP AND SELECT ALL QUERIES AND PRESS CRL+SHIFT+ENTER TO DISPLAY ALL AT ONCE
-- -----------------------------------------------------
select * from customers;
select * from order_details;
select * from orders;
select * from product_suppliers;
select * from products;
select * from suppliers;
-- -----------------------------------------------------
-- 4B The following statement displays supplier names and the description of the product(s) they supply.
-- 	  Only suppliers that provide a product are displayed. Results are ordered by supplier name.
-- 		QUERY DISPLAYS THE SUPPLIERS THAT SUPPLIES PRODUCTS. DISPLAYS SUPPLIER_NAME AND PRODUCT_DESCRIPTION
-- -----------------------------------------------------
SELECT 
    supplier_name, product_description
FROM
    product_suppliers
        JOIN
    products USING (product_id)
        JOIN
    suppliers USING (supplier_id)
ORDER BY supplier_name;
-- -----------------------------------------------------
-- 4C Write a statement that displays the product id and description of products, along with the
--    vendor(s) that supply them
-- 		QUERY DISPLAYS LISTS ALL OF THE PRODUCTS THAT HAVE SUPPLIERS WITH THE ADDITION OF THEIR PRODUCT_ID, PRODUCT_DESCRIPTION, AND SUPPLIER_NAME
-- -----------------------------------------------------
SELECT 
    product_id, product_description, supplier_name
FROM
    products
        JOIN
    product_suppliers USING (product_id)
        JOIN
    suppliers USING (supplier_id)
ORDER BY product_id;
-- -----------------------------------------------------
-- 4D Write a statement that displays the full name of all customers.
-- 		QUERY DISPLAYS CUSTOMER'S FULL NAME
-- -----------------------------------------------------
SELECT 
    CONCAT_WS(', ',
            customer_last_name,
            customer_first_name) AS 'Full Name'
FROM
    customers;
-- -----------------------------------------------------
-- 4E  Write a statement that displays the full name of customers who placed orders, the order id, the
--     dates they placed the order, and the product ID, quantity, and description of what they ordered
-- 			QUERY DISPLAYS CUSTOMER'S FULL NAME, ORDER_ID, ORDER_DATE, PRODUCT_ID, ORDER_QTY, AND PRODUCT DESCRIPTION. 
-- 			ORDER BY FULL NAME, ORDER_DATE, AND THEN PRODUCT_ID
-- -----------------------------------------------------
SELECT 
    CONCAT_WS(', ',
            customer_last_name,
            customer_first_name) AS 'Full Name',
    order_id,
    order_date,
    product_id,
    order_qty,
    product_description
FROM
    orders
        JOIN
    order_details USING (order_id)
        JOIN
    products USING (product_id)
        JOIN
    customers USING (customer_id)
ORDER BY CONCAT_WS(', ',customer_last_name, customer_first_name), order_date, product_id;
-- -----------------------------------------------------
-- 4F Write a statement to add a record to a table using an auto increment column
-- 		'INSERTS' NEW SUPPLIER INTO SUPPLIERS TABLE
-- -----------------------------------------------------
INSERT INTO suppliers  VALUES 
(DEFAULT, 'Function(x) Inc.', '4 Aberg Way', 'Indianapolis', 'IN', '46278', '317-924-5958',  '3146524880', 'Benjy', 'Manterfield');
select * from suppliers;
-- -----------------------------------------------------
-- 4G Write a statement to edit at least one record in a table
-- 		EDITS PREVIOUSLY ADDED SUPPLIER TO DIFFERENT SUPPLIER BY IDENTIFYING SUPPLIER_ID
-- -----------------------------------------------------
UPDATE suppliers 
SET 
    supplier_name = 'Plastic Coffee',
    supplier_address = '0 Plastic Way',
    supplier_city = 'Waco',
    supplier_state = 'TX',
    supplier_zip_code = '76711',
    supplier_fax = NULL,
    supplier_contact_first_name = 'Plastic',
    supplier_contact_last_name = 'Man'
WHERE
    supplier_id = 6;
select * from suppliers;
-- -----------------------------------------------------
-- 4H Write a statement to delete at least one record in a table
-- 		DELETES PLASTIC COFFEE FROM THE SUPPLIERS TABLE BY IDENTIFYING SUPPLIER_ID
-- -----------------------------------------------------
DELETE FROM suppliers 
WHERE
    supplier_id = 6;
SELECT 
    *
FROM
    suppliers;