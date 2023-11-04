-- Postgresql Queries based on Northwind --> Written by Mehmet ALBAYRAK
-- Part 3 --> 2B2 

-- 61. Select the name of the best-selling product (in terms of quantity sold),
-- along with its category, supplier and order details
select products.product_name, categories.category_name,
suppliers.company_name, order_details.quantity from public.products
inner join public.categories on products.category_id = categories.category_id
inner join public.suppliers on products.supplier_id = suppliers.supplier_id
inner join public.order_details on order_details.product_id = products.product_id
order by order_details.quantity desc limit 1;


-- 62. Select count the number of distinct countries in the 'customers' table
select count(distinct country) from customers;


-- 63. Select count the number of customers for each country
select count(customer_id), country from customers
group by country
order by count;


-- 64. Select the total revenue for orders handled by employee with ID 3 since January 1, 1998
select sum(order_details.quantity * order_details.unit_price) from orders
inner join employees on orders.employee_id = employees.employee_id
inner join order_details on order_details.order_id = orders.order_id
where employees.employee_id = 3 and orders.order_date >= '1998-01-01';


-- 65. Select the revenue for product ID 10 within the last 3 months since May 31, 1998.
select od.product_id, sum(od.quantity * od.unit_price)
from order_details od
join orders o on od.order_id = o.order_id
where od.product_id = 10 and o.order_date >= date '1998-05-31' - interval '3 months'
group by od.product_id;


-- 66. Select the total quantity of products ordered by each employee.
select sum(order_details.quantity), orders.employee_id,
employees.first_name, employees.last_name from orders
inner join employees on orders.employee_id = employees.employee_id
inner join order_details on orders.order_id = order_details.order_id
group by orders.employee_id, employees.first_name, employees.last_name;


-- 67. Selects identify the two customers out of 91 who have not placed any orders
select company_name, order_id from orders 
right join customers on customers.customer_id = orders.customer_id
where orders.order_id is null
order by company_name;


-- 68. Select the company name, contact name, address, city & country of customers in Brazil
select company_name, contact_name, address, city, country from customers
where country = 'Brazil' order by company_name;


-- 69. Select customers who are not located in Brazil
select company_name, contact_name, address, city, country
from customers where country != 'brazil' order by company_name;


-- 70. Select customers from either Spain, France, or Germany
select company_name, country from customers
where country = 'Spain' or country = 'France' or country = 'Germany'
order by country;


-- 71. Select customers for whom the fax number is not provided
select company_name, fax from customers
where fax is null order by company_name;


-- 72. Select customer informations for those located in either London or Paris
select company_name, contact_name, address, city, country from customers
where city = 'London' or city= 'Paris' order by city;


-- 73. Select customers residing in Mexico city (mexico d.f.) with the contact title 'owner'
select company_name, contact_name, address, city, country from customers
where city = 'México D.F.' and contact_title = 'Owner';


-- 74. Select the list product names and prices for products whose names start with the letter 'c'
select product_name, unit_price from products
where lower(product_name) like 'c%';


-- 75. Select employees whose first names start with the letter 'a,' along with their last names
-- and birth dates
select  first_name, last_name, birth_date from employees
where lower(first_name) like 'a%';


-- 76. Select customers whose company names contain 'restaurant'
select company_name from customers
where lower(company_name) like '%restaurant%';


-- 77. Select the names and prices of products priced between $50 and $100
select product_name, unit_price from products
where unit_price between 50 and 100
order by unit_price;


-- 78. Select order id and order date for orders placed between July 1, 1996 & December 31, 1996
select order_id, order_date from orders
where order_date between '1996-07-01' and '1996-12-31';


-- 79. Select list customers whose countries are either Spain, France or Germany ordered by country
select country, company_name from customers
where country = 'Spain' or country = 'France' or country = 'Germany'
order by country;


-- 80. Select customers for whom the fax number is not provided and order the results by company name
select company_name, fax from customers
where fax is null
order by company_name;


-- 81. Select --> sort and display the customers by their respective countries
select distinct country, company_name from customers
order by country;


-- 82. Select --> sort products from the most expensive to the least expensive
-- and display their names and prices
select product_name, unit_price from products
order by unit_price desc;


-- 83. Select --> sort products from the most expensive to the least expensive
-- and within the same price range, sort them by stock quantity.
-- Display product names, prices, and stock quantities
select product_name, unit_price, units_in_stock from products
order by unit_price desc, units_in_stock asc;


-- 84. Select the count of products in category 1.
select count(*) product_count, category_id
from products
where category_id = 1
group by category_id;


-- 85. Select the count of different countries to which your company exports
select count(distinct country)
from customers;


-- ** SQL QUERIES IS DONE ** --
