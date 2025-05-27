-- TABLE CREATION --
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


-- SAMPLE DATA INSERTION

INSERT INTO rangers (name, region) VALUES
('Alice Green', ' Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');




INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia','1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris','1758-01-01', 'Endangered'),
('Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),
('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');




INSERT INTO sightings (species_id,ranger_id, location, sighting_time, notes) VALUES
(1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),
(2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),
(3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),
(1,2,'Snowfall Pass','2024-05-18 18:30:00',NULL);







-- Problem 1 --
INSERT INTO rangers (name,region)  VALUES
('Derek Fox','Coastal Plains');

-- Problem 2
SELECT count(DISTINCT species_id) AS unique_species_count FROM sightings

-- Problem 3 

SELECT * FROM sightings WHERE location LIKE '%Pass%'



-- Problem 4

SELECT rangers.name AS ranger_name, COUNT(sightings.sighting_id) AS total_sightings FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id -- OR we can use USING for common column for both table
GROUP BY rangers.name

-- Show all sightings count even if a ranger don't have any sighing count (Optional)

SELECT rangers.name AS ranger_name, COUNT(sightings.sighting_id) AS total_sightings FROM rangers
LEFT JOIN sightings  ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name



-- Problem 5

SELECT species.common_name AS species_common_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.sighting_id IS NULL



-- Problem 6 


SELECT species.common_name AS species_common_name,
       sightings.sighting_time AS two_most_recent_sighting_time,
       rangers.name AS ranger_name
FROM sightings

INNER JOIN species ON sightings.species_id = species.species_id

INNER JOIN rangers ON sightings.ranger_id = rangers.ranger_id

ORDER BY sightings.sighting_time DESC
LIMIT 2


-- Problem 7

UPDATE species
SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR
FROM discovery_date) < 1800





-- Problem 8

SELECT sighting_id,
CASE
WHEN EXTRACT(HOUR FROM sighting_time) >=0 AND EXTRACT(HOUR FROM sighting_time) <12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sighting_time)  >=12 AND EXTRACT (HOUR FROM sighting_time) <17 THEN 'Afternoon'
ELSE 'Evening'
END AS time_of_day
FROM sightings;






-- Problem 9 
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings)
