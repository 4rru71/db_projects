CREATE DATABASE number_guess;

CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(22) UNIQUE NOT NULL
);

CREATE TABLE games(
    game_id SERIAL PRIMARY KEY,
    user_id  INT NOT NULL REFERENCES users(user_id),
    number_guesses INT NOT NULL
);