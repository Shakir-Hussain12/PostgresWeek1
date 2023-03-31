/*Queries that provide answers to the questions
FROM all projects.*/
SELECT  *
FROM animals
WHERE trim(name) like '%mon';

SELECT  *
FROM animals
WHERE extract('year'
FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT  *
FROM animals
WHERE neutered = true
AND escape_attempts < 3;

SELECT  date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT  name,escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT  *
FROM animals
WHERE neutered = true;

SELECT  *
FROM animals
WHERE name != 'Gabumon';

SELECT  *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3; 

begin; 
update animals
SET species = 'nonspecified';
SELECT  *
FROM animals; 
rollback;

begin; 
update animals
SET species = 'digimon'
WHERE trim(name) like '%mon';
update animals
SET species = 'pokemon'
WHERE species is NULL; 
commit;


begin; 
delete
FROM animals;
SELECT  *
FROM animals; 
rollback;
SELECT  *
FROM animals; 

begin;
delete
FROM animals
WHERE date_of_birth > '01/01/2022';
savepoint neg;
update animals
SET weight_kg = (weight_kg * -1);
rollback to neg;
update animals
SET weight_kg = (weight_kg * -1)
WHERE weight_kg < 0; release savepoint neg;
commit;

SELECT  COUNT(*)
FROM animals;

SELECT  COUNT(*)
FROM animals
WHERE escape_attempts = 0;

SELECT  AVG(weight_kg)
FROM animals

SELECT  neutered,SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY  neutered

SELECT  species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight
FROM animals
GROUP BY  species
SELECT  species,AVG(escape_attempts) AS avg_escapes
FROM animals
WHERE extract('year'
FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY  species