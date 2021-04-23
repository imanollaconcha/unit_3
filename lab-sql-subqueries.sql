USE sakila;
-- 1.How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(*) 
FROM inventory
WHERE film_id IN (
	SELECT film_id FROM (
		SELECT title, film_id FROM film
		WHERE title LIKE 'Hunchback Impossible'
		) sub1
    );

-- 2.List all films whose length is longer than the average of all the films.

SELECT title, length FROM film
WHERE length > (
  SELECT avg(length)
  FROM film
);

-- 3.Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name FROM sakila.actor
WHERE actor_id IN (
SELECT actor_id FROM (
	SELECT film_id, actor_id  FROM sakila.film_actor
		WHERE film_id IN (
			SELECT film_id FROM (
				SELECT film_id, title FROM sakila.film
				WHERE title = 'Alone Trip'
                ) sub1
			)
		)sub2
	);

-- 4.Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT film_id, title FROM film
WHERE film_id IN(
	SELECT film_id  FROM sakila.film_category
		WHERE category_id IN(
			SELECT category_id FROM sakila.category
			WHERE name LIKE 'Family'
			) 
        );

-- 5.Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
	
SELECT first_name, email FROM customer
WHERE address_id IN (
	SELECT address_id FROM address
		WHERE address_id IN (
			SELECT city_id FROM city
				WHERE country_id IN (
					SELECT country_id FROM country
					WHERE country LIKE 'Canada')
				)
               );
               

SELECT scu.first_name, scu.email, sco.country 
FROM sakila.country sco
JOIN sakila.city sci
USING(country_id)
JOIN sakila.address sa
USING (city_id)
JOIN sakila.customer scu
USING (address_id)
HAVING sco.country LIKE 'Canada';

-- 6.Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT title FROM film
WHERE film_id IN (
	SELECT film_id FROM film_actor
	WHERE actor_id IN(
	SELECT actor_id FROM(
			SELECT actor_id, COUNT(film_id) AS num_films
			FROM actor
			JOIN film_actor
			USING (actor_id)
			GROUP BY actor_id
			ORDER BY num_films DESC
			LIMIT 1) sub1
			)
            );


SELECT actor_id, COUNT(film_id) AS num_films
FROM actor
JOIN film_actor
USING (actor_id)
GROUP BY actor_id
ORDER BY num_films DESC;

-- 7.Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            inventory
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    rental
                WHERE
                    customer_id IN (SELECT 
                            customer_id
                        FROM
                            (SELECT 
                                sc.customer_id, SUM(sp.amount) AS Spent_money
                            FROM
                                sakila.customer sc
                            JOIN sakila.payment sp USING (customer_id)
                            GROUP BY customer_id
                            ORDER BY Spent_money DESC
                            LIMIT 1) sub1)));

-- 8.Customers who spent more than the average payments.

SELECT first_name, last_name
FROM customer
	WHERE customer_id IN (
	SELECT customer_id
        FROM (SELECT sp.customer_id, SUM(amount) AS spent_amount
            FROM sakila.payment sp
            GROUP BY customer_id
            HAVING spent_amount > (SELECT 
								AVG(spent_amount) AS avg_spent_amount
								FROM (SELECT sp.customer_id, SUM(amount) AS spent_amount
								FROM sakila.payment sp
								GROUP BY customer_id) sub1)
                                )sub2
                                );
                                
						