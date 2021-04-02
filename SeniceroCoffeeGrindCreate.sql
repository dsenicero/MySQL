-- Identifier
-- D'Angelo Senicero 20/FA ITSE-2309-10X1
-- -----------------------------------------------------
-- DATABASE senicero				verifies that database does not exist, drops if does
-- -----------------------------------------------------
DROP DATABASE IF EXISTS senicero ;
-- -----------------------------------------------------
-- DATABASE senicero				creates the database, after verifying that it does not
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS senicero;
-- -----------------------------------------------------
-- Table senicero.customers			creates the customers table after verifying that database is in use and table does not exist
-- -----------------------------------------------------
USE senicero ;
DROP TABLE IF EXISTS senicero.customers ;
CREATE TABLE IF NOT EXISTS senicero.customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_first_name VARCHAR(50) NOT NULL,
    customer_last_name VARCHAR(50) NOT NULL,
    customer_address VARCHAR(255) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state CHAR(2) NOT NULL,
    customer_zip_code VARCHAR(20) NOT NULL,
    customer_phone VARCHAR(30) NOT NULL,
    customer_email VARCHAR(60) NULL DEFAULT NULL,
    customer_fax VARCHAR(30) NULL DEFAULT NULL,
    PRIMARY KEY (customer_id)
);
-- -----------------------------------------------------
-- Table senicero.products			creates the products table after verifying that database is in use and table does not exist
-- -----------------------------------------------------
DROP TABLE IF EXISTS senicero.products ;
CREATE TABLE IF NOT EXISTS senicero.products (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    product_description VARCHAR(100) NULL DEFAULT NULL,
    product_price DECIMAL(9 , 2 ) NOT NULL,
    PRIMARY KEY (product_id),
    UNIQUE INDEX product_name (product_name ASC , product_description ASC)
);
-- -----------------------------------------------------
-- Table senicero.orders				creates the orders table after verifying that database is in use and table does not exist
-- -----------------------------------------------------
DROP TABLE IF EXISTS senicero.orders ;
CREATE TABLE IF NOT EXISTS senicero.orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    shipping_date DATE NOT NULL,
    shipping_address VARCHAR(60) NOT NULL,
    shipping_city VARCHAR(30) NOT NULL,
    shipping_state VARCHAR(5) NOT NULL,
    shipping_zip_code VARCHAR(10) NOT NULL,
    shipping_country VARCHAR(15) NOT NULL,
    PRIMARY KEY (order_id),
    INDEX customer_id_idx (customer_id ASC),
    CONSTRAINT orders_ibfk_1 FOREIGN KEY (customer_id)
        REFERENCES senicero.customers (customer_id)
);
-- -----------------------------------------------------
-- Table senicero.order_details			creates the order_details table after verifying that database is in use and table does not exist
-- -----------------------------------------------------
DROP TABLE IF EXISTS senicero.order_details ;
CREATE TABLE IF NOT EXISTS senicero.order_details (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    order_qty INT NOT NULL,
    PRIMARY KEY (order_id , product_id),
    INDEX index1 (product_id ASC),
    CONSTRAINT order_details_ibfk_1 FOREIGN KEY (product_id)
        REFERENCES senicero.products (product_id),
    CONSTRAINT order_details_ibfk_2 FOREIGN KEY (order_id)
        REFERENCES senicero.orders (order_id)
);
-- -----------------------------------------------------
-- Table senicero.suppliers				creates the suppliers table after verifying that database is in use and table does not exist
-- -----------------------------------------------------
DROP TABLE IF EXISTS senicero.suppliers ;
CREATE TABLE IF NOT EXISTS senicero.suppliers (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(50) NOT NULL,
    supplier_address VARCHAR(50) NOT NULL,
    supplier_city VARCHAR(50) NOT NULL,
    supplier_state CHAR(2) NOT NULL,
    supplier_zip_code VARCHAR(20) NOT NULL,
    supplier_phone VARCHAR(20) NOT NULL,
    supplier_fax VARCHAR(50) NULL DEFAULT NULL,
    supplier_contact_first_name VARCHAR(50) NOT NULL,
    supplier_contact_last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (supplier_id)
);
-- -----------------------------------------------------
-- Table senicero.product_suppliers		creates the ps table after verifying that database is in use and table does not exist
-- -----------------------------------------------------
DROP TABLE IF EXISTS senicero.product_suppliers ;
CREATE TABLE IF NOT EXISTS senicero.product_suppliers (
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (supplier_id , product_id),
    INDEX product_id (product_id ASC),
    INDEX supplier_id_idx (supplier_id ASC),
    CONSTRAINT product_suppliers_ibfk_1 FOREIGN KEY (product_id)
        REFERENCES senicero.products (product_id),
    CONSTRAINT product_suppliers_ibfk_2 FOREIGN KEY (supplier_id)
        REFERENCES senicero.suppliers (supplier_id)
);
-- -----------------------------------------------------
-- Table senicero.customers  inserting data into customers table
-- -----------------------------------------------------
insert into customers values 
			(DEFAULT,'Nissy','Kleinbaum','601 Thackeray Terrace','Fairfax','VA','22036','571-369-0667','nkleinbaum0@dell.com','7866031184'),
			(DEFAULT,'Tedie','Strutt','38427 American Ash Point','Albuquerque','NM','87195','505-433-4287','tstrutt1@symantec.com','4325184887'),
			(DEFAULT,'Othilia','Streatfield','601 Bonner Lane','Kansas City','MO','64109','816-118-2487','ostreatfield2@archive.org','5091644351'),
			(DEFAULT,'Laurie','Hast','0 Dayton Road','Nashville','TN','37240','615-875-5430','lhast3@wordpress.com','2088883127'),
			(DEFAULT,'Hilda','Rosenzveig','59881 4th Lane','Humble','TX','77346','713-511-1554','hrosenzveig4@tinyurl.com','2819689264'),
			(DEFAULT,'Deloria','Crangle','57 Coolidge Park','Atlanta','GA','30323','770-314-2970','dcrangle5@webs.com','9159337034'),
			(DEFAULT,'Ira','Grigoriev','4 Dwight Circle','Wichita','KS','67215','316-514-7324','igrigoriev6@twitpic.com','2133437577'),
			(DEFAULT,'Binky','McNally','142 Nancy Lane','Philadelphia','PA','19120','267-761-7084','bmcnally7@slideshare.net','9175205012'),
			(DEFAULT,'Theo','Burdikin','537 Commercial Alley','Honolulu','HI','96820','808-207-8069','tburdikin8@bravesites.com','9514422045'),
			(DEFAULT,'Bancroft','Metham','8 Main Parkway','Baton Rouge','LA','70810','225-868-9173','bmetham9@twitter.com','5132881144');
