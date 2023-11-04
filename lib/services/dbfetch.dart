import 'package:mongo_dart/mongo_dart.dart';

Future<void> fetchDataFromMongoDB() async {
  final db = Db(
      'mongodb://your-username:your-password@your-cluster.mongodb.net/your-database-name');
  await db.open();

  final collection = db.collection('your-collection-name');

  final query = where.eq(
      'your-field', 'desired-value'); // Replace with your query criteria

  final data = await collection.find(query).toList();

  for (var item in data) {
    print(item); // Replace with how you want to use the fetched data
  }

  await db.close();
}

void main() {
  fetchDataFromMongoDB();
}
