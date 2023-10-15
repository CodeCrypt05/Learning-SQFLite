import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_sqflite/student.dart';

class StudentInfoScreen extends StatefulWidget {
  StudentInfoScreen({super.key});

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<Student> students = [];

  final TextEditingController nameController = TextEditingController();

  final TextEditingController rollNumberController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  void _insertStudent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        Student student = Student();
        student.name = nameController.text;
        student.rollNumber = rollNumberController.text;
        student.age = ageController.text;
        students.add(student);
        nameController.clear();
        rollNumberController.clear();
        ageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: rollNumberController,
                decoration: InputDecoration(labelText: 'Roll Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a roll number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _insertStudent,
                child: Text('Insert'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    Student student = students[index];
                    return ListTile(
                      title: Text('Name: ${student.name}'),
                      subtitle: Text(
                          'Roll Number: ${student.rollNumber}, Age: ${student.age}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
