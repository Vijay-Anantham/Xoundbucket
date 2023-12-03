const express = require('express');
const bodyParser = require('body-parser');
const SpotifyWebApi = require('spotify-web-api-node');
const config = require('./config.json')

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

// Replace these with your Spotify app credentials
const clientId = config.API_TOKEN;
const clientSecret = config.API_SECRET;
const redirectUri = 'http://localhost:3000/callback';

const spotifyApi = new SpotifyWebApi({
  clientId,
  clientSecret,
  redirectUri,
});

app.get('/', (req, res) => {
  const authorizeURL = spotifyApi.createAuthorizeURL(['user-read-private', 'user-read-email'], 'state', true);
  res.redirect(authorizeURL);
});

app.get('/callback', async (req, res) => {
  const { code } = req.query;

  try {
    const data = await spotifyApi.authorizationCodeGrant(code);
    const { access_token, refresh_token } = data.body;

    // Set the access token on the API object to use it in later calls
    spotifyApi.setAccessToken(access_token);
    spotifyApi.setRefreshToken(refresh_token);

    // Example: Get the user's playlists
    const playlists = await spotifyApi.getUserPlaylists();
    res.json(playlists.body);
  } catch (error) {
    console.error('Error getting Tokens:', error);
    res.status(500).send('Error getting Tokens');
  }
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
