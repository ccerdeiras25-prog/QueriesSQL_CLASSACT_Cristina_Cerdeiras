-- INSTRUCCIONES -----------------------------------------------------------------------------
USE sakila;
-- 1. ¿Cuántos apellidos de actores distintos hay?
SELECT COUNT(DISTINCT last_name) AS distinct_last_names FROM actor;

-- 2. ¿En cuántos idiomas diferentes se produjeron originalmente las películas?
SELECT COUNT(DISTINCT language_id) AS distinct_languages FROM film;

-- 3. ¿Cuántas películas se estrenaron con clasificación "PG-13"?
SELECT COUNT(*) AS pg13_movies FROM film
WHERE rating = 'PG-13';

-- 4. Consigue 10 de las películas más largas del 2006.
SELECT title, release_year, length FROM film
WHERE release_year = 2006 
ORDER BY length DESC
LIMIT 10;

-- 5. ¿Cuántos días lleva funcionando la empresa? (Suponiendo que rental tiene la fecha más antigua de actividad)
SELECT DATEDIFF(CURDATE(), MIN(rental_date)) AS days_in_operation
FROM rental;

-- 6. Mostrar información de alquiler con columnas adicionales por mes y día laborable. Obtener 20 resultados.
SELECT rental_id, rental_date, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day 
FROM rental
LIMIT 20;

-- 7. Agregue una columna adicional day_type con valores 'weekend' y 'workday'.
SELECT rental_id, rental_date, 
CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'ELSE 'workday'END AS day_type 
FROM rental
LIMIT 20;

-- 8. ¿Cuántos alquileres hubo en el último mes de actividad?
SELECT COUNT(*) AS rentals_last_month FROM rental
WHERE MONTH(rental_date) = (SELECT MONTH(MAX(rental_date)) FROM rental)
AND YEAR(rental_date) = (SELECT YEAR(MAX(rental_date)) FROM rental);

-- 9. ¿Cuántas películas hay por categoría?
SELECT c.name, COUNT(fc.film_id) AS film_count FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id
GROUP BY c.name;

-- 10. Obtenga los ingresos totales por cliente.
SELECT customer_id, SUM(amount) AS total_revenue FROM payment
GROUP BY customer_id;

-- 11. Cuente el número de películas estrenadas cada año.
SELECT release_year, COUNT(*) AS film_count FROM film
GROUP BY release_year;

-- 12. Cuenta cuántos actores hay en cada película.
SELECT film_id, COUNT(actor_id) AS actor_count FROM film_actor
GROUP BY film_id;

-- 13. Obtenga los pagos promedio por tienda.
SELECT s.store_id, AVG(p.amount) AS avg_payment FROM store s
JOIN customer c 
ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 14. Mostrar categorías que tienen más de 10 películas.
SELECT c.name, COUNT(fc.film_id) AS film_count FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
HAVING film_count > 10;

-- 15. Mostrar clientes que han realizado más de 5 pagos.
SELECT customer_id, COUNT(*) AS payment_count FROM payment
GROUP BY customer_id
HAVING payment_count > 5;

-- 16. Mostrar los años que tienen un pago promedio mayor a 20.
SELECT YEAR(payment_date) AS year, AVG(amount) AS avg_payment FROM payment
GROUP BY YEAR(payment_date)
HAVING avg_payment > 20;

-- 17. Mostrar películas que tengan más de 3 actores.
SELECT f.title, COUNT(fa.actor_id) AS actor_count FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id
HAVING actor_count > 3;

-- 18. Obtener clasificaciones de películas.
SELECT DISTINCT rating FROM film;

-- 19. Obtener años de liberación.
SELECT DISTINCT release_year FROM film;

-- 20. Obtener todas las películas con "ARMAGEDDON" en el título.
SELECT title FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- 21. Obtener todas las películas con "APOLLO" en el título.
SELECT title FROM film
WHERE title LIKE '%APOLLO%';

-- 22. Obtener todas las películas cuyo título termina en "APOLLO".
SELECT title FROM film
WHERE title LIKE '%APOLLO';

-- 23. Obtener todas las películas con la palabra "DATE" en el título.
SELECT title FROM film
WHERE title LIKE '%DATE%';

-- 24. Consigue 10 películas con el título más largo.
SELECT title, LENGTH(title) AS title_length FROM film
ORDER BY title_length DESC
LIMIT 10;

-- 25. Consigue 10 de las películas más largas.
SELECT title, length FROM film
ORDER BY length DESC
LIMIT 10;

-- 26. ¿Cuántas películas incluyen contenido "Behind the Scenes"?
SELECT COUNT(*) AS behind_scenes_count FROM film
WHERE special_features LIKE '%Behind the Scenes%';

-- 27. Lista de películas ordenadas por año de estreno y título alfabéticamente.
SELECT title, release_year FROM film
ORDER BY release_ye