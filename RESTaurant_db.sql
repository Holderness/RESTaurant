CREATE DATABASE RESTaurant_db;

\c restaurant_db;

CREATE TABLE foods (
id SERIAL PRIMARY KEY,
name VARCHAR(30),
cuisine_type VARCHAR(30),
price INTEGER,
allergens VARCHAR(255)
);

CREATE TABLE parties (
id SERIAL PRIMARY KEY,
table_no INTEGER,
guest_no INTEGER,
paid BOOLEAN,
dufresnes BOOLEAN
);

CREATE TABLE orders (
id SERIAL PRIMARY KEY,
food_id INTEGER,
party_id INTEGER,
);



-- psql < RESTaurant_db.sql