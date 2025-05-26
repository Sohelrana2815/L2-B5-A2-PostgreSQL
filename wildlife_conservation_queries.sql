-- Active: 1748269062425@@127.0.0.1@5432@wildlife_monitoring_db@public
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(100) NOT NULL
);


SELECT * FROM species



CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR (100) NOT NULL,
    scientific_name VARCHAR (100) NOT NULL,
    conservation_status VARCHAR(30) NOT NULL CHECK (conservation_status IN ('Endangered', 'Vulnerable','Historic'))
);



CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    location VARCHAR (100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes VARCHAR (255)
);




INSERT INTO rangers (name,region)  VALUES
('Derek Fox','Coastal Plains'),
('Emily Stone', 'Eastern Forest'),
('Frank Black', 'Wetland Marsh'),
('Grace Lee', 'Southern Plains'),
('Henry Wood', 'Highland Peaks');

INSERT INTO species (common_name, scientific_name, conservation_status) VALUES

('Snow Leopard', 'Panthera uncia', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', 'Endangered'),
('Red Panda', 'Ailurus fulgens', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', 'Endangered'),
('Black Rhino', 'Diceros bicornis', 'Endangered'),
('Giant Ibis', 'Thaumatibis gigantea', 'Endangered'),
('Saola', 'Pseudoryx nghetinhensis', 'Endangered'),
('Javan Rhino', 'Rhinoceros sondaicus', 'Endangered'),
('Dodo', 'Raphus cucullatus', 'Historic'),
('Tasmanian Tiger', 'Thylacinus cynocephalus', 'Historic');




SELECT * FROM sightings


INSERT INTO sightings (ranger_id, species_id, location, sighting_time, notes) VALUES
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(2, 1, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(4, 4, 'River Bend', '2024-05-20 11:00:00', 'Tracks found'),
(5, 5, 'Marsh Edge', '2024-05-22 08:15:00', 'Heard distant calls'),
(3, 6, 'Ibis Wetlands', '2024-05-23 06:50:00', 'Nest observed'),
(1, 7, 'Saola Valley', '2024-05-24 13:30:00', 'Brief visual contact'),
(5, 8, 'Jungle Trail', '2024-05-25 17:45:00', 'Fresh dung found'),
(1, 9, 'Old Forest', '2024-05-26 10:05:00', 'Historic bones discovered');




