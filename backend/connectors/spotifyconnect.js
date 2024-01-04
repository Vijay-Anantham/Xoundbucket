const express = require('express');
const bodyParser = require('body-parser');
const config = require('../config.json')
const SpotifyWebApi = require('spotify-web-api-node');
const cors = require('cors')

const app = express();
// FIXME: This has been added to enable communication between internal ports within the system
// CORS - Cross Origin Resource Sharing
app.use(cors())
const PORT = 3000;
let authorized = false
app.use(bodyParser.urlencoded({ extended: true }));
const YOUR_CLIENT_ID = config.API_TOKEN;
const YOUR_CLIENT_SECRET = config.API_SECRET;
// TODO: Currently it is local host it has to be hosted somewhere or add redirect to internal application page
const YOUR_REDIRECT_URI = 'http://localhost:3000/callback';

const spotifyApi = new SpotifyWebApi({
  clientId: YOUR_CLIENT_ID,
  clientSecret: YOUR_CLIENT_SECRET,
  // FIXME: This redirect uri should be one of the application pages
  redirectUri: YOUR_REDIRECT_URI,
});

app.get('/', (req, res) => {
  const authorizeURL = spotifyApi.createAuthorizeURL(['user-top-read', 'playlist-read-private'], 'state');
  res.redirect(authorizeURL);
});

// Sets the state of the application which can be called from the front end to decide on the flow
app.get('/state', (req, res) => {
  try{
    res.send(authorized)
  }catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }
});

// Home end point to get the authorization done
app.get('/callback', async (req, res) => {
  const { code } = req.query;
  try {
    const data = await spotifyApi.authorizationCodeGrant(code);
    const { access_token, refresh_token } = data.body;

    spotifyApi.setAccessToken(access_token);
    spotifyApi.setRefreshToken(refresh_token);
    authorized = true
    res.send('Authorization successful! Use /toptracks or /savedplaylists endpoint to get data.');
  } catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }
});

// End point to get the top 5 played tracks from the spotify api
app.get('/toptracks', async (req, res) => {
  try {
    const topTracksResponse = await spotifyApi.getMyTopTracks({ limit: 5, time_range: 'short_term' });
    const topTracks = topTracksResponse.body.items.map((track) => ({
      name: track.name,
      url: track.external_urls.spotify,
    }));
    res.json(topTracks);
  } catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }});

// End point to get set of saved playlists from the spotify api
app.get('/savedplaylists', async (req, res) => {
  try {
    const savedPlaylistsResponse = await spotifyApi.getMySavedPlaylists({ limit: 5 });
    const savedPlaylists = savedPlaylistsResponse.body.items.map((playlist) => ({
      name: playlist.name,
      url: playlist.external_urls.spotify,
    }));
    res.json(savedPlaylists);
  } catch (error) {
    console.error('Error:', error.message);
    res.send('Error occurred. Check the console for details.');
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
