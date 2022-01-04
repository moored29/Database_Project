/* 
Wine database creation 
Created: 11/01/2021
*/

------------ Table creation and relationships ------------

-- Categories table 
CREATE TABLE categories (
	category_id INT PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

-- Varietals table (wine types)

CREATE TABLE varietal (
	varietal_id INT PRIMARY KEY,
	varietal_name VARCHAR (255) NOT NULL
);

-- Products Table 

CREATE TABLE products (
	product_id CHAR(6) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	category_id INT NOT NULL, 
	list_price DECIMAL (6, 2) NOT NULL,
	available_qty INT NOT NULL,
	FOREIGN KEY (category_id) 
        REFERENCES categories (category_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Product descriptions table 

CREATE TABLE product_desc (
	product_id CHAR(6) NOT NULL,
	size CHAR (5),
	ABV DECIMAL(4,3),
	varietal_id INT NOT NULL,
	category_id INT NOT NULL
);

-- Customers table 

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL
);

-- Addresses table 

CREATE TABLE address (
	address_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	street VARCHAR (255),
	apt_number VARCHAR (50),
	customer_id INT NOT NULL,
	zip_code CHAR(5)
);

-- Zip codes tables

CREATE TABLE zip_code (
	zip_code CHAR (5) PRIMARY KEY,
	city VARCHAR (50),
	state VARCHAR (25)
);

-- Orders table 

CREATE TABLE orders (
	order_id CHAR(4) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Order Received; 2 = Shipped; 3 = Delivered; 
	order_date DATE NOT NULL,
	shipped_date DATE,
	FOREIGN KEY (customer_id) 
        REFERENCES customers (customer_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Order items table 
-- details of each order 

CREATE TABLE order_items(
	order_id CHAR(4),
	item_id CHAR(6),
	product_id CHAR(6) NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY (item_id),
	FOREIGN KEY (order_id) 
        REFERENCES orders (order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) 
        REFERENCES products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Payments table
-- payment type and information provided by the customer 

CREATE TABLE payments (
	payment_id CHAR (4) PRIMARY KEY NOT NULL,
	card_type VARCHAR(20) NOT NULL,
	card_number INT(12) NOT NULL,
	cvv INT(5) NOT NULL,
	name_on_card VARCHAR(25) NOT NULL,
	customer_id INT NOT NULL
);


-- Billing table 
-- amounts paid details 

CREATE TABLE billing (
	billing_id CHAR (5) NOT NULL PRIMARY KEY,
	amount_paid DECIMAL(10, 2) NOT NULL,
	payment_id CHAR(4) NOT NULL,
	order_id CHAR(4) NOT NULL
);

--Payments/Billing table relationships

ALTER TABLE payments
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE billing
ADD FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE billing
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders
ADD payment_id CHAR(4);

ALTER TABLE orders
ALTER COLUMN payment_id NOT NULL;

UPDATE orders
SET payment_id = 'P105'
WHERE order_id = 'O104';

