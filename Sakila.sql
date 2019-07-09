-- Sakila Project
-- Reza Akhlaqi 	7-8-2019


-- 1
-- What query would you run to get all the customers inside city_id = 312? 
-- Your query should return customer first name, last name, email, and address
-- // here we have to use three table (city, costumer, and address) address can be joined with city by city id, costumer can be joined with address with address_id
-- // so we select tables and their cloumns from city and joins need to be in order. address to city first and then costumer to address
-- // also, we using city.city_id as our filter at end for WHERE (again we have to select from city)

SELECT 
city.city_id, city.city as City, 
customer.first_name as First_Name, customer.last_name as Last_Name, 
customer.email as Email, customer.address_id
FROM city
JOIN address ON city.city_id = address.city_id
JOIN customer ON address.address_id = customer.address_id
WHERE city.city_id = 312;




-- 2
--  What query would you run to get all comedy films? 
-- Your query should return film title, description, release year, rating, special features, and genre (category)
-- // here we need to select from(film and category) tables. but we need the film_category tables later to make a join
-- // need to right join the category by category_id

SELECT 
film.film_id as Film_ID, film.title as Film_Title,
film.description as Description, film.release_year as Release_Year, film.rating as Rating,
film.special_features, category.name as Genere
FROM film
JOIN film_category ON film.film_id = film_category.film_id
RIGHT JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "comedy";



-- 3
-- What query would you run to get all the films joined by actor_id=5? 
-- Your query should return the actor id, actor name, film title, description, and release year
-- //need to select actor and film tables from film. Also, use film_actor table to use join command.
-- // because we use film_actor.film_id we need to select from film. (matched with film not actor) 
-- // the second join will be actor on film by actor_id
-- // to get the Actor full name we need to concat both first_name and last_name columns together 

SELECT 
actor.actor_id, CONCAT(actor.first_name, " ", actor.last_name) AS Actor_Name,
film.film_id, film.title, film.description, film.release_year
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.actor_id = 5;





-- 4
-- What query would you run to get all the customers in store_id = 1 and inside these cities (1, 42, 312 and 459)? 
-- Your query should return customer first name, last name, email, and address
-- // we select store, city, costumer, and address tables from store. So, we need theree joins to store 
-- // first, join costumer on store by store_id
-- // second, join address on costumer by address_id
-- // third, join city on address by city_id 
-- // where we have the asked store_id and (four cities). because we all city_id's are the same column, all in pranteses and seperate with "or"

SELECT 
store.store_id, 
city.city_id, 
customer.first_name, customer.last_name, customer.email, 
address.address
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE store.store_id = 1 
and (
city.city_id = 1 or
city.city_id = 42 or 
city.city_id = 312 or 
city.city_id = 459)



-- 5
-- What query would you run to get all the films with a "rating = G" and "special feature = behind the scenes", joined by actor_id = 15? 
-- Your query should return the film title, description, release year, rating, and special feature. 
-- Hint: You may use LIKE function in getting the 'behind the scenes' part
-- // ths funcion we using to get some part of the text is "LIKE" and %the asked text%
-- // here we select tables of films from film but need to jpin actor and film_actor later

SELECT 
film.film_id, film.title as Film_Title, film.description as Description,
film.release_year, film.rating, film.special_features
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.rating = "G" 
and (
film.special_features LIKE  '%behind the scenes%' 
and actor.actor_id = 15)
ORDER BY film.film_id asc; 




-- 6
-- What query would you run to get all the actors that joined in the film_id = 369? 
-- Your query should return the film_id, title, actor_id, and actor_name
-- // we select film and actor tables from film. we use film_actor later to join
-- // need to concat the two columns of first_name and last_name of the actor
-- // join film_actor on film by film_id
-- // join actor on film by actor_id

SELECT 
film.film_id, film.title as Film_Title,
actor.actor_id, CONCAT(actor.first_name, " ", actor.last_name) AS Actor
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.film_id = 369
ORDER BY actor.actor_id asc;



-- 7
-- What query would you run to get all drama films with a rental rate of 2.99? 
-- Your query should return film title, description, release year, rating, special features, and genre (category)
-- // select film and category tables from film. we use film_category to join film later
-- // join film_category on film by film_id
-- // join category on film_category by category_id

SELECT 
film.film_id, film.title as Film_Title, film.description, 
film.release_year, film.rating, film.special_features, 
category.name as Genre, film.rental_rate
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.rental_rate = 2.99 
and category.name = "Drama"
order by film.film_id asc;





-- 8
-- What query would you run to get all the action films which are joined by SANDRA KILMER? 
-- Your query should return film title, description, release year, rating, special features, genre (category), and actor's first name and last name
-- // need to concat the firt name and last name of the actor to fit in one column
-- // select actor, film, and category from film. we join film_category and film_actor later to make the query
-- // join film_actor on actor by actor_id
-- // join film on film_actor by film_id
-- // join film_category on film by film_id
-- // join category on film_category by category_id
-- // where actor.first_name and actor.last_name and category.name matched


SELECT 
actor.actor_id, CONCAT(actor.first_name, " ", actor.last_name) as Actor_Name,
film.film_id, film.title as Film_Title, film.description,
film.release_year, film.rating, film.special_features, 
category.name as Genre
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.first_name = "SANDRA" 
and actor.last_name = "KILMER" 
and category.name = "Action"
ORDER BY film.film_id asc;

















