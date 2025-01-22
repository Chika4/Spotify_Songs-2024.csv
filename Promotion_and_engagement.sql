
/* This query aims to gat the total number of playlist reach,so as to determine 
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

/* This query seeks to determine the total potential audience of the top performing 
songs and what platform contributed largely to that*/

WITH all_streams AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        (opm.Soundcloud_Streams + pm.pandora_streams + sm.spotify_streams) AS 
        Total_Streams
    FROM track_info AS ti
    INNER JOIN other_platform_metrics AS opm ON ti.track_id = opm.track_id
    INNER JOIN pandora_metrics AS pm ON ti.track_id = pm.track_id
    INNER JOIN spotify_metrics AS sm ON ti.track_id = sm.track_id
    WHERE ti.Artist IS NOT NULL
    AND opm.soundcloud_streams IS NOT NULL
    AND pm.pandora_streams IS NOT NULL
    AND sm.spotify_streams IS NOT NULL
    ORDER BY total_streams DESC

), total_reach AS(
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
)

SELECT total_reach.*, all_streams.Total_Streams
FROM total_reach
INNER JOIN all_streams ON total_reach.track_id = all_streams.track_id
ORDER BY all_streams.total_streams DESC
LIMIT 10;

/* This query aims to determine the total number of playlist a particular track was included*/

WITH all_streams AS (
    SELECT ti.Track_ID, ti.track, ti.Artist,
        (opm.Soundcloud_Streams + pm.pandora_streams + sm.spotify_streams) AS 
        Total_Streams
    FROM track_info AS ti
    INNER JOIN other_platform_metrics AS opm ON ti.track_id = opm.track_id
    INNER JOIN pandora_metrics AS pm ON ti.track_id = pm.track_id
    INNER JOIN spotify_metrics AS sm ON ti.track_id = sm.track_id
    WHERE ti.Artist IS NOT NULL
    AND opm.soundcloud_streams IS NOT NULL
    AND pm.pandora_streams IS NOT NULL
    AND sm.spotify_streams IS NOT NULL
    ORDER BY total_streams DESC

), total_count AS(
    SELECT ti.track_id, ti.track, ti.Artist, dm.deezer_playlist_count,
        sm.Spotify_Playlist_Count, opm.apple_music_playlist_count,
        opm.amazon_playlist_count,
        (dm.deezer_playlist_count + sm.Spotify_Playlist_Count + opm.apple_music_playlist_count
         + opm.amazon_playlist_count) AS total_Playlist_count
    FROM track_info AS ti
    INNER JOIN deezer_metrics AS dm ON ti.track_id = dm.track_id
    INNER JOIN spotify_metrics AS sm ON ti.track_id = sm.track_id
    INNER JOIN other_platform_metrics AS opm ON ti.track_id = opm.track_id
    WHERE dm.deezer_playlist_count IS NOT NULL
        AND sm.Spotify_Playlist_Count IS NOT NULL
        AND opm.apple_music_playlist_count IS NOT NULL
        AND opm.amazon_playlist_count IS NOT NULL
    ORDER BY total_Playlist_count DESC
)

SELECT total_count.*, all_streams.Total_Streams
FROM total_count
INNER JOIN all_streams ON total_count.track_id = all_streams.track_id
ORDER BY all_streams.total_streams DESC
LIMIT 10;


/*To determnd the total number of social media engagements*/
SELECT tk.*, yt.YouTube_Likes, yt.YouTube_Views
FROM ticktok_metrics AS tk
INNER JOIN youtube_metrics AS yt ON tk.track_id = yt.track_id
LIMIT 10;
