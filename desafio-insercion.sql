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
