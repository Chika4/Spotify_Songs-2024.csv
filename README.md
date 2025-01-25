# 2024 Spotify Most-Streamed Songs

### Overview

This project focuses on compiling and analyzing the most-streamed songs on Spotify in 2024. The dataset provides comprehensive insights into track attributes, popularity metrics, and cross-platform presence, serving as a valuable resource for music analysts, enthusiasts, and industry professionals. 
Key details such as track names, artists, release dates, ISRC codes, streaming statistics, and visibility on platforms like YouTube and TikTok are included, enabling in-depth performance analysis and trend identification.

To support this analysis, I developed a database called spotify_project_2024 to systematically organize and process the data. The database includes tables for storing track details, popularity metrics, and platform-specific statistics for services such as Spotify, YouTube, TikTok, Deezer, Pandora, and others. 
These tables are interconnected using unique identifiers like Track ID and ISRC, ensuring data consistency and facilitating seamless queries. 
I loaded the dataset into the database using the COPY command, preparing it for detailed analysis and insights. See code (Spotify_Songs 2024.csv){spotify_project}

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
! (Top streams)(Images\Top streams.PNG)


On the other hand " by ALPHA 9 had the lowest overall stream count, with only 98,096 streams combined. "Miracle (Extended)" by Calvin Harris showed a significant disparity, performing well on Spotify but poorly on SoundCloud and Pandora. Interestingly, "I Am Not Okay" by Jelly Roll achieved a substantial number of streams on Pandora, suggesting a strong following on that platform.

