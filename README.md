# 2024 Spotify Most-Streamed Songs

### Overview

This project focuses on compiling and analyzing the most-streamed songs on Spotify in 2024. The dataset provides comprehensive insights into track attributes, popularity metrics, and cross-platform presence, serving as a valuable resource for music analysts, enthusiasts, and industry professionals. 
Key details such as track names, artists, release dates, ISRC codes, streaming statistics, and visibility on platforms like YouTube and TikTok are included, enabling in-depth performance analysis and trend identification.

To support this analysis, I developed a database called spotify_project_2024 to systematically organize and process the data. The database includes tables for storing track details, popularity metrics, and platform-specific statistics for services such as Spotify, YouTube, TikTok, Deezer, Pandora, and others. 
These tables are interconnected using unique identifiers like Track ID and ISRC, ensuring data consistency and facilitating seamless queries. 
I loaded the dataset into the database using the COPY command, preparing it for detailed analysis and insights. See code: [Spotify_Songs 2024.csv](./spotify_project.sql)

### Objectives

The primary objectives of this project are:
- Examine the performance of songs listed across all streaming platforms.
- Measure the total potential audience size of the playlists and its relationship with total streams
- Measure the total playlist the song is included in and the relationship between playlist count and total streams.
- Examine the relationship between total engagement and streams accros all platforms

### Dataset Details

The dataset includes:
-	Track Name: Name of the song.
-	Album Name: Name of the album the song belongs to.
-	Artist: Name of the artist(s) of the song.
-	Release Date: Date when the song was released.
-	ISRC: International Standard Recording Code for the song.
-	All Time Rank: Ranking of the song based on its all-time popularity.
-	Track Score: Score assigned to the track based on various factors.
-	Spotify Streams: Total number of streams on Spotify.
-	Spotify Playlist Count: Number of Spotify playlists the song is included in.
-	Spotify Playlist Reach: Reach of the song across Spotify playlists.
-	Spotify Popularity: Popularity score of the song on Spotify.
-	YouTube Views: Total views of the song's official video on YouTube.
-	YouTube Likes: Total likes on the song's official video on YouTube.
-	TikTok Posts: Number of TikTok posts featuring the song.
-	TikTok Likes: Total likes on TikTok posts featuring the song.
-	TikTok Views: Total views on TikTok posts featuring the song.
-	YouTube Playlist Reach: Reach of the song across YouTube playlists.
-	Apple Music Playlist Count: Number of Apple Music playlists the song is included in.
-	AirPlay Spins: Number of times the song has been played on radio stations.
-	SiriusXM Spins: Number of times the song has been played on SiriusXM.
-	Deezer Playlist Count: Number of Deezer playlists the song is included in.
-	Deezer Playlist Reach: Reach of the song across Deezer playlists.
-	Amazon Playlist Count: Number of Amazon Music playlists the song is included in.
-	Pandora Streams: Total number of streams on Pandora.
-	Pandora Track Stations: Number of Pandora stations featuring the song.
-	Soundcloud Streams: Total number of streams on Soundcloud.
-	Shazam Counts: Total number of times the song has been Shazamed.
-	Explicit Track: Indicates whether the song contains explicit content.

### Tools I Used.
- **SQL:** Used to load and query data from my locale database
- **Excel:** This was used to carryout simple correlation analysis 
- **PostgreSQL:** For database management

### Analysis
**1. Examine the performance of songs listed across all streaming platforms;**
To gain a comprehensive understanding of song performance across various platforms, 
this analysis focused on examining the top and bottom songs based on streaming data from three major platforms: SoundCloud, Pandora, and Spotify. 
This approach aimed to identify platform-specific trends and assess the competitive advantages of music artists across different streaming services.

```sql
SELECT track_info.Track_ID, track_info.Artist, track_info.Track,
    spotify_metrics.Spotify_Streams, track_info.Explicit_Track
FROM track_info 
INNER JOIN spotify_metrics ON track_info.Track_ID = spotify_metrics.Track_ID
WHERE Explicit_Track is TRUE
AND spotify_streams IS NOT NULL
ORDER BY Spotify_Streams DESC;
```
Blinding Lights by The Weeknd has the highest total streams (4,799,427,953). This track outperforms all others, driven primarily by its dominance on Spotify (4.28 billion streams) While Demons by Imagine Dragons dominates on Pandora with over 1 billion streams, and a total streams of about 3.4billion across the three platforms and Lucid Dreams by Juice WRLD had a fair advantage compare to all other artist on sounclould.
![Top streams](./Images/Top%20streams.PNG)

On the other hand " by ALPHA 9 had the lowest overall stream count, with only 98,096 streams combined. "Miracle (Extended)" by Calvin Harris showed a significant disparity, performing well on Spotify but poorly on SoundCloud and Pandora. Interestingly, "I Am Not Okay" by Jelly Roll achieved a substantial number of streams on Pandora, suggesting a strong following on that platform.

**2 Total playlist reach of top performing tracks with the highest streams;**

This query aims to gather the total number of playlist reach so as to determine how widely the song was exposed to listeners on various non-social media platforms—Deezer, Spotify, and YouTube. This measures the total potential audience size of the playlists. 

In this SQL code, I analyzed music track performance by combining data from multiple streaming platforms. First, I calculated each track's total streams across SoundCloud, Pandora, and Spotify by summing their metrics while ensuring no missing values. Then, I calculated the total playlist reach by summing reach metrics from Deezer, Spotify, and YouTube, again filtering out incomplete data. Finally, I joined these two results to create a comprehensive dataset that includes each track's total streams, playlist reach metrics, and overall playlist reach, sorted by total streams in descending order to highlight the top-performing tracks.

```sql
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
ORDER BY all_streams.total_streams DESC;
```

This dataset highlights the playlist reach and total streams for various artists across Deezer, Spotify, and YouTube. The Kid LAROI leads in total playlist reach with over 4.4 billion, driven primarily by his exceptional performance on YouTube (4.3 billion). Similarly, Tones And I has a strong YouTube presence, contributing to her impressive playlist reach of 2.5 billion. In contrast, The Weeknd  and Ed Sheeran dominate in total streams, with 4.8 billion and 4.7 billion, respectively, reflecting their consistent popularity across platforms, particularly Spotify and YouTube. Despite Deezer's low contribution to playlist reach, Spotify and YouTube emerge as key platforms influencing an artist's overall performance.

![](./Images/Playlist%20graph.PNG)

Interestingly, some artists achieve high stream counts despite lower playlist reach. For instance, Passenger and Juice WRLD convert their modest playlist reach into substantial streams, indicating strong listener engagement or repeat plays. 

![](./Images/correlation_png.png)

The correlation coefficient between total playlist reach and total streams is approximately 0.27, indicating a weak positive relationship. This suggests that high playlist reach doesn't always guarantee equivalent streaming success, pointing to the importance of audience loyalty, listener engagement, platform-specific popularity, repeat plays, and marketing efforts likely play a critical role in driving streams. 

Overall, YouTube's dominance in playlist reach and Spotify's strong contribution to streams make them essential platforms for artist success.

