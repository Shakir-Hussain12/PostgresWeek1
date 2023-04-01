/* Database schema to keep the structure of entire database. */

CREATE TABLE animals( id int GENERATED ALWAYS AS Identity, name char(50), date_of_birth date, escape_attempts int, neutered boolean, weight_kg decimal, species char(30) );
alter table animals add primary key(id);

CREATE TABLE owners ( id int generated always AS identity, full_name char(50), age int, primary key(id) );

CREATE TABLE species ( id int generated always AS identity, name char(30), primary key(id) );

-- Queries
ALTER TABLE animals add column species char(30);

begin;
ALTER TABLE animals
DROP column species;
commit;

begin;
ALTER TABLE animals add column species_id int references species(id);
ALTER TABLE animals add column owner_id int references owners(id);
commit;