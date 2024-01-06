const conf = require("../config.json") // FIXME: How to go about storage of passwords in production
const { MongoClient, ServerApiVersion } = require('mongodb');
const uri = `mongodb+srv://vijayanantham143:${conf.MONGO_DB_PASSKEY}@xoundcluster.6pkf1lj.mongodb.net/?retryWrites=true&w=majority`;
const dbName = "dummy";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(uri, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});
// run().catch(console.dir);

module.exports = {
  client,
  dbName,
};
