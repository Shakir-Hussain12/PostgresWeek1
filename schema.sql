/* Database schema to keep the structure of entire database. */
CREATE TABLE animals( id int GENERATED ALWAYS AS Identity, name char(50), date_of_birth date, escape_attempts int, neutered boolean, weight_kg decimal, species char(30) );

CREATE TABLE owners ( id int generated always AS identity, full_name char(50), age int, primary key(id) );

CREATE TABLE species ( id int generated always AS identity, name char(30), primary key(id) );

CREATE TABLE vets ( id int generated always AS identity, name char(50), age int, date_of_graduation date, primary key(id) );

CREATE TABLE specializations ( vet_id int references vets(id), species_id int references species(id) );

CREATE TABLE visits ( animal_id int references animals(id), vet_id int references vets(id), date_of_visit date );

-- Queries
ALTER TABLE animals add primary key(id);
ALTER TABLE animals add column species char(30);

begin;
ALTER TABLE animals
DROP column species;
commit;

begin;
ALTER TABLE animals add column species_id int references species(id);
ALTER TABLE animals add column owner_id int references owners(id);
commit;

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
