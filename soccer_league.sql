-- Design a schema for a simple sports league. Your schema should keep track of

-- All of the teams in the league
-- All of the goals scored by every player for each game
-- All of the players in the league and their corresponding teams
-- All of the referees who have been part of each game
-- All of the matches played between teams
-- All of the start and end dates for season that a league has
-- The standings/rankings of each team in the league (This doesn’t have to be its own table if the data can be captured somehow).

CREATE DATABASE soccer_league
\c soccer_league;

CREATE TABLE teams
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT NOT NULL
)


CREATE TABLE players
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    dob DATE NOT NULL,
    height(inches) INTEGER NOT NULL,
    current_team INTEGER REFERENCES teams ON DELETE NULL 
)

CREATE TABLE referees
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE TABLE seasons
(
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
)

CREATE TABLE matches
(
    id SERIAL PRIMARY KEY,
    home_team_id INTEGER REFERENCES teams,
    away_team_id INTEGER REFERENCES teams,
    location TEXT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    season_id INTEGER REFERENCES seasons,
    head_ref_id INTEGER REFERENCES referees,
    assistant_ref_1_id INTEGER REFERENCES referees,
    assistant_ref_2_id INTEGER REFERENCES referees
)

CREATE TABLE results
(
    id SERIAL PRIMARY KEY,
    winning_team_id INTEGER REFERENCES teams,
    match_id INTEGER REFERENCES matches,
    result(win, loss, or draw) TEXT NOT NULL
)

CREATE TABLE lineups
(
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players,
    team_id INTEGER REFERENCES teams,
    match_id INTEGER REFERENCES matches
)

CREATE TABLE goals
(
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players,
    match_id INTEGER REFERENCES matches
)

CREATE TABLE standings
(
    id SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES teams,
    season_id INTEGER REFERENCES seasons,
    matches_played INTEGER NOT NULL,
    wins INTEGER NOT NULL DEFAULT 0,
    loses INTEGER NOT NULL DEFAULT 0,
    draws INTEGER NOT NULL DEFAULT 0
);
