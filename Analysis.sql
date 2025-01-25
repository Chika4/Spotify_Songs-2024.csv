/* This list the top most streamed tracks in spotify with explicit content*/

SELECT track_info.Track_ID, track_info.Artist, track_info.Track,
    spotify_metrics.Spotify_Streams, track_info.Explicit_Track
FROM track_info 
INNER JOIN spotify_metrics ON track_info.Track_ID = spotify_metrics.Track_ID
WHERE Explicit_Track is TRUE
AND spotify_streams IS NOT NULL
ORDER BY Spotify_Streams DESC
LIMIT 10;

/* Count of explicit content performance in spotify ratings */

SELECT SUM(spotify_metrics.Spotify_Streams) AS stream_count, 
    COUNT(track_info.Explicit_Track) AS explicit_count,
    track_info.Explicit_Track
FROM track_info 
INNER JOIN spotify_metrics ON track_info.Track_ID = spotify_metrics.Track_ID
WHERE spotify_streams IS NOT NULL
GROUP BY track_info.explicit_track
ORDER BY stream_count DESC;

/* Comparison of top performing songs listed accros all streaming platforms */
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


/* Comparison of least performing songs listed accros all streaming platforms */
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