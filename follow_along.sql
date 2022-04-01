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
