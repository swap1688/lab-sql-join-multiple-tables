# Lab | SQL Joins on multiple tables
USE sakila;

### Instructions

# 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id,c.city,co.country
FROM store s
JOIN address a
ON a.address_id=s.address_id
JOIN city c
ON c.city_id=a.city_id
JOIN country co
ON co.country_id=c.country_id;


# 2. Write a query to display how much business, in dollars, each store brought in.
SELECT a.address, s.store_id,sum(p.amount) as total_business
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
JOIN inventory i
ON i.inventory_id = r.inventory_id
JOIN store s
ON s.store_id = i.store_id
JOIN address a
ON a.address_id = s.address_id
GROUP BY s.store_id;


# 3. What is the average running time of films by category?
SELECT c.name, avg(f.length)
FROM film f
JOIN film_category fc
ON fc.film_id=f.film_id
JOIN category c
ON c.category_id=fc.category_id
GROUP BY c.name;

# 4. Which film categories are longest?
SELECT c.name, avg(f.length) as avg_length
FROM film f
JOIN film_category fc
ON fc.film_id=f.film_id
JOIN category c
ON c.category_id=fc.category_id
GROUP BY c.name
ORDER BY avg_length
LIMIT 5;

# 5. Display the most frequently rented movies in descending order.    
SELECT f.title, COUNT(f.title) as rentals
FROM film f
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title 
ORDER BY rentals DESC;

# 6. List the top five genres in gross revenue in descending order.
SELECT c.name as category, sum(p.amount) as gross_revenue
FROM category c
JOIN film_category
USING (category_id)
JOIN film
USING (film_id)
JOIN inventory
USING (film_id)
JOIN rental
USING (inventory_id)
JOIN payment p
USING (rental_id)
GROUP BY c.name
ORDER BY sum(p.amount) desc
LIMIT 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, s.store_id, COUNT(*) as available
FROM store s
JOIN inventory i
USING (store_id)
JOIN film f 
USING (film_id)
JOIN rental r
USING (inventory_id)
WHERE f.title = "Academy Dinosaur" AND s.store_id = 1 AND r.return_date IS NOT NULL;

