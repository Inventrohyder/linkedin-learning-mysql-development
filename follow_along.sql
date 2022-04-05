-- Create the Database
CREATE DATABASE movies;

-- Create the movies_basic table
CREATE TABLE movies.movies_basic (
    id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(100),
    genre VARCHAR(200),
    release_year INT,
    director VARCHAR(40),
    studio VARCHAR(30),
    critic_rating DECIMAL(2, 1) DEFAULT 0,
    PRIMARY KEY(id)
);

-- Alter the movies_basic table
ALTER TABLE movies_basic
ADD COLUMN box_office_gross FLOAT,
RENAME COLUMN critic_rating TO critics_rating,
CHANGE COLUMN director director VARCHAR(50);

-- BEGIN CHALLENGE: Create normalized movies table
USE movies;
CREATE TABLE genres (
    id INT AUTO_INCREMENT NOT NULL,
    genre VARCHAR(25),
    PRIMARY KEY(id)
);
COMMIT;

CREATE TABLE studios (
    id INT AUTO_INCREMENT NOT NULL,
    studio_name VARCHAR(30),
    city VARCHAR(20),
    PRIMARY KEY(id)
);
COMMIT;

CREATE TABLE directors (
    id INT AUTO_INCREMENT NOT NUll,
    dir_name VARCHAR(42),
    PRIMARY KEY(id)
);
COMMIT;

CREATE TABLE titles (
    id INT AUTO_INCREMENT NOT NULL,
    title  VARCHAR(100),
    genre_id INT,
    release_year_id SMALLINT,
    director_id INT,
    studio_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(genre_id) REFERENCES genres(id),
    FOREIGN KEY(director_id) REFERENCES directors(id),
    FOREIGN KEY(studio_id) REFERENCES studios(id)
);
COMMIT;

CREATE TABLE critic_ratings (
    id INT AUTO_INCREMENT NOT NULL,
    title_id INT,
    critics_rating DECIMAL(2, 1),
    PRIMARY KEY(id)
);
COMMIT; ALTER TABLE critic_ratings ADD CONSTRAINT title_id_fk
FOREIGN KEY (title_id)
REFERENCES titles(id);
COMMIT;
-- END CHALLENGE

-- BEGIN CHALLENGE: Filter movies by score
SELECT title AS 'Title:', 
CASE
    WHEN release_year < 2000 THEN '20th Century'
    ELSE '21st Century'
END AS 'Released:',
    director AS 'Director:',
CASE 
    WHEN critics_rating <= 5 THEN 'Bad'
    WHEN critics_rating <= 7 THEN 'Decent'
    WHEN critics_rating <= 8.9 THEN 'Good'
    ELSE 'Amazing'
END As 'Reviews:'
FROM movies_basic
ORDER BY title DESC;
-- END CHALLENGE

-- BEGIN CHALLENGE: Clean up the movies
INSERT INTO movies_basic
(title, genre, release_year, director, studio, critics_rating)
VALUES
('Run for the Forest', 'Drama', 1946, 'Rence Pera', 'Lionel Brownstone', 7.3),
('Luck of the Night', 'Drama', 1951, 'Rence Pera', 'Lionel Brownstone', 6.8),
('Invader Glory', 'Adventure', 1953, 'Rence Pera', 'Studio 60', 5.5);

UPDATE movies_basic SET genre="SF"
WHERE studio="Falstead Group" AND genre="Sci-Fi";

DELETE FROM movies_basic
WHERE studio="Lionel Brownstone" AND director="Garry Scott";
-- END CHALLENGE

-- BEGIN CHALLENGE: Find the best film
CREATE TABLE posters (
	id INT NOT NULL AUTO_INCREMENT,
	titles_id INT,
	filename VARCHAR(30),
	resolution VARCHAR(10),
	PRIMARY KEY(id),
	CONSTRAINT posters_title_id_fk
	FOREIGN KEY(titles_id)
	REFERENCES titles(id)
);

SELECT titles.title, directors.dir_name, critic_ratings.critics_rating, posters.filename
FROM titles
INNER JOIN directors ON titles.director_id = directors.id
INNER JOIN critic_ratings ON titles.id = critic_ratings.title_id
LEFT OUTER JOIN posters ON titles.id = posters.titles_id
WHERE critic_ratings.critics_rating = (
	SELECT MAX(critic_ratings.critics_rating)
	FROM critic_ratings
);
-- END CHALLENGE
