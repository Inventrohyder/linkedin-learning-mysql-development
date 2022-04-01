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
RENAME COLUMN critics_rating TO critic_rating,
CHANGE COLUMN director director VARCHAR(50);
