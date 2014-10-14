CREATE DATABASE RESTaurant_db;

\c RESTaurant_db;

CREATE TABLE foods (
id SERIAL PRIMARY KEY,
cuisine_type varchar(30),
price integer
allergens varchar(30)
);

CREATE TABLE parties (
id SERIAL PRIMARY KEY,
weapon varchar(30),
pet varchar(30)
);

CREATE TABLE orders (
id SERIAL PRIMARY KEY,
table integer,
paid boolean
);

-- psql < RESTaurant_db.sql