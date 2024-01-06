const express = require('express');
const router = express.Router();

// Import controllers (if applicable)
const usersController = require('../controller/userController.js');

// Define endpoints
router.get('/getallusers', usersController.getAllUsers);
router.post('/adduser', usersController.addUser);

module.exports = router;