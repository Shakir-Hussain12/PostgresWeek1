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