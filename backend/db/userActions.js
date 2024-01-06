const dbclient = require('./db.js');

// Get all users in the database
async function getAllUsers() {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await dbclient.client.connect();
    // Try adding a group of fields into db
    const db = dbclient.client.db(dbclient.dbName);
    // Reference the "people" collection in the specified database
    const col = db.collection("people");
    const document = await col.find({}).toArray();
    console.log("Document found:\n" + JSON.stringify(document));
    return document
  }catch (err) {
    console.log(err.stack);
  } finally {
    // Ensures that the client will close when you finish/error
    await dbclient.client.close();
  }
}
getAllUsers().catch(console.dir);

// Add users into database
async function addUser(userDetails) {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await dbclient.client.connect();
    // Try adding a group of fields into db
    const db = dbclient.client.db(dbclient.dbName);
    // Reference the "people" collection in the specified database
    const col = db.collection("people");
    // Insert into the defined collection
    const p = await col.insertOne(userDetails);
    console.log("User document Added");
   
  }catch (err) {
    console.log(err.stack);
  } finally {
    // Ensures that the client will close when you finish/error
    await dbclient.client.close();
  }
}
addUser().catch(console.dir);

// Delete all users in the database
async function deleteAllUser() {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await dbclient.client.connect();
    // Try adding a group of fields into db
    const db = dbclient.client.db(dbclient.dbName);
    // Reference the "people" collection in the specified database
    const col = db.collection("people");
    // delete no the defined collection
    const p = await col.deleteMany({});
    console.log("User document Added");
   
  }catch (err) {
    console.log(err.stack);
  } finally {
    // Ensures that the client will close when you finish/error
    await dbclient.client.close();
  }
}
deleteAllUser().catch(console.dir);



module.exports = {
    // ... other functions
    getAllUsers,
    addUser,
    deleteAllUser,
};