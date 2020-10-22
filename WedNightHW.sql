-- Wednesday's Homework
--1. List all customers who live in Texas (use JOINs) 

SELECT customer.address_id,district,customer.first_name,customer.last_name
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
WHERE district = 'Texas'

--2. Get ALL payments above $6.99 WITH the Customer's Full Name 
SELECT first_name, last_name, customer.customer_id, amount  -- Full Name and amount even though it is not in customer folder
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99;

--3.Show ALL customers NAMES who have made payments over $175(use subqueries) 

SELECT first_name, last_name, customer_id 
FROM customer
WHERE customer_id IN(
	SELECT customer_id  
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY first_name, last_name, customer_id;

--4.List ALL customers that live in NEPAL (use the city table) -- I am stomped 
SELECT first_name, last_name, address.city_id, city
FROM customer
INNER JOIN CITY
ON address.city_id = city.city_id
WHERE city = 'Nepal';


--5.Which staff member had the most transactions? 
SELECT COUNT (DISTINCT payment_id), staff_id  -- Use DISTINCT when you want to know how many or count specifc items
FROM payment
GROUP BY staff_id;


--6. How many movies of each rating are there? 
SELECT COUNT (DISTINCT film_id), rating  
FROM film
GROUP BY rating;


--7.Show ALL customers who have made a SINGLE payment above $6.99 (Use Subqueries)
SELECT first_name, last_name, customer_id 
FROM customer
WHERE customer_id IN(
	SELECT customer_id  -- Question: How do we get the amount to show 
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 6.99
	ORDER BY SUM(amount) ASC
)
GROUP BY first_name, last_name, customer_id;

--8. How many FREE rentals did our STORES give away?
SELECT COUNT (payment_id)
FROM payment
WHERE amount = 0;
