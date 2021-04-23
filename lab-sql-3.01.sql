USE sakila3;
-- 1. Drop column picture from staff.

ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE (first_name = 'TAMMY') and (last_name = 'SANDERS');
INSERT INTO staff(staff_id, first_name, last_name, address_id, email, store_id,active,username, password, last_update) 
VALUES
(3,'TAMMY','SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy',NULL,'2006-02-15 04:57:20');

SELECT * FROM staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
SELECT * FROM rental;
SELECT * FROM inventory;

SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Customer_id = 1

SELECT film_id FROM film
WHERE title = 'Academy Dinosaur';
-- film_id = 1

SELECT inventory_id FROM inventory
WHERE film_id = '1';

INSERT INTO inventory(inventory_id,film_id,store_id,last_update)
VALUES
(4582,1,1,'2021-04-05 16:59:00');

SELECT staff_id FROM staff
WHERE store_id = '1';
-- staff_id 1

INSERT INTO rental(rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
VALUES
('2021-04-05 16:00:00',4582,130,NULL,1,'2021-04-05 16:59:00');
-- staff_id = 1