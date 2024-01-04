const config = require('../../config.json')
const SpotifyWebApi = require('spotify-web-api-node');
let authorized = false
const YOUR_CLIENT_ID = config.API_TOKEN;
const YOUR_CLIENT_SECRET = config.API_SECRET;
// TODO: Currently it is local host it has to be hosted somewhere or add redirect to internal application page
const YOUR_REDIRECT_URI = 'http://localhost:3000/spotify/callback';

const spotifyApi = new SpotifyWebApi({
  clientId: YOUR_CLIENT_ID,
  clientSecret: YOUR_CLIENT_SECRET,
  // FIXME: This redirect uri should be one of the application pages
  redirectUri: YOUR_REDIRECT_URI,
});

//Get a connection to spotify web api
exports.connectSpotify = async (req, res) => {
    const authorizeURL = spotifyApi.createAuthorizeURL(['user-top-read', 'playlist-read-private'], 'state');
    res.redirect(authorizeURL);
};

// Get the state of connection to progress the application flow
exports.getState = async (req, res) => {
    try{
        res.send(authorized)
    }catch (error) {
        console.error('Error:', error.message);
        res.send('Error occurred. Check the console for details.');
    }
};

// Get the spotify redirect endpoint to redirect to after success or failure of spotify connection
exports.redirect = async (req, res) => {
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
};

// Get the json list of top tracks the user has listened to
exports.getToptracks = async (req, res) => {
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
    }};