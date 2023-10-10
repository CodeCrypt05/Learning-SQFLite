import 'package:flutter/material.dart';
import 'package:learning_sqflite/data/database/dbhelper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final dbHelper = DatabaseHelper.instance;

  // get id of inserted data
  void insertData() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'prince',
      DatabaseHelper.columnAge: 18,
    };
    final id = await dbHelper.insert(row);
    print(id);
  }

  // get table
  void queryAll() async {
    var allRows = await dbHelper.getAllData();
    allRows.forEach((element) {
      print(element);
    });
  }

  //get specific query data
  void specificQuery() async {
    var allrows = await dbHelper.querySpecific(20);
    print(allrows);
  }

  //
  void deleteById() async {
    var id = await dbHelper.deleteData(2);
    print(id);
  }

  //Update data
  void updateData() async {
    var row = await dbHelper.update(2);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.05,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: insertData,
                child: const Text(
                  'Insert',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              height: size.height * 0.05,
              margin: EdgeInsets.only(top: 18),
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: queryAll,
                child: const Text(
                  'Query',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              height: size.height * 0.05,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: specificQuery,
                child: const Text(
                  textAlign: TextAlign.center,
                  'Query Specific',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              height: size.height * 0.05,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                onPressed: updateData,
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              height: size.height * 0.05,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: deleteById,
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
