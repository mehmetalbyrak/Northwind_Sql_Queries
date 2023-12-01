-- Home_work 1 & 2  sql queries  -- 2B2 
-- Based on Nortwind database

-- 1. Selects product name and quantity per unit from products table
select product_name, quantity_per_unit
from products;

-- 2. Selects product ID and name from products table where discontinued is 0
select product_id, product_name
from products
where discontinued = 0;

-- 3. Selects product ID and name from products table where discontinued is 1
select product_id, product_name
from products
where discontinued = 1;

-- 4. Selects product ID, name, and unit price from products table where unit price is less than 20
select product_id, product_name, unit_price
from products
where unit_price < 20;

-- 5. Selects product ID, name, and unit price from products table
-- where unit price is less than 20 and greater than 15
select product_id, product_name, unit_price
from products
where unit_price < 20 and unit_price > 15;

-- 6. Selects product name, units on order, and units in stock from products table
-- where units in stock is less than units on order
select product_name, units_on_order, units_in_stock
from products
where units_in_stock < units_on_order;

-- 7. Selects product name from products table where the name starts with 'a'
select product_name
from products
where product_name like 'a%';

-- 8. Selects product name from products table where the name ends with 'i'
select product_name
from products
where product_name like '%i';

-- 9. Selects product name, unit price, and unit price with VAT (value-added tax) from products table 
select product_name, unit_price, (unit_price * 1.18) as unit_price_kdv
from products;

-- 10. Counts the number of products whose unit price is greater than 30 
select count(*) as product_counts
from products
where unit_price > 30;

-- 11. Selects lower case version of the product name and its unit price 
-- from the products table sorted by descending order of the unit price 
select lower (product_name) as lower_product_name, unit_price
from products
order by unit_price desc;

-- 12. Concatenates first name and last name of employees to create their full names 
select concat(first_name, ' ', last_name) as full_name
from employees;

-- 13. Counts the number of suppliers whose region is null 
select count(*) as suppliers_count
from suppliers
where region is null;

-- 14. Counts the number of suppliers whose region is not null 
select count(*) as suppliers_count
from suppliers
where region is not null;


-- 15. Concatenates 'TR' and upper case version of the product name from the products table 
select concat('TR ', upper(product_name)) as tr_product_name
from products;

-- 16. Concatenates 'TR' and the product name from the products table where the unit price is less than 20 
select concat('TR ', product_name) as tr_product_name
from products
where unit_price < 20;


-- 17. Select the product name and unit price of the product with the highest unit price.
select product_name, unit_price
from products
where unit_price = (select max(unit_price) from products);

-- 18. Select the product name and unit price of the top 10 products with the highest unit price.
select product_name, unit_price
from products
order by unit_price desc
limit 10;

-- 19. Select the product name and unit price of products with a unit price greater than the average unit price.
select product_name, unit_price
from products
where unit_price > (select avg(unit_price) from products);

-- 20. Select the product name and calculate the quantity sold
-- (units in stock - units on order) for products where units in stock are greater than units on order.
SELECT product_name, units_in_stock - units_on_order AS quantity_sold
FROM products
WHERE units_in_stock > units_on_order;

-- 21. Select product_id and product_name for products
-- that are not discontinued (discontinued = 0) or discontinued (discontinued = 1).
select product_id, product_name
from products
where discontinued = 0 or discontinued = 1;

-- 22. Select the count of products that are not discontinued and the count of products 
-- that are discontinued, along with the product names and category names for all products.
select 
    (select count(*) from products where discontinued = '0') as cont,
    (select count(*) from products where discontinued = '1') as discont;
select products.product_name, categories.category_name from products
inner join categories on products.category_id = categories.category_id;


-- 23. Select the category name and the average unit price of products in each category.
select categories.category_name, avg (products.unit_price) as avg_price from products
inner join categories on products.category_id = categories.category_id
GROUP BY Categories.Category_Name;

-- 24. Select the product name, unit price, and category name of the product with the highest unit price.
select products.product_name, products.unit_price, categories.category_name
from products
inner join categories on products.category_id = categories.category_id
order by products.unit_price desc
limit 1;

-- 25. Select the product name, category name, supplier company name 
-- and total quantity sold for the product with the highest total quantity sold.
-- The query joins multiple tables and groups the results.
select products.product_name, categories.category_name, suppliers.company_name,
sum(order_details.quantity) as total_quantity
from products
inner join categories on products.category_id = categories.category_id
inner join suppliers on products.supplier_id = suppliers.supplier_id
inner join order_details on products.product_id = order_details.product_id
group by products.product_name, categories.category_name, suppliers.company_name
limit 1;


