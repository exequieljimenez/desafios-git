DROP SCHEMA IF EXISTS film_database;
CREATE SCHEMA film_database;
USE film_database;

CREATE TABLE users(
	user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE lists(
	list_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    user_id INT NOT NULL, FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE directors(
	director_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE actors(
	actor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE genres(
	genre_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE countries(
	country_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE films(
	film_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    year INT NOT NULL,
    director_id INT NOT NULL, FOREIGN KEY (director_id)
    REFERENCES directors(director_id),
    actor_id INT NOT NULL, FOREIGN KEY (actor_id)
    REFERENCES actors(actor_id),
    genre_id INT NOT NULL, FOREIGN KEY (genre_id)
    REFERENCES genres(genre_id),
    country_id INT NOT NULL, FOREIGN KEY (country_id)
    REFERENCES countries(country_id)
);

CREATE TABLE film_acting(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    actor_id INT NOT NULL, FOREIGN KEY (actor_id)
    REFERENCES actors(actor_id),
    film_id INT NOT NULL, FOREIGN KEY (film_id)
    REFERENCES films(film_id)
);

CREATE TABLE film_genre(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre_id INT NOT NULL, FOREIGN KEY (genre_id)
    REFERENCES genres(genre_id),
    film_id INT NOT NULL, FOREIGN KEY (film_id)
    REFERENCES films(film_id)
);

CREATE TABLE film_origin(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL, FOREIGN KEY (country_id)
    REFERENCES countries(country_id),
    film_id INT NOT NULL, FOREIGN KEY (film_id)
    REFERENCES films(film_id)
);

CREATE TABLE film_list(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    list_id INT NOT NULL, FOREIGN KEY (list_id) REFERENCES lists(list_id),
    film_id INT NOT NULL, FOREIGN KEY (film_id) REFERENCES films(film_id)
);

CREATE TABLE played_lists(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    list_id INT NOT NULL, FOREIGN KEY (list_id) REFERENCES lists(list_id),
    user_id INT NOT NULL, FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE shared_lists(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    list_id INT NOT NULL, FOREIGN KEY (list_id) REFERENCES lists(list_id),
    user_id INT NOT NULL, FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO directors VALUES
(NULL, 'Chantal Akerman'),
(NULL, 'Alfred Hitchcock'),
(NULL, 'Orson Welles'),
(NULL, 'Ozu Yasujiro'),
(NULL, 'Wong Kar Wai');

INSERT INTO actors VALUES
(NULL, 'Delphine Seyrig'),
(NULL, 'James Stewart'),
(NULL, 'Orson Welles'),
(NULL, 'Setsuko Hara'),
(NULL, 'Maggie Cheung');

INSERT INTO genres VALUES
(NULL, 'Drama'),
(NULL, 'Thriller'),
(NULL, 'Romance');

INSERT INTO countries VALUES
(NULL, 'Belgium'),
(NULL, 'USA'),
(NULL, 'Japan'),
(NULL, 'Hong Kong');

INSERT INTO films VALUES
(NULL, 'Jeanne Dielman, 23 quai du Commerce, 1080 Bruxelles', 1975, 1, 1, 1, 1),
(NULL, 'Vertigo', 1958, 2, 2, 2, 2),
(NULL, 'Citizen Kane', 1941, 3, 3, 1, 2),
(NULL, 'Tokyo Story', 1953, 4, 4, 1, 3),
(NULL, 'In the Mood for Love', 2000, 5, 5, 3, 4);

#Vistas

#Vista de la tabla films
CREATE OR REPLACE VIEW every_film AS
SELECT * FROM films;

#Vista de título de films y años únicamente
CREATE OR REPLACE VIEW each_film_and_year AS 
	(SELECT name, year from films);

#Vistas de películas con la palabra "love"
CREATE OR REPLACE VIEW love_films AS
(SELECT name, year FROM films
WHERE name like upper('%love%'));

#Vista de películas según décadas específicas
CREATE OR REPLACE VIEW film_by_decades AS
(SELECT name, year FROM films
WHERE year BETWEEN 1950 AND 2000);

#Vista de títulos de películas con nombre de director
CREATE OR REPLACE VIEW film_and_director AS
(SELECT f.name film_title, d.name director_name
FROM films f 
JOIN directors d
ON f.director_id = d.director_id);

#Vista de títulos de películas con nombre del primer actor/actriz
CREATE OR REPLACE VIEW films_and_actors AS
(SELECT f.name film_title, a.name actor_name
FROM films f 
JOIN actors a 
ON f.actor_id = a.actor_id);

#Vista de títulos de películas indicando género y país de origen
CREATE OR REPLACE VIEW film_genre_country AS
(SELECT f.name film_title, g.name film_genre, c.name film_origin 
FROM films f 
JOIN genres g 
ON f.genre_id = g.genre_id
JOIN countries c 
ON f.country_id = c.country_id);



