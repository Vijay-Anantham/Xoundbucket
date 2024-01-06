import 'dart:convert';
import 'dart:io';
import 'package:xoundbucket/domain/domain.dart';

// void main() {
//   final database = JsonDatabase();

//   // Insert data into the database
//   database.insert({"id": 1, "songs": Songs("abc", "asf", "asg")});
//   database.insert({"id": 2, "songs": Songs("acf", "ajy", "ahng")});
//   database.insert({"id": 3, "songs": Songs("asf", "ahg", "asg")});

//   // Retrieve and print data
//   final allData = database.selectAll();
//   print('All Data: $allData');

//   final dataById = database.selectById(2);
//   print('Data by ID (2): $dataById');

//   // Retrieve and print updated data
//   final updatedData = database.selectById(1);
//   print('Updated Data: $updatedData');

//   // Delete data
//   database.delete(3);

//   // Retrieve and print data after deletion
//   final remainingData = database.selectAll();
//   print('Remaining Data: $remainingData');
// }

class JsonDatabase {
  final Map<int, Map<String, dynamic>> _data = {};

  void insert(Map<String, dynamic> item) {
    final id = item['id'] as int;
    _data[id] = item;
  }

  Map<String, dynamic>? selectById(int id) {
    return _data[id];
  }

  List<Map<String, dynamic>> selectAll() {
    return _data.values.toList();
  }

  void update(int id, Map<String, dynamic> newItem) {
    if (_data.containsKey(id)) {
      _data[id] = {..._data[id]!, ...newItem};
    }
  }

  void delete(int id) {
    _data.remove(id);
  }
}
