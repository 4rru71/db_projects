CREATE DATABASE universe;

\c universe;

CREATE TABLE galaxy(
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    stars_quantity INT NOT NULL ,
    planets_quantity INT NOT NULL,
    description TEXT UNIQUE,
    percentaje_dark_matter NUMERIC,
    has_life BOOLEAN,
    is_spiral BOOLEAN
);

CREATE TABLE star(
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    age_in_millions_of_years INT NOT NULL,
    temperature_in_c INT NOT NULL,
    description TEXT UNIQUE,
    magnitude NUMERIC,
    is_alive BOOLEAN,
    is_dwarf BOOLEAN,
    galaxy_id INT REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet(
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    distance_from_earth INT NOT NULL,
    age_in_millions_of_years INT NOT NULL,
    description TEXT UNIQUE,
    diameter_in_km NUMERIC,
    is_spherical BOOLEAN,
    has_life BOOLEAN,
    star_id INT REFERENCES star(star_id)
);

CREATE TABLE moon(
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    distance_from_earth INT NOT NULL,
    age_in_millions_of_years INT NOT NULL,
    description TEXT UNIQUE,
    diameter_in_km NUMERIC,
    is_spherical BOOLEAN,
    is_satellite BOOLEAN,
    planet_id INT REFERENCES planet(planet_id)
);

CREATE TABLE star_system(
    star_system_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    planets_quantity INT NOT NULL,
    stars_quantity INT NOT NULL,
    description TEXT UNIQUE,
    solar_masses NUMERIC,
    is_binary BOOLEAN,
    is_multiple BOOLEAN
);

INSERT INTO galaxy(name, stars_quantity, planets_quantity, description, percentaje_dark_matter, has_life, is_spiral) VALUES
('Milky Way', 100000, 8000, 'Our home galaxy', 85.3, true, true),
('Andromeda', 110000, 8500, 'Nearest large galaxy', 88.2, false, true),
('Triangulum', 40000, 2000, 'A nearby spiral galaxy', 80.0, false, true),
('Whirlpool', 90000, 5000, 'Interacting galaxy', 83.4, false, true),
('Sombrero', 50000, 3000, 'Bright galaxy with a large bulge', 78.1, false, false),
('Pinwheel', 95000, 6000, 'Face-on spiral galaxy', 84.6, false, true);

INSERT INTO star(name, age_in_millions_of_years, temperature_in_c, description, magnitude, is_alive, is_dwarf, galaxy_id) VALUES
('Sun', 4600, 5500, 'Our star', 4.83, true, true, 1),
('Sirius', 242, 9940, 'Brightest star in the night sky', 1.42, true, true, 1),
('Betelgeuse', 10000, 3500, 'Red supergiant star', -5.85, true, false, 2),
('Rigel', 8000, 11000, 'Blue supergiant', -6.69, true, false, 2),
('Vega', 455, 9602, 'Bright star in Lyra', 0.03, true, true, 3),
('Proxima Centauri', 4500, 3000, 'Closest known star', 15.5, true, true, 1);

INSERT INTO planet(name, distance_from_earth, age_in_millions_of_years, description, diameter_in_km, is_spherical, has_life, star_id) VALUES
('Earth', 0, 4500, 'Our home planet', 12742, true, true, 1),
('Mars', 78, 4500, 'Red planet', 6779, true, false, 1),
('Venus', 41, 4500, 'Hottest planet', 12104, true, false, 1),
('Kepler-22b', 600, 2000, 'Exoplanet in habitable zone', 24000, true, false, 2),
('HD 209458 b', 150, 3000, 'First transiting exoplanet', 143000, true, false, 2),
('Gliese 581d', 20, 5000, 'Possible habitable planet', 14000, true, false, 6),
('Jupiter', 628, 4500, 'Gas giant', 139820, true, false, 1),
('Saturn', 1275, 4500, 'Planet with rings', 116460, true, false, 1),
('Neptune', 4350, 4500, 'Furthest planet', 49244, true, false, 1),
('Uranus', 2720, 4500, 'Icy giant', 50724, true, false, 1),
('Kepler-452b', 1400, 6000, 'Super-Earth exoplanet', 18000, true, false, 2),
('TRAPPIST-1d', 40, 800, 'Exoplanet in system TRAPPIST-1', 11800, true, false, 6);

INSERT INTO moon(name, distance_from_earth, age_in_millions_of_years, description, diameter_in_km, is_spherical, is_satellite, planet_id) VALUES
('Moon', 0, 4500, 'Natural satellite of Earth', 3474, true, true, 1),
('Phobos', 78, 4500, 'Mars moon 1', 22.4, true, true, 2),
('Deimos', 78, 4500, 'Mars moon 2', 12.4, true, true, 2),
('Io', 628, 4500, 'Volcanic moon of Jupiter', 3643, true, true, 7),
('Europa', 628, 4500, 'Icy moon of Jupiter', 3122, true, true, 7),
('Ganymede', 628, 4500, 'Largest moon in solar system', 5268, true, true, 7),
('Callisto', 628, 4500, 'Cratered moon of Jupiter', 4820, true, true, 7),
('Titan', 1275, 4500, 'Saturns largest moon', 5150, true, true, 8),
('Enceladus', 1275, 4500, 'Icy Saturn moon', 504, true, true, 8),
('Mimas', 1275, 4500, 'Small moon of Saturn', 396, true, true, 8),
('Triton', 4350, 4500, 'Retrograde moon of Neptune', 2706, true, true, 9),
('Oberon', 2720, 4500, 'Uranus moon', 1522, true, true, 10),
('Titania', 2720, 4500, 'Largest Uranus moon', 1578, true, true, 10),
('Umbriel', 2720, 4500, 'Dark moon of Uranus', 1169, true, true, 10),
('Ariel', 2720, 4500, 'Bright Uranus moon', 1157, true, true, 10),
('Charon', 600, 2000, 'Pluto moon', 1212, true, true, 4),
('Nix', 600, 2000, 'Small Pluto moon', 49.8, true, true, 4),
('Hydra', 600, 2000, 'Another Pluto moon', 61.6, true, true, 4),
('Kepler-Moon1', 1400, 6000, 'Exoplanet moon', 900, true, true, 11),
('TRAPPIST-Moon1', 40, 800, 'Moon of TRAPPIST-1d', 800, true, true, 12);

INSERT INTO star_system(name, planets_quantity, stars_quantity, description, solar_masses, is_binary, is_multiple) VALUES
('Solar System', 8, 1, 'Our star system', 1.0, false, false),
('Alpha Centauri System', 2, 2, 'Closest system to Sun', 2.0, true, true),
('TRAPPIST-1 System', 7, 1, 'Cool red dwarf system', 0.08, false, false);