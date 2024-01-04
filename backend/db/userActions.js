const dbclient = require('./db.js');

async function getAllUsers() {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await dbclient.client.connect();
    // Try adding a group of fields into db
    const db = dbclient.client.db(dbclient.dbName);
    // Reference the "people" collection in the specified database
    const col = db.collection("people");
    // Create a new document                                                                                                                                           
    let personDocument = {
        "name": { "first": "Alan", "last": "Turing" },
        "birth": new Date(1912, 5, 23), // May 23, 1912                                                                                                                                 
        "death": new Date(1954, 5, 7),  // May 7, 1954                                                                                                                                  
        "contribs": [ "Turing machine", "Turing test", "Turingery" ],
        "views": 1250000
    }
    // Insert into the defined collection
    const p = await col.insertOne(personDocument);

    const filter = { "name.last": "Turing" };
    const document = await col.findOne(filter);
    console.log("Document found:\n" + JSON.stringify(document));
   
  }catch (err) {
    console.log(err.stack);
  } finally {
    // Ensures that the client will close when you finish/error
    await dbclient.client.close();
  }
}
getAllUsers().catch(console.dir);

module.exports = {
    // ... other functions
    getAllUsers,
};