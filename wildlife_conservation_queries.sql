-- Active: 1748269062425@@127.0.0.1@5432@wildlife_monitoring_db@public



CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(100) NOT NULL
);



CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR (100) NOT NULL,
    scientific_name VARCHAR (100) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(30) NOT NULL CHECK (conservation_status IN ('Endangered', 'Vulnerable','Historic'))
);


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR (100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes VARCHAR (255)
);


-- Problem 1
INSERT INTO rangers (name,region)  VALUES
('Derek Fox', 'Coastal Plains');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Bengal Tiger', 'Panthera tigris','1758-01-01', 'Endangered'),
('Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),
('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');









INSERT INTO sightings (species_id,ranger_id, location, sighting_time, notes) VALUES

(1,2,'Gulistan Pass','2024-06-19 19:30:00',NULL);



-- Problem 2
SELECT count(DISTINCT species_id) AS unique_species_count FROM sightings


-- Problem 3 

SELECT * FROM sightings WHERE location LIKE '%Pass%'



-- Problem 4

SELECT rangers.name AS ranger_name, COUNT(sightings.sighting_id) AS total_sightings FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id -- OR you can use USING because we have common field ranger_id in both rangers and sightings table
GROUP BY rangers.name

-- Show all sightings count even if a ranger don't have any sighing count

SELECT rangers.name AS ranger_name, COUNT(sightings.sighting_id) AS total_sightings FROM rangers
LEFT JOIN sightings  ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name







