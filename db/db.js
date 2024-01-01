
const conf = require("../backend/config.json");
const { MongoClient } = require("mongodb");
const username = conf.MONGO_DB_USERNAME;
const password = conf.MONGO_DB_PASSKEY;
const clustername = conf.MONGO_DB_CLUSTER_NAME;
 
// Replace the following with your Atlas connection string                                                                                                                                        
const url = `mongodb+srv://${username}:${password}@${clustername}.mongodb.net/?retryWrites=true&w=majority`;

// Connect to your Atlas cluster
const client = new MongoClient(url);

async function run() {
    try {
        await client.connect();
        console.log("Successfully connected to Atlas");

    } catch (err) {
        console.log(err.stack);
    }
    finally {
        await client.close();
    }
}

run().catch(console.dir);