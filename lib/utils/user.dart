import 'package:http/http.dart' as http;
import 'dart:convert';

void addUser(Map<String, dynamic> userDetails) async {
  try {
    // Replace with your endpoint URL and data
    Uri url = Uri.parse('http://localhost:3000/users/adduser');
    Map<String, dynamic> data = {
      // Your data to send
      'name': userDetails['email'],
      'password': userDetails['password'],
      // ...other fields
    };

    http.Response response = await http.post(
      url,
      body: jsonEncode(data), // Encode data as JSON
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful response
      var responseData = jsonDecode(response.body);
      print("Response: $responseData");
    } else {
      // Handle error
      print("Request failed with status: ${response.statusCode}");
    }
  } catch (error) {
    // Handle network or other errors
    print("Error: $error");
  }
}
