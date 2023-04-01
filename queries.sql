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

SELECT  COUNT(*)
FROM animals;

SELECT  COUNT(*)
FROM animals
WHERE escape_attempts = 0;

SELECT  AVG(weight_kg)
FROM animals;

SELECT  neutered,SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY  neutered;

SELECT  species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight
FROM animals
GROUP BY  species
SELECT  species,AVG(escape_attempts) AS avg_escapes
FROM animals
WHERE extract('year'
FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY  species;

SELECT  name
FROM animals A
JOIN owners O
ON O.id = A.owner_id
WHERE O.full_name = 'Melody Pond';

SELECT  A.name
FROM animals A
JOIN species S
ON S.id = A.species_id
WHERE S.name = 'Pokemon';

SELECT  O.full_name,A.name
FROM animals A
RIGHT JOIN owners O
ON A.owner_id = O.id;

SELECT  S.name,COUNT(S.name)
FROM species S
JOIN animals A
ON A.species_id = S.id
GROUP BY  S.name;

SELECT  A.name
FROM animals A
JOIN owners O
ON O.id = A.owner_id
JOIN species S
ON S.id = A.species_id
WHERE O.full_name = 'Jennifer Orwell'
AND S.name = 'Digimon';

SELECT  A.name
FROM animals A
JOIN owners O
ON O.id = A.owner_id
WHERE O.full_name = 'Dean Winchester'
AND A.escape_attempts = 0;

SELECT  O.full_name,COUNT(A.owner_id) AS total_animals
FROM animals A
JOIN owners O
ON O.id = A.owner_id
group by O.full_name
having count(A.owner_id) = (select max(C) from 
								(select count(A.name) as C 
								from animals A 
								join owners O on A.owner_id = O.id
								group by O.full_name) 
							as M_count);