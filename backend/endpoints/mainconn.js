// This js file contain the endpoint initiation that will be used by furthur connections

const express = require('express');
const bodyParser = require('body-parser');
const config = require('../config.json')
const cors = require('cors')

const app = express();
// FIXME: This has been added to enable communication between internal ports within the system
// CORS - Cross Origin Resource Sharing
app.use(cors())
const PORT = 3000;
app.use(bodyParser.urlencoded({ extended: true }));

// Import endpoint routes
const usersRoutes = require('./router/userRouter.js');
const spotifyRoutes = require('./router/spotifyRouter.js');

// Mount routes
app.use('/users', usersRoutes);
app.use('/spotify', spotifyRoutes);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
  });