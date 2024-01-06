
const { json } = require("express");
const userActions = require("../../db/userActions.js");

exports.getAllUsers = async (req, res) => {
  try {
    let allusers = await userActions.getAllUsers();
    res.json(allusers);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error fetching users' });
  }
};

exports.addUser = async (req, res) => {
  try {
    let personDocument = (req.body)
    // Debug prints will be removed later
    // console.log("User addition details" + JSON.stringify(req.body));
    await userActions.addUser(personDocument);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error fetching users' });
  }
};

exports.deleteAllUsers = async (req, res) => {
  try {
    let personDocument = (req.body)
    // Debug prints will be removed later
    // console.log("User addition details" + JSON.stringify(req.body));
    await userActions.deleteAllUser();
    return res.status(200).json({message: 'All user records deleted'});
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error fetching users' });
  }
};