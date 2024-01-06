
const userActions = require("../../db/userActions.js");

exports.getAllUsers = async (req, res) => {
  try {
    await userActions.getAllUsers();
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error fetching users' });
  }
};

exports.addUser = async (req, res) => {
  // ... logic to add a user
}