-- 26. Selects product information with no stock (units_in_stock = 0)
-- including supplier details which are product_id, product_name, compnay_name and phone number
select products.supplier_id, products.units_in_stock, products.product_id,
products.product_name, suppliers.company_name, suppliers.phone
from products
inner join suppliers on products.supplier_id = suppliers.supplier_id
where products.units_in_stock = 0;

-- 27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı


-- 27. Selects --> order date, shipping address, first name, and last name
-- of employees associated with orders placed in the date range between March 1, 1998, and March 31, 1998.
select orders.order_date, orders.ship_address, employees.first_name, employees.last_name
from orders inner join employees on employees.employee_id = orders.employee_id
where orders.order_date >= '1998-03-01' and orders.order_date <= '1998-03-31';


-- 28. Select the count of orders made within the date range from February 1, 1997, to February 28, 1997.
select count(order_date) from orders
where order_date >= '1997-02-01' and order_date <= '1997-02-28';

-- 29. Select the count of orders that were shipped to the 'London' city
-- within the date range from January 1, 1998, to December 31, 1998.
select count(ship_city) from orders
where order_date >= '1998-01-01' and order_date <= '1998-12-31' and ship_city = 'London';

-- 30. Select the contact name, phone, and order date for customers
-- who placed orders between January 1, 1997, and December 31, 1997. 
select customers.contact_name, customers.phone, orders.order_date from customers
inner join orders on customers.customer_id = orders.customer_id
where order_date >= '1997-01-01' and order_date <= '1997-12-31';

-- 31. Select all from the 'orders' table where the 'freight' value is greater than 40.
select * from orders
where freight > 40;

-- 32. Select specific information from the 'orders' and 'customers' tables.
-- It selects the contact name, shipping city, and freight cost for orders
-- with a freight cost greater than or equal to 40. The results are ordered by the 'freight' column.
select customers.contact_name, orders.ship_city, orders.freight from orders 
inner join customers on orders.customer_id = customers.customer_id
where freight >= 40
order by orders.freight;

-- 33. Select details for orders in 1997, including order date, shipping city,
-- and the employee's uppercase full name. It filters orders placed between January 1, 1997,
-- and December 31, 1997, and associates them with the respective employees.
select upper(concat(employees.last_name, ' ' , employees.first_name)),
orders.order_date, orders.ship_city
from orders inner join employees 
on orders.employee_id = employees.employee_id
where order_date >= '1997-01-01' and order_date <= '1997-12-31';


-- 34. Select contact name and sanitized phone numbers of customers who placed orders in the year 1997.
-- It removes any parentheses, dots, spaces, or dashes from the phone numbers.
select customers.contact_name, regexp_replace(customers.phone, '[(). -]', '', 'g')
from orders
inner join customers
on orders.customer_id = customers.customer_id
where orders.order_date >= '1997-01-01' and orders.order_date <= '1997-12-31';


-- 35. Select the order date, customer contact name, and employee's first name and last name
-- by joining the 'orders', 'customers', and 'employees' tables.
select orders.order_date, customers.contact_name,
employees.first_name, employees.last_name
from orders
inner join customers 
on orders.customer_id = customers.customer_id
inner join employees 
on orders.employee_id = employees.employee_id;

-- 36. Selects the shipped date and required date from the 'orders' table
-- for orders where the shipped date is later than the required date.
select shipped_date, required_date from orders
where shipped_date > required_date;


-- 37. Select shipped date, required date, and customer contact name for late shipments.
select orders.shipped_date, orders.required_date, customers.contact_name
from orders 
inner join customers 
on orders.customer_id = customers.customer_id
where shipped_date > required_date;


-- 38. Select order details, including product name, category ID, and units on order,
-- for orders with ID 10248 by joining 'order_details', 'products', and 'categories'.
select order_details.order_id, products.product_name, categories.category_id,
products.units_on_order from  order_details
inner join products 
on order_details.product_id = products.product_id
inner join categories
on products.category_id = categories.category_id
where order_details.order_id = 10248;

-- 39. Select the supplier company name, order ID, and product name by joining the
-- 'order_details', 'products', and 'suppliers' tables.
-- It specifically selects data for orders with the ID 10248.
select suppliers.company_name, order_details.order_id, products.product_name
from order_details
inner join products
on order_details.product_id = products.product_id
inner join suppliers
on products.supplier_id = suppliers.supplier_id
where order_id = 10248;