-- -----------------------------------------------------
-- Table senicero.products  inserting data into products table
-- -----------------------------------------------------
insert into products values
			(DEFAULT,'Iridescent Coffee Beans', 'Coffee beans for iridescent coffee',19.75),
			(DEFAULT,'Pike Place Roast Verismo Pods','Coffee pods imported from Pike Plake DC',7.98),
			(DEFAULT,'Kenya Verismo Pods','Luxury Kenya coffee pods',43.92),
			(DEFAULT,'One Regular Coffee Bean','A single coffee bean',0.08),
			(DEFAULT,'Gallon Silver Vacuum Stainless Steel Tumbler','A stainless steel tumbler that can hold up to a gallon of coffee',12.99),
			(DEFAULT,'Original Black Coffee beans- 1 lb','Coffee Grind Original black coffee mix',11.95),
			(DEFAULT,'Original Hazelnut Coffee beans','Coffee Grind Original hazelnut coffee mix',11.95),
			(DEFAULT,'The Coffee Grind Holiday Blend','Coffee Grind Original Holiday mix',11.95),
			(DEFAULT,'Pumpkin Spice Chocolate Coffee Beans- 1 lb','Pumpkin spice coffee',7.95),
			(DEFAULT,'Decaf Christmas Chocolate Beans - 1 lb','Decaf holiday beans',11.95);
-- -----------------------------------------------------
-- Table senicero.suppliers  inserting data into suppliers table
-- -----------------------------------------------------
insert into suppliers values 
			(DEFAULT,'US Foods Holding Corp.','09733 Dennis Crossing','Indianapolis','IN','46266','317-481-9187','2536297967','Celestyna','Larkin'),
			(DEFAULT,'Exxon Foods Corporation','348 Sundown Court','Indianapolis','IN','46202','765-656-1233','4129321379','Giulio','Hawick'),
			(DEFAULT,'The Bon-Ton Stores,Inc.','7 Judy Crossing','Honolulu','HI','96850','808-591-2327','6026195972','Lauretta','Caine'),
			(DEFAULT,'Jounce Coffee Wholesale,Inc.','8616 Clemons Parkway','Albuquerque','NM','87190','505-103-8367','2027148413','Yanaton','Castilla'),
			(DEFAULT,'Marrone Container Innovations,Inc.','45 Parkside Pass','Detroit','MI','48267','313-155-8797','2024928003','Jessa','Saur');
