// This code is mainly focued on all user based actions
// TODO: Add user data into db
// TODO: Delete user data into db
// TODO: Modify user data into db
const dbclient = require('./db.js');
// This will be called from the application and the actual operations will be handed over from here.
async function addUser(userDetails) {
    try {
      await dbclient.client.connect();
      const collection = client.db(dbName).collection(collectionName);
  
      const result = await collection.insertOne(userDetails);
  
      console.log("User added successfully with ID:", result.insertedId);
  
      return result.insertedId; // Optional: Return the inserted user's ID
    } catch (error) {
      console.error("Error adding user:", error);
      throw error; // Re-throw the error for front-end handling
    } finally {
      await client.close();
    }
  }

  module.exports = addUser;