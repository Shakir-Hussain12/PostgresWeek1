/* Populate database
WITH sample data. */
INSERT INTO animals VALUES (1, 'Agumon', '02/03/2020', 0, 'T', 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', '09/15/2018', 2, 'T', 8);
INSERT INTO animals VALUES (3, 'Pikachu', '01/07/2021', 1, 'F', 15.04);
INSERT INTO animals VALUES (4, 'Devimon', '05/12/2017', 5, 'T', 11);
ALTER TABLE animals add column species char(30);
INSERT INTO animals VALUES (5, 'Charmandar', '02/08/2020', 0, 'F', -11);
INSERT INTO animals VALUES (6, 'Plantom', '11/15/2021', 2, 'T', -5.7);
INSERT INTO animals VALUES (7, 'Squirtle', '04/02/1993', 3, 'F', -12.13);
INSERT INTO animals VALUES (8, 'Angemon', '06/12/2005', 1, 'T', -45);
INSERT INTO animals VALUES (9, 'Boarmon', '06/7/2020', 7, 'T', 20.4);
INSERT INTO animals VALUES (10, 'Blossom', '10/13/1998', 3, 'T', 17);
INSERT INTO animals VALUES (11, 'Ditto', '05/14/2022', 4, 'F', 22);