-- Postgresql Queries based on Northwind --> Written by Mehmet ALBAYRAK
-- Part 4 --> 2B2

-- 86. Select distinct ship_country values from the "orders" table and
-- counts how many times each ship_country appears,
-- ordering the results by ship_country.
select distinct ship_country, count(ship_country)
from orders
group by ship_country
order by ship_country;



-- 87. Select the top 5 most expensive products by
-- their unit prices from the "products" table and ordering them in descending order.
select unit_price from products
order by unit_price desc
limit 5;



-- 88. Select count the number of orders for customer 'ALFKI' and
-- name the result as 'orderCounts'.
select count(*) as orderCounts from orders 
where customer_id='ALFKI';



-- 89. Select the total cost of products
select sum(unit_price * units_in_stock) as totalCost
from products;



-- 90. Select calculate the total cost of items in order details.
select sum(unit_price * quantity) from order_details;



-- 91. Select calculate the average unit price of products and alias it as 'averagePrice'.
select avg(unit_price) as averagePrice from products;



-- 92. Select the product with the highest unit price.
select product_name, unit_price from products
order by unit_price desc
limit 1;



-- 93. Select the order with the minimum gain (unit_price * quantity).
select order_id, min(unit_price * quantity) as minGain
from order_details
group by order_id
order by minGain
limit 1;



-- 94. Select the customer with the longest company name.
select customer_id, company_name
from customers
order by length(company_name) desc
limit 1;



-- 95. Select the first name, last name, and age of employees.
select first_name, last_name, extract(year from age(birth_date))
as age from employees;



-- 96. Select the total sales quantity for each product and order the results
-- by total sales in descending order.
select products.product_name, sum(order_details.quantity) as totalsale
from products
join order_details on products.product_id = order_details.product_id
group by products.product_name
order by totalsale desc;



-- 97. Select the total gain for each order and show the result with the
-- corresponding order ID.
select orders.order_id, sum(order_details.unit_price * order_details.quantity)
as totalGain from orders
inner join order_details on orders.order_id = order_details.order_id
group by orders.order_id;



-- 98. Select count the number of products in each category and display the category name.
select categories.category_name, count(products.product_id) from categories
inner join products on categories.category_id = products.category_id
group by categories.category_name order by count;



-- 99. Select the total quantity of each product sold,
-- filter products with a total quantity greater than 1000,
-- and display the results in ascending order of total quantity.
select products.product_name,
sum(order_details.quantity) from products
inner join order_details ON products.product_id = order_details.product_id
group by products.product_name
having sum(order_details.quantity) > 1000
order by sum;



-- 99 v2. Alternative approach without using "having" and using alias as "subquery"
select product_name, total_quantity
from   (select products.product_name, sum(order_details.quantity)
as total_quantity from products
inner join order_details on products.product_id = order_details.product_id
group by products.product_name) as subquery
where total_quantity > 1000
order by total_quantity;



-- 100. Select customers who have not placed any orders.
select customer_id, company_name from customers
where not exists (select 1 from orders
where customers.customer_id = orders.customer_id);



-- 101. Select a list of suppliers and their associated products,
-- ordered by supplier and product.
select suppliers.company_name as supplier, products.product_name
as product from suppliers
join products on suppliers.supplier_id = products.supplier_id
order by supplier, product;



-- 102. Select the order ID, shipper name, and shipped date for each order.
select orders.order_id as OrderID, shippers.company_name as ShipperName,
orders.shipped_date as ShippedDate from orders
inner join shippers on orders.ship_via = shippers.shipper_id;



-- 103. Select the order ID and customer name for each order.
select orders.order_id as orderId, customers.contact_name as customerName from orders
inner join customers on orders.customer_id = customers.customer_id;



-- 104. Select count the number of orders handled by each employee,
-- displaying their first name and last name.
select first_name, last_name, count(*) from employees
inner join orders on employees.employee_id = orders.employee_id
group by employees.employee_id order by count;



-- 105. Select the employee with the highest number of orders,
-- displaying their first name and last name. Limit the result to one record.
select first_name, last_name, count(*) from employees
inner join orders on employees.employee_id = orders.employee_id
group by employees.employee_id
order by count desc limit 1;



-- 106. Select the order ID, employee's first name, employee's last name,
-- and customer's company name for each order.
select orders.order_id, employees.first_name, employees.last_name,
customers.company_name from orders
inner join customers on orders.customer_id = customers.customer_id
inner join employees on orders.employee_id = employees.employee_id;



