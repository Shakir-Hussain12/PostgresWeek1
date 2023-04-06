/* Populate database
WITH sample data. */
-- ANIMALS
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Agumon', '02/03/2020', 0, 'T', 10.23);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Gabumon', '09/15/2018', 2, 'T', 8);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Pikachu', '01/07/2021', 1, 'F', 15.04);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Devimon', '05/12/2017', 5, 'T', 11);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Charmandar', '02/08/2020', 0, 'F', -11);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Plantom', '11/15/2021', 2, 'T', -5.7);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Squirtle', '04/02/1993', 3, 'F', -12.13);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Angemon', '06/12/2005', 1, 'T', -45);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Boarmon', '06/7/2020', 7, 'T', 20.4);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Blossom', '10/13/1998', 3, 'T', 17);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Ditto', '05/14/2022', 4, 'F', 22);

-- OWNERS
insert into owners(full_name, age) values('Sam Smith', 34);
insert into owners(full_name, age) values('Jennifer Orwell', 19);
insert into owners(full_name, age) values('Bob', 45);
insert into owners(full_name, age) values('Melody Pond', 77);
insert into owners(full_name, age) values('Dean Winchester', 14);
insert into owners(full_name, age) values('Jodie Whittaker', 38);

-- SPECIES
insert into species(name) values('Pokemon');
insert into species(name) values('Digimon');

-- VETS
INSERT INTO vets(name, age, date_of_graduation) values('William Tatcher', 45, '04/23/2000');
INSERT INTO vets(name, age, date_of_graduation) values('Maisy Smith', 26, '01/17/2019');
INSERT INTO vets(name, age, date_of_graduation) values('Stephanie Mendez', 64, '05/04/1981');
INSERT INTO vets(name, age, date_of_graduation) values('Jack Harkness', 38, '06/08/2008');

-- VISITS
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (1, 1, '2020-05-24'), (1, 3, '2020-07-22'), (2, 4, '2021-02-02'), (3, 2, '2020-01-05'), (3, 2, '2020-03-08'), (3, 2, '2020-05-14'), (4, 3, '2021-05-04'), (5, 4, '2021-02-24'), (6, 2, '2019-12-21'), (6, 1, '2020-08-10'), (6, 2, '2021-04-07'), (7, 3, '2019-09-29'), (8, 4, '2020-10-03'), (8, 4, '2020-11-04'), (9, 2, '2019-01-24'), (9, 2, '2019-05-15'), (9, 2, '2020-02-27'), (9, 2, '2020-08-03'), (10, 3, '2020-05-24'), (10, 1, '2021-01-11');

-- SPECIALIZATION
INSERT INTO specializations (vets_id, species_id) VALUES (1, 1), (3, 2), (3, 1), (4, 2);

-- week2
INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT  *
FROM
(
	SELECT  id
	FROM animals
) animal_ids, (
SELECT  id
FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
INSERT INTO owners (full_name, email)
SELECT  'Owner ' || generate_series(1,2500000)
       ,'owner_' || generate_series(1,2500000) || '@mail.com';

-- Queries
begin; 
delete
FROM animals;
rollback;

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
WHERE weight_kg < 0;
release savepoint neg;
commit;

begin; 
update animals
SET species = 'nonspecified';
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
update animals
SET species_id = 2
WHERE trim(name) like '%mon';

update animals
SET species_id = 1
WHERE species_id is NULL;
commit;

begin;
update animals
SET owner_id = (
SELECT  id
FROM owners
WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

update animals
SET owner_id = (
SELECT  id
FROM owners
WHERE full_name = 'Jennifer Orwell')
WHERE name in('Gabumon', 'Pikachu'); 

update animals
SET owner_id = (
SELECT  id
FROM owners
WHERE full_name = 'Bob')
WHERE name in('Devimon', 'Plantom');

update animals
SET owner_id = (
SELECT  id
FROM owners
WHERE full_name = 'Melody Pond')
WHERE name in('Charmandar', 'Squirtle', 'Blossom');

update animals
SET owner_id = (
SELECT  id
FROM owners
WHERE full_name = 'Dean Winchester')
WHERE name in('Angemon', 'Boarmon');
commit;

