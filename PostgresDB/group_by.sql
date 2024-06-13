select first_name fname, last_name lname from customer limit 20;

select upper(first_name) || ' ' || upper(last_name) as "Full Name" from customer limit 15;

SELECT 
   first_name || ' ' || last_name 
FROM 
   customer;

SELECT upper(f.title)
FROM film AS f
ORDER BY f.title
LIMIT 5;

SELECT 
  c.customer_id, 
  c.first_name, 
  p.amount, 
  p.payment_date 
FROM customer c 
INNER JOIN payment p ON p.customer_id = c.customer_id 
ORDER BY p.payment_date DESC limit 50 offset 12000;

SELECT 
  customer_id, 
  SUM (amount) 
FROM 
  payment 
GROUP BY 
  customer_id 
ORDER BY 
  customer_id;

SELECT 
  first_name || ' ' || last_name full_name, 
  SUM (amount) amount 
FROM 
  payment 
  INNER JOIN customer USING (customer_id) 
GROUP BY 
  full_name 
ORDER BY 
  amount DESC;

-- The following example uses a GROUP BY clause to group rows by values in two columns:
SELECT 
  customer_id, 
  staff_id, 
  SUM(amount) 
FROM 
  payment 
GROUP BY 
  staff_id, 
  customer_id 
ORDER BY 
  customer_id;


SELECT 
  payment_date::date payment_date, 
  SUM(amount) sum 
FROM 
  payment 
GROUP BY 
  payment_date::date
ORDER BY 
  payment_date DESC;

-- The HAVING clause specifies a search condition for a group. 

SELECT 
  customer_id, 
  SUM (amount) amount 
FROM 
  payment 
GROUP BY 
  customer_id 
HAVING 
  SUM (amount) > 200 
ORDER BY 
  amount DESC;

SELECT 
  store_id, 
  COUNT (customer_id) customer_id_count
FROM 
  customer 
GROUP BY 
  store_id 
HAVING 
  COUNT (customer_id) > 300;