-- 40. Select the employee's ID, first name, last name, product name, and quantity of orders
-- for a specific employee (ID = 3) within the date range of January 1, 1997, to December 31, 1997.
select employees.employee_id, employees.first_name, employees.last_name,
products.product_name, order_details.quantity from  orders 
inner join employees 
on orders.employee_id = employees.employee_id
inner join order_details
on orders.order_id = order_details.order_id
inner join products
on order_details.product_id = products.product_id
where employees.employee_id = 3 and orders.order_date >= '1997-01-01' and
orders.order_date < '1998-01-01';


-- 41. Select the employee ID, name, order quantity, and date for the highest quantity order in 1997.
-- Joins multiple tables and limits the result to the top entry.
select employees.employee_id, employees.first_name, employees.last_name,
order_details.quantity, orders.order_date from orders
inner join employees
on orders.employee_id = employees.employee_id
inner join order_details
on order_details.order_id = orders.order_id
inner join products
on order_details.product_id = products.product_id
where date_part('year', order_date) = 1997
order by order_details.quantity desc limit 1;



-- 42. Select the total order quantity for each employee in the year 1997 and selects
-- the employee with the highest total quantity.
-- It involves joining the 'order_details', 'orders', and 'employees' tables.
select employees.employee_id, employees.first_name, employees.last_name,
sum(order_details.quantity) from order_details
inner join orders
on order_details.order_id = orders.order_id
inner join employees 
on orders.employee_id = employees.employee_id
where date_part('year', order_date) = 1997 
group by employees.employee_id
order by sum(order_details.quantity) desc limit 1;

-- 43. Select the product with the highest unit price,
-- including its name, unit price, and category, by joining the
-- 'products' and 'categories' tables and ordering the results in descending order of unit price.
select products.product_name, products.unit_price, categories.category_name
from products
inner join categories on products.category_id = categories.category_id
order by unit_price desc
limit 1;


-- 44. Select a result set that includes employee names and order details.
-- Each order includes the first and last name of the employee who placed the order,
-- along with the order date. The results are sorted by the order date.
select employees.first_name, employees.last_name,
orders.order_id, orders.order_date from orders
inner join employees
on orders.employee_id = employees.employee_id
order by order_date;


-- 45. Selects the average unit price of products in each order
-- and retrieves the order date and order ID for the top 5 orders with the latest order date.
select avg(products.unit_price),
orders.order_date, orders.order_id
from orders
inner join order_details
on order_details.order_id = orders.order_id
inner join products 
on order_details.product_id = products.product_id
group by orders.order_date, orders.order_id 
order by orders.order_date desc limit 5;


-- 46. Select total quantity of products ordered in the month of January
-- and retrieves the category ID, category name, and product name for each product ordered.
-- It joins the 'order_details', 'orders', 'products', and 'categories' tables.
select sum(order_details.quantity), categories.category_id, categories.category_name,
products.product_name from order_details
inner join orders 
on order_details.order_id = orders.order_id
inner join products 
on order_details.product_id = products.product_id
inner join categories 
on products.category_id = categories.category_id
where date_part('month', order_date) = 1 
group by categories.category_id, categories.category_name, products.product_name;



-- 47. Selects the 'quantity' values from the 'order_details' table.
-- It filters and retrieves only the rows where 'quantity' is greater
-- than the average 'quantity' in the 'order_details' table.
-- The result is sorted in ascending order by 'quantity'.
select quantity from order_details
where quantity > (select avg(quantity)
from order_details)
order by quantity;


-- 48. Select the product with the highest quantity ordered, along with additional information.
-- It joins the 'order_details', 'orders', 'products', 'categories', and 'suppliers' tables.
-- The result is limited to the single product with the highest 'quantity', ordered in descending order.
select products.product_name, categories.category_name,
suppliers.company_name, order_details.quantity from order_details
inner join orders 
on order_details.order_id = orders.order_id
inner join products 
on order_details.product_id = products.product_id
inner join categories
on products.category_id = categories.category_id
inner join suppliers 
ON products.supplier_id = suppliers.supplier_id
order by quantity desc limit 1;


-- 49. Select the counts the number of distinct countries in the 'customers' table.
select count(distinct country)
from customers;


-- 50. Select the total sales revenue generated by a specific employee (Employee ID = 3)
-- for orders placed on or after January 1, 1998.
-- It joins the 'orders', 'employees', 'order_details', and 'products' tables.
select sum(order_details.quantity * products.unit_price) from orders
inner join employees
on orders.employee_id = employees.employee_id
inner join order_details
on order_details.order_id = orders.order_id
inner join products
on order_details.product_id = products.product_id
where employees.employee_id = 3 and order_date >= '1998.01.01';







































