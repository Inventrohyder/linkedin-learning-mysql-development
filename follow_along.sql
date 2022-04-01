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
COMMIT;

ALTER TABLE critic_ratings
ADD CONSTRAINT title_id_fk
FOREIGN KEY (title_id)
REFERENCES titles(id);
COMMIT;
-- END CHALLENGE