const express = require('express');
const router = express.Router();

// Import controllers (if applicable)
const spotifyController = require('../controller/spotifyController.js');

// Define endpoints
router.get('/spotifyConnect', spotifyController.connectSpotify);
router.get('/callback', spotifyController.redirect);
router.get('/state', spotifyController.getState);
router.get('/toptracks', spotifyController.getToptracks);

module.exports = router;