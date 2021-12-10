DROP DATABASE IF EXISTS wine_db;
CREATE DATABASE wine_db;
USE wine_db;

CREATE TABLE categories (
	category_id INT PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE varietal (
	varietal_id INT PRIMARY KEY,
	varietal_name VARCHAR (255) NOT NULL
);


CREATE TABLE products (
	product_id CHAR(6) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	category_id INT NOT NULL, 
	list_price DECIMAL (10, 2) NOT NULL,
	available_qty INT NOT NULL,
	FOREIGN KEY (category_id) 
        REFERENCES categories (category_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE product_desc (
	product_id CHAR(6) NOT NULL,
	size CHAR (5),
	ABV DECIMAL(4,3),
	varietal_id INT NOT NULL,
	category_id INT NOT NULL
);

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL
);

CREATE TABLE address (
	address_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	street VARCHAR (255),
	apt_number VARCHAR (255),
	customer_id INT NOT NULL,
	zip_code CHAR (5)
);

CREATE TABLE zip_code (
	zip_code CHAR (5) PRIMARY KEY,
	city VARCHAR (50),
	state VARCHAR (25)
);

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