-- -----------------------------------------------------
-- Table senicero.product_suppliers  inserting data into ps table
-- -----------------------------------------------------
insert into product_suppliers values
			(1,4),(1,6),(3,3),(3,4),(4,1),(4,4),(5,5),(5,2),(4,7),(3,8),
            (1,9),(3,10);
-- -----------------------------------------------------
-- Table senicero.orders  inserting data into orders table
-- -----------------------------------------------------
insert into orders values 
			(DEFAULT, 4, '2020-11-21', '2020-12-01', '54 Bartelt Road', 'New York City', 'NY', '10270', 'United States'),
			(DEFAULT, 1, '2020-11-24', '2020-12-24', '601 Thackeray Terrace','Fairfax','VA','22036', 'United States'),
			(DEFAULT, 7, '2020-11-03', '2020-12-21', '733 Hallows Terrace', 'Crossfield', 'AB', 'B0N', 'Canada'),
			(DEFAULT, 8, '2020-11-14', '2020-12-20', '5339 Rieder Center', 'Hicksville', 'NY', '11854', 'United States'),
			(DEFAULT, 4, '2020-11-22', '2020-12-17', '9371 Thierer Road', 'Baie-D''Urfé', 'QC', 'H9X', 'Canada'),
			(DEFAULT, 9, '2020-11-10', '2020-12-01', '15 North Street', 'Richmond', 'VA', '23237', 'United States'),
			(DEFAULT, 6, '2020-11-04', '2020-12-13', '39 Killdeer Hill', 'Pictou', 'NS', 'M1M', 'Canada'),
			(DEFAULT, 2, '2020-11-13', '2020-12-13', '9465 Portage Hill', 'Beaverlodge', 'AB', 'G8A', 'Canada'),
			(DEFAULT, 1, '2020-11-24', '2020-12-09', '8089 Elka Junction', 'Miguel Hidalgo', 'GRO', '39120', 'Mexico'),
			(DEFAULT, 4, '2020-11-15', '2020-12-13', '0 Dayton Road',   'Nashville',  'TN','37240', 'United States'),
			(DEFAULT, 3, '2020-11-18', '2020-12-08', '18 Reinke Place', 'Dante Delgado', 'VER', '96710', 'Mexico'),
			(DEFAULT, 7, '2020-11-20', '2020-12-26', '5 Texas Way', 'Chicago', 'IL', '60681', 'United States'),
			(DEFAULT, 8, '2020-11-13', '2020-12-21', '39954 Hanover Alley', 'Seattle', 'WA', '98104', 'United States'),
			(DEFAULT, 6, '2020-11-10', '2020-12-12', '47 Arkansas Trail', 'Kansas City', 'MO', '64190', 'United States'),
			(DEFAULT, 5, '2020-11-07', '2020-12-30', '4 Bayside Road', 'Austin', 'TX', '78732', 'United States'),
			(DEFAULT, 7, '2020-11-09', '2020-12-17', '4 Dwight Circle','Wichita','KS','67215', 'United States');
-- -----------------------------------------------------
-- Table senicero.order_details	inserting data into order_details table
-- -----------------------------------------------------
insert into order_details values
			(1,7, 1),(1,9, 1),(2, 3, 1),(2, 1, 1),(2, 9, 1),(2, 6, 1),(3, 8, 8),(4, 2, 1),(4, 8, 1),(4, 4, 1),
			(4, 5, 1),(5, 3, 1),(5, 5, 1),(5, 10, 1),(5, 6, 1),(5, 8, 1),(6, 2, 1),(6, 7, 1),(6, 8, 1),(7, 1, 1),
			(7, 5, 1),(8, 4, 2),(9, 8, 2),(9, 9, 1),(9, 10, 1),(10, 3, 1),(10, 5, 1),(10, 10, 1),(10, 6, 1),(10, 8, 1),
			(11, 4, 4),(11, 2, 2),(11, 6, 4),(12, 5, 1),(13, 2, 1),(13, 8, 1),(13, 4, 1),(13, 5, 1),(14, 3, 2),(15, 4, 2),
			(15, 1, 1),(15, 3, 1),(16, 6, 3);