import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Grades',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _studentIdController = TextEditingController();
  String? _result;

  Future<void> getGrades() async {
    final studentId = _studentIdController.text;
    if (studentId.isEmpty) return;

    final url = Uri.parse('http://salloumliu.infinityfreeapp.com/index.php?student_id=$studentId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            _result = data.map((e) => "Name: ${e['name']}, Course: ${e['course']}, Grade: ${e['grade']}").join("\n");
          });
        } else {
          setState(() {
            _result = data['error'];
          });
        }
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Grades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(labelText: 'Enter Student ID'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getGrades,
              child: Text('Get Grades'),
            ),
            SizedBox(height: 20),
            _result != null
                ? Text(
              _result!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}