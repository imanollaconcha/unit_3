FROM (SELECT sp.amount, sr.customer_id, sr.staff_id,sr.rental_id, si.store_id, sf.language_id, sf.rental_duration, sf.length, sf.replacement_cost, num_film_rent
FROM sakila.rental sr
JOIN sakila.payment sp
USING (customer_id)
JOIN sakila.inventory si
USING (inventory_id)
JOIN (SELECT inventory_id, COUNT(rental_id) num_film_rent
FROM rental
JOIN sakila.inventory si
USING (inventory_id)
JOIN sakila.film sf
USING (film_id)
GROUP BY inventory_id)sub1
USING(inventory_id)
JOIN sakila.film sf
USING (film_id)
WHERE rental_date BETWEEN '2005-01-01' AND '2005-12-31') sub2
JOIN (SELECT rental_id,
CASE 
WHEN rental_date BETWEEN '2005-08-01' AND '2005-08-31' THEN 'True'
ELSE 'False'
END AS  Renter_in_agust
FROM rental)sub3
USING (rental_id);

SELECT * 
FROM (SELECT sp.amount, sr.customer_id, sr.staff_id,sr.rental_id, si.store_id, sf.language_id, sf.rental_duration, sf.length, sf.replacement_cost, num_film_rent
FROM sakila.rental sr
LEFT JOIN sakila.payment sp
USING (customer_id)
JOIN sakila.inventory si
USING (inventory_id)
JOIN (SELECT inventory_id, COUNT(rental_id) num_film_rent
FROM rental
JOIN sakila.inventory si
USING (inventory_id)
JOIN sakila.film sf
USING (film_id)
GROUP BY inventory_id)sub1
USING(inventory_id)
JOIN sakila.film sf
USING (film_id)
WHERE rental_date BETWEEN '2005-01-01' AND '2005-12-31') sub2
LEFT JOIN (SELECT rental_id,
CASE 
WHEN rental_date BETWEEN '2005-08-01' AND '2005-08-31' THEN 'True'
ELSE 'False'
END AS  Renter_in_agust
FROM rental)sub3
USING (rental_id);
