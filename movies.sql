CREATE TABLE movies (
    id serial,
    name text,
    release_year integer
  );
  
INSERT INTO movies(name, release_year) VALUES ('Psycho', '1960');
INSERT INTO movies(name, release_year) VALUES ('Sunset Blvd.', '1950');
INSERT INTO movies(name, release_year) VALUES ('Casablanca', '1942');
INSERT INTO movies(name, release_year) VALUES ('Citizen Kane', '1941');
INSERT INTO movies(name, release_year) VALUES ('On the Waterfront', '1954');
INSERT INTO movies(name, release_year) VALUES ('Metropolis', '1927');
INSERT INTO movies(name, release_year) VALUES ('Rear Window', '1954');
INSERT INTO movies(name, release_year) VALUES ('Vertigo', '1958');
INSERT INTO movies(name, release_year) VALUES ('The Maltese Falcon', '1941');
INSERT INTO movies(name, release_year) VALUES ('Breakfast at Tiffanys', '1961');

SELECT *
FROM movies
WHERE release_year < 1950; 

ALTER TABLE movies
	ADD genre text,
    ADD rating numeric; 
  
UPDATE movies
SET genre = 'horror', rating = 8.5
WHERE id = 1; 

SELECT *
FROM movies;
UPDATE movies
SET genre = 'drama', rating = 8.4
WHERE id = 2; 

UPDATE movies
SET genre = 'drama', rating = 8.5
WHERE id = 3; 

UPDATE movies
SET genre = 'drama', rating = 8.3
WHERE id = 4; 

UPDATE movies
SET genre = 'thriller', rating = 8.1
WHERE id = 5; 

UPDATE movies
SET genre = 'sci-fi', rating = 8.3
WHERE id = 6; 

UPDATE movies
SET genre = 'thriller', rating = 8.5
WHERE id = 7; 

UPDATE movies
SET genre = 'mystery', rating = 8.3
WHERE id = 8; 

UPDATE movies
SET genre = 'mystery', rating = 8.0
WHERE id = 9; 

UPDATE movies
SET genre = 'comedy', rating = 7.6
WHERE id = 10; 

-- constraint so only one movie can have the same name
ALTER TABLE movies
	ADD CONSTRAINT unique_name UNIQUE (name); 