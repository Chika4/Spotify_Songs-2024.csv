
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

/* This query aims to determine the total number of playlist a particular track was included*/



/*To determnd the total number of social media engagements*/
SELECT tk.*, yt.YouTube_Likes, yt.YouTube_Views
FROM ticktok_metrics AS tk
INNER JOIN youtube_metrics AS yt ON tk.track_id = yt.track_id
LIMIT 10;