-- 107. Select the product ID, product name, category name, and supplier's company name
-- for each product.
select products.product_id, products.product_name, categories.category_name,
company_name from products
inner join suppliers on suppliers.supplier_id = products.supplier_id
inner join categories on categories.category_id = products.category_id;



-- 108. Select a comprehensive list of orders,
-- including order details, customer information, shipping details, product details,
-- category names, and supplier names.
select
orders.order_id,
customers.company_name,
customers.contact_name,
orders.shipped_date,
orders.ship_name,
products.product_name,
order_details.quantity,
categories.category_name,
suppliers.company_name
from orders 
inner join order_details on order_details.order_id = orders.order_id
inner join customers on customers.customer_id = orders.customer_id
inner join products on products.product_id = order_details.product_id
inner join suppliers on suppliers.supplier_id = products.supplier_id
inner join categories on categories.category_id = products.category_id;



-- 109. Select categories and their associated products where
-- no products are present in the category.
select categories.category_id, categories.category_name, products.product_name
from categories left join products on categories.category_id = products.category_id
where products.product_id is null;



-- 110. Select customer contact information (name, company, and title)
-- for customers with a title ending in 'Manager'.
select contact_name, company_name, contact_title
from customers where contact_title like '%Manager';



-- 111. Select customer IDs and company names for customers with IDs
-- starting with 'FR' and having a length of 5 characters.
select customer_id, company_name from customers
where customer_id like 'FR%' and length(customer_id) = 5;



-- 112. Select company names and phone numbers for customers
-- with phone numbers starting with '(171)'.
select company_name, phone from customers
where phone like '(171)%';



-- 113. Select product names and quantity per unit for products with
-- 'boxes' mentioned in the quantity per unit.
select product_name, quantity_per_unit from products
where quantity_per_unit like '%boxes%';



-- 114. Select company names, contact names, and phone numbers for customers
-- in France or Germany with a title ending in 'Manager' along ordered by country
select company_name, contact_name, phone, country from customers
where (country = 'France' or country = 'Germany') and contact_title like '%Manager'
order by country;



-- 115. Select the product names and unit prices, ordered by unit price
-- in descending order, and limit the result to the top 10.
select product_name, unit_price from products
order by unit_price desc
limit 10;



-- 116. Select company names, countries, and cities of customers,
-- ordered by country and city.
select company_name, country, city
from customers
order by country, city;



-- 117. Select the first name, last name, and age of employees.
select first_name, last_name, extract(year from age(birth_date)) as age
from employees;



-- 118. Select orders where the difference between the shipped date and order date is at least 35 days.
select order_date, shipped_date, (shipped_date - order_date) as differencedays
from orders where (shipped_date - order_date) >= 35;



-- 119. Select the product name, unit price, category ID, and
-- category name of the most expensive product.
select product_name, unit_price, products.category_id, categories.category_name
from products join categories on products.category_id = categories.category_id
order by unit_price desc
limit 1;



-- 120. Select product names and their corresponding category names
-- where the category name contains 'on'.
select products.product_name, categories.category_name from products
join categories on products.category_id = categories.category_id
where categories.category_name like '%on%';



-- 121. Select the total sales quantity of the product 'Konbu.'
select products.product_name, sum(order_details.quantity) as totalsalesquantity
from products join order_details on products.product_id = order_details.product_id
where products.product_name = 'Konbu'
group by products.product_name;



-- 122. Select count the number of distinct product IDs from suppliers
-- in Japan and display the country.
select count(distinct products.product_id) as differentproductcount,
suppliers.country as country from products
join suppliers on products.supplier_id = suppliers.supplier_id
where suppliers.country = 'Japan'
group by suppliers.country;



-- 123. Select the maximum, minimum, and average shipping fees for
-- orders placed in the year 1997.
select
    max(freight) as maxshippingfee,
    min(freight) as minshippingfee,
    avg(freight) as avgshippingfee
from orders where extract(year from order_date) = 1997;



-- 124. Select the city, address, and fax number for customers with a non-empty fax.
select city, address, fax
from customers
where fax is not null and fax != ''
order by city;



-- 125. Select the ship city, ship name, and shipped date for orders shipped
-- between July 16, 1996, and July 30, 1996, ordered by shipped date.
select ship_city, ship_name, shipped_date from orders
where orders.shipped_date between '1996-07-16' and '1996-07-30'
order by shipped_date;

























































