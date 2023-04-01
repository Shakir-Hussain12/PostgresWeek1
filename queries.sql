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

select A.name from animals A
join visits V on A.id = V.animal_id
join vets ve on V.vet_id = ve.id
where ve.name = 'William Tatcher'
ORDER BY V.date_of_visit DESC LIMIT 1;

select ve.name, count(distinct A.name) as total_unique_animals from animals A
join visits V on V.animal_id = A.id
join vets ve on ve.id = V.vet_id
where ve.name = 'Stephanie Mendez'
group by ve.name

select V.name, sp.name from vets V
left join specializations S on S.vet_id = V.id
left join species sp on S.species_id = sp.id

SELECT V.name as Vet_Nurse, A.name as Animal_name, vi.date_of_visit FROM vets V
JOIN visits vi ON V.id = vi.vet_id
JOIN animals A ON A.id = vi.animal_id
WHERE V.name = 'Stephanie Mendez' AND
vi.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

select A.name, Count(A.name) as visits from animals A
join visits vi on vi.animal_id = A.id
group by A.name
having Count(A.name) = (
	select max(total_visits) from (select A.name, Count(A.name) as total_visits from animals A
	join visits vi on vi.animal_id = A.id
	group by A.name) as M_cnt
)

SELECT A.name as animal_name, vi.date_of_visit AS first_visit
FROM vets V
JOIN visits vi ON V.id = vi.vet_id
JOIN animals A ON vi.animal_id = A.id
WHERE V.name = 'Maisy Smith'
ORDER BY vi.date_of_visit ASC LIMIT 1;

SELECT A.name as animal_name, A.date_of_birth as animal_date, A.escape_attempts, A.neutered,
A.weight_kg, V.name as vet_name, V.age, V.date_of_graduation, vi.date_of_visit
FROM vets V
JOIN visits vi ON V.id = vi.vet_id
JOIN animals A ON A.id = vi.animal_id
ORDER BY vi.date_of_visit DESC LIMIT 1;

SELECT V.name as vet_name, COUNT(vi.animal_id) AS visits
FROM visits vi
JOIN vets V ON vi.vet_id = V.id
JOIN animals A ON A.id = vi.animal_id
FULL JOIN specializations S ON vi.vet_id = S.vet_id
GROUP BY vi.animal_id, V.name
ORDER BY COUNT(vi.animal_id) DESC
LIMIT 1;

SELECT sp.name, V.name AS vet_name, COUNT(*) AS visits
FROM vets V
JOIN visits vi ON V.id = vi.vet_id
JOIN animals A ON A.id = vi.animal_id
JOIN species sp ON sp.id = A.species_id
WHERE V.name = 'Maisy Smith'
GROUP BY sp.name, V.name
ORDER BY COUNT(*) DESC LIMIT 1;