-- Query 1
-- List the count of customers residing in NC and SC.
SELECT count(cust.customer_id) AS "customers", zip.state
FROM customers cust
INNER JOIN address addr 
ON cust.customer_id = addr.customer_id
INNER JOIN zip_code zip 
ON addr.zip_code = zip.zip_code 
GROUP BY state
HAVING state = "SC" OR state = "NC";

-- Query 2
-- Fnd total number of products, group by varietal
SELECT var.varietal_name, count(prod_d.product_id) AS "count"
FROM varietal var
INNER JOIN product_desc prod_d 
ON var.varietal_id = prod_d.varietal_id
GROUP BY var.varietal_name;


-- Query 3
-- Which wines have the highest order count? Select the top 10.
SELECT sum(ord_it.quantity) AS "order_count", prod.product_name
FROM order_items ord_it 
INNER JOIN products prod 
ON ord_it.product_id = prod.product_id
GROUP BY ord_it.product_id
ORDER BY order_count DESC
LIMIT 10;

-- Query 4
-- Find the product count remaining and their category for each product. Order from highest to lowest.
SELECT prod.product_name AS "Product Name", prod.available_qty AS "Qty",  
cat.category_name AS "Category Name" 
FROM products prod 
INNER JOIN categories cat 
ON prod.category_id = cat.category_id
ORDER BY Qty DESC;

-- Query 5
-- Total number of orders that have shipped and been delivered.
SELECT COUNT(order_status) AS "Number", order_status
FROM orders 
GROUP BY order_status 
HAVING order_status = 2 OR order_status = 3;

-- Query 6
-- List of wines with a abv (alcohol by volume) greater than or equal to 0.13
SELECT prod.product_name AS "Product Name", prod_d.abv AS "abv"
FROM products prod 
INNER JOIN product_desc prod_d
ON prod.product_id = prod_d.product_id
WHERE prod_d.abv >= 0.13;

-- Query 7
-- Gross amount earned from purchases for Armani Pinot Grigio Venezie product
-- What was the total amount received on _____ purchases?
SELECT bill.amount_paid, ord_it.product_id
FROM billing bill 
INNER JOIN order_items ord_it
ON ord_it.order_id = bill.order_id;

-- Query 8
-- List the products having an available quantity of less than 10 and their price.
-- Order by lowest price.
SELECT product_name, available_qty, list_price
FROM products
WHERE available_qty < 10
ORDER BY list_price;

-- Query 9
-- List all Cabernet wines and their abv (alcohol by volume) percentages
SELECT var.varietal_name, prod.product_name, prod_d.abv
FROM varietal var 
INNER JOIN product_desc prod_d 
ON var.varietal_id = prod_d.varietal_id 
INNER JOIN products prod 
ON prod.product_id = prod_d.product_id
WHERE var.varietal_id = 2;

-- Query 10
-- What is the most expensive Chardonnay in stock?
SELECT MAX(prod.list_price), prod.product_name
FROM products prod
INNER JOIN product_desc prod_d 
ON prod.product_id = prod_d.product_id 
WHERE prod_d.varietal_id = 6;

-- Query 11
-- Calculate the average price of Red blends
SELECT AVG(prod.list_price)
FROM products prod
INNER JOIN product_desc prod_d 
ON prod.product_id = prod_d.product_id 
WHERE prod_d.varietal_id = 3;


-- Query 12
-- Find 4 customers with addresses on Charles Street or having a zip code of 10896.
SELECT cust.first_name, cust.last_name, addr.street, addr.zip_code
FROM customers cust
INNER JOIN address addr 
ON cust.customer_id = addr.customer_id
WHERE addr.street LIKE '%Charles Street%' OR zip_code = '10896'
LIMIT 4;


-- VIEWS
-- 1 Current wines available and their type

CREATE VIEW ProductsAvailableAndType AS
(
	SELECT count(prod_d.product_id) AS "count", var.varietal_name 
	FROM varietal var
	INNER JOIN product_desc prod_d 
	ON var.varietal_id = prod_d.varietal_id
	GROUP BY var.varietal_name
)

-- 2
-- Product details and list price 
CREATE VIEW ProductDetailsAndPrice AS
(
	SELECT prod.product_name, prod.list_price 
	FROM products prod 
	RIGHT JOIN product_desc prod_d 
	ON prod.product_id = prod_d.product_id
)

