DROP DATABASE IF EXISTS Donuts;
CREATE DATABASE Donuts;
SHOW DATABASES;
USE donuts;

CREATE TABLE waffle_types (
    waffle_id INT NOT NULL AUTO_INCREMENT,
    waffle_name VARCHAR(50),
    waffle_flavor VARCHAR(50),
    PRIMARY KEY (waffle_id)
);

INSERT INTO waffle_types
VALUE (DEFAULT,  'Belgium', 'Plain Belgium');

CREATE TABLE donut_flavors (
    donut_id INT NOT NULL AUTO_INCREMENT,
    donut_name VARCHAR(50),
    donut_flavor VARCHAR(50),
    PRIMARY KEY (donut_id),
    FOREIGN KEY (donut_id)
        REFERENCES waffle_types (waffle_id)
);

INSERT INTO donut_flavors 
VALUES (DEFAULT, 'Choco latte', 'Chocolate and Coffee');

SELECT 
    *
FROM
    donut_flavors;
    
SELECT 
    *
FROM
    waffle_types;
    
SELECT 
    *
FROM
    donut_flavors,
    waffle_types;
    
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;
CREATE TABLE invoices (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT NOT NULL,
    invoice_number VARCHAR(50) NOT NULL,
    invoice_date DATE NOT NULL,
    invoice_total DECIMAL(9 , 2 ) NOT NULL,
    payment_total DECIMAL(9 , 2 ) DEFAULT 0,
    credit_total DECIMAL(9 , 2 ) DEFAULT 0,
    terms_id INT NOT NULL,
    invoice_due_date DATE NOT NULL,
    payment_date DATE,
    FOREIGN KEY (vendor_id)
        REFERENCES vendors (vendor_id),
    FOREIGN KEY (terms_id)
        REFERENCES terms (terms_id)
);


create table orders (
	customer_id int primary key auto_increment,
    vendor_total decimal(9,2) not null
);
insert into example.orders values(
default,(select count(*) from om.order_details where om.order_details.order_id = 264));

select * from example.orders;