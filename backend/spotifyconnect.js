const express = require('express');
const bodyParser = require('body-parser');
const config = require('./config.json')
const SpotifyWebApi = require('spotify-web-api-node');

const app = express();
const PORT = 3000;
app.use(bodyParser.urlencoded({ extended: true }));
const YOUR_CLIENT_ID = config.API_TOKEN;
const YOUR_CLIENT_SECRET = config.API_SECRET;
const YOUR_REDIRECT_URI = 'http://localhost:3000/callback';

const spotifyApi = new SpotifyWebApi({
  clientId: YOUR_CLIENT_ID,
  clientSecret: YOUR_CLIENT_SECRET,
  redirectUri: YOUR_REDIRECT_URI,
});

app.get('/', (req, res) => {
  const authorizeURL = spotifyApi.createAuthorizeURL(['user-top-read', 'playlist-read-private'], 'state');
  res.redirect(authorizeURL);
});

app.get('/callback', async (req, res) => {
  const { code } = req.query;
  try {
    const data = await spotifyApi.authorizationCodeGrant(code);
    const { access_token, refresh_token } = data.body;

    spotifyApi.setAccessToken(access_token);
    spotifyApi.setRefreshToken(refresh_token);

    res.send('Authorization successful! Use /toptracks or /savedplaylists endpoint to get data.');
  } catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }
});

app.get('/toptracks', async (req, res) => {
  try {
    const topTracksResponse = await spotifyApi.getMyTopTracks({ limit: 5, time_range: 'short_term' });
    const topTracks = topTracksResponse.body.items.map((track) => track.name);
    res.send(`Top Tracks: ${topTracks.join(', ')}`);
  } catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }
});

app.get('/savedplaylists', async (req, res) => {
  try {
    const savedPlaylistsResponse = await spotifyApi.getMySavedPlaylists({ limit: 5 });
    const savedPlaylists = savedPlaylistsResponse.body.items.map((playlist) => playlist.name);
    res.send(`Saved Playlists: ${savedPlaylists.join(', ')}`);
  } catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
