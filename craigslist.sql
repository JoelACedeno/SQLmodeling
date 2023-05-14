-- Design a schema for Craigslist! Your schema should keep track of the following

-- The region of the craigslist post (San Francisco, Atlanta, Seattle, etc)
-- Users and preferred region
-- Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting
-- Categories that each post belongs to

CREATE DATABASE craigslist

\c craigslist;

CREATE TABLE categories
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE TABLE regions 
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    password TEXT NOT NULL,
    home_region INTEGER REFERENCES regions
)

CREATE TABLE posts
(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users ON DELETE CASCADE ,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    category INTEGER REFERENCES categories,
    location TEXT NOT NULL,
    region INTEGER REFERENCES regions
);