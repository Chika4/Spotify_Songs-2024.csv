
/* This query aims to gather the total number of playlist reach,so as to determine 
Total potential audience size of the playlists featuring the song.*/

SELECT ti.track_id, ti.track, ti.Artist, dm.Deezer_Playlist_Reach,
    sm.Spotify_Playlist_Reach, yt.YouTube_Playlist_Reach,
    (dm.Deezer_Playlist_Reach + sm.Spotify_Playlist_Reach + 
    yt.YouTube_Playlist_Reach) AS total_Playlist_reach
FROM track_info AS ti
INNER JOIN deezer_metrics AS dm ON ti.track_id = dm.track_id
INNER JOIN spotify_metrics AS sm ON ti.track_id = sm.track_id
INNER JOIN youtube_metrics AS yt ON ti.track_id = yt.track_id
WHERE dm.Deezer_Playlist_Reach IS NOT NULL
    AND sm.Spotify_Playlist_Reach IS NOT NULL
    AND yt.YouTube_Playlist_Reach IS NOT NULL
ORDER BY total_Playlist_reach DESC
LIMIT 10;

WITH soundcloud AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        opm.Soundcloud_Streams
    FROM track_info AS ti
    INNER JOIN other_platform_metrics AS opm ON ti.track_id = opm.track_id
    WHERE ti.Artist IS NOT NULL
    AND opm.soundcloud_streams IS NOT NULL
),
pandora AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        pm.Pandora_Streams
    FROM track_info AS ti
    INNER JOIN pandora_metrics AS pm ON ti.track_id = pm.track_id
    WHERE ti.Artist IS NOT NULL
    AND pm.pandora_streams IS NOT NULL
),
spotify AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        sm.Spotify_Streams
    FROM track_info AS ti
    INNER JOIN spotify_metrics AS sm ON ti.track_id = sm.track_id
    WHERE ti.Artist IS NOT NULL
    AND sm.spotify_streams IS NOT NULL
)

SELECT soundcloud.*, pandora.Pandora_Streams,
    spotify.spotify_streams,
    (soundcloud.Soundcloud_Streams + 
    pandora.Pandora_Streams + 
    spotify.Spotify_Streams) AS Total_Streams
FROM soundcloud
INNER JOIN pandora ON soundcloud.track_id = pandora.track_id
INNER JOIN spotify ON soundcloud.track_id = spotify.track_id
ORDER BY Total_Streams DESC
LIMIT 10;


/* This query aims to gather the total number of Measures how many people the 
song could potentially reach*/

/* This query aims to gather the total number of social media engagements, 
playlist reach, and radio station plays so as to deermine how widely a 
song is exposed to listeners.*/

WITH soundcloud AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        opm.Soundcloud_Streams
    FROM track_info AS ti
    INNER JOIN other_platform_metrics AS opm ON ti.track_id = opm.track_id
    WHERE ti.Artist IS NOT NULL
    AND opm.soundcloud_streams IS NOT NULL
),
pandora AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        pm.Pandora_Streams
    FROM track_info AS ti
    INNER JOIN pandora_metrics AS pm ON ti.track_id = pm.track_id
    WHERE ti.Artist IS NOT NULL
    AND pm.pandora_streams IS NOT NULL
),
spotify AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        sm.Spotify_Streams
    FROM track_info AS ti
    INNER JOIN spotify_metrics AS sm ON ti.track_id = sm.track_id
    WHERE ti.Artist IS NOT NULL
    AND sm.spotify_streams IS NOT NULL
)

SELECT soundcloud.*, pandora.Pandora_Streams,
    spotify.spotify_streams,
    (soundcloud.Soundcloud_Streams + 
    pandora.Pandora_Streams + 
    spotify.Spotify_Streams) AS Total_Streams
FROM soundcloud
INNER JOIN pandora ON soundcloud.track_id = pandora.track_id
INNER JOIN spotify ON soundcloud.track_id = spotify.track_id
ORDER BY Total_Streams ASC
LIMIT 10;

