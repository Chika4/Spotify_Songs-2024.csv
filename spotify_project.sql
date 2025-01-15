/*Create database named spotify_project_2024*/

CREATE DATABASE spotify_project_2024;

/* Create the track_info table */
CREATE TABLE track_info (
    Track_ID VARCHAR(50) PRIMARY KEY,
    Track VARCHAR(255) NOT NULL,
    Album_Name VARCHAR(255),
    Artist VARCHAR(255),
    Release_Date DATE,
    ISRC VARCHAR(12), -- ISRC code is typically 12 characters
    Explicit_Track BOOLEAN
);

/* Create the track_popularity table */
CREATE TABLE track_popularity (
    Track_ID VARCHAR(50) PRIMARY KEY,
    All_Time_Rank INT,
    Track_Score FLOAT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* Create the spotify_metrics table */
CREATE TABLE spotify_metrics (
    ISRC VARCHAR(12) PRIMARY KEY,
    Track_ID VARCHAR(50),
    Spotify_Streams BIGINT,
    Spotify_Playlist_Count INT,
    Spotify_Playlist_Reach BIGINT,
    Spotify_Popularity INT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* Create the youtube_metrics table */
CREATE TABLE youtube_metrics (
    ISRC VARCHAR(12) PRIMARY KEY,
    Track_ID VARCHAR(50),
    YouTube_Views BIGINT,
    YouTube_Likes BIGINT,
    YouTube_Playlist_Reach BIGINT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* Create the ticktok_metrics table */
CREATE TABLE ticktok_metrics (
    ISRC VARCHAR(12) PRIMARY KEY,
    Track_ID VARCHAR(50),
    TikTok_Posts INT,
    TikTok_Likes BIGINT,
    TikTok_Views BIGINT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* Create the deezer_metrics table */
CREATE TABLE deezer_metrics (
    ISRC VARCHAR(12) PRIMARY KEY,
    Track_ID VARCHAR(50),
    Deezer_Playlist_Count INT,
    Deezer_Playlist_Reach BIGINT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* Create the pandora_metrics table */
CREATE TABLE pandora_metrics (
    ISRC VARCHAR(12) PRIMARY KEY,
    Track_ID VARCHAR(50),
    Pandora_Streams BIGINT,
    Pandora_Track_Stations INT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* Create the other_platform_metrics table */
CREATE TABLE other_platform_metrics (
    Track_ID VARCHAR(50) PRIMARY KEY,
    Apple_Music_Playlist_Count INT,
    Soundcloud_Streams BIGINT,
    Amazon_Playlist_Count INT,
    AirPlay_Spins INT,
    SiriusXM_Spins INT,
    Shazam_Counts INT,
    FOREIGN KEY (Track_ID) REFERENCES track_info(Track_ID)
);

/* This code load the data from my file to 
my database (local)*/


COPY track_info
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\track_info.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY deezer_metrics
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\deezer_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY pandora_metrics
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\pandora_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY other_platform_metrics
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\other_platform_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY spotify_metrics
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\spotify_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY track_popularity
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\track_popularity.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY ticktok_metrics
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\ticktok_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY youtube_metrics
FROM 'C:\Users\User\Desktop\Spotify_Songs 2024.csv\csv_files\youtube_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

SELECT *
FROM track_popularity;