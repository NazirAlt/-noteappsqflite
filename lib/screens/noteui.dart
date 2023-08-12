import 'dart:core';

import 'package:flutter/material.dart';
import 'package:noteappsqflite/services/noteDBhelper.dart';

class Noteui extends StatefulWidget {
  Noteui({Key? key}) : super(key: key);

  @override
  _NoteuiState createState() => _NoteuiState();
}

class _NoteuiState extends State<Noteui> {
  insertDatabase(title, description) {
    NoteDBhelper.instance.insert({
      NoteDBhelper.coltitle: title,
      NoteDBhelper.coldersriotion: description,
      NoteDBhelper.coldate: DateTime.now().toString(),
    });
  }

  UpdateDatabase(snop, index, title, description) {}
  DeleteDatabase(snop, IndexError) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: const Text(
          'NOTE APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: FutureBuilder(
              future: NoteDBhelper.instance.queryAll(),
              builder:
                  (context, AsyncSnapshot<List<Map<String, dynamic>>> snap) {
                if (snap.hasData) {
                  return ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                            title: Text(
                              snap.data![index][NoteDBhelper.coltitle],
                            ),
                            subtitle: Text(snap.data![index]
                                    [NoteDBhelper.coldersriotion]
                                .toString()
                                .substring(0, 10)),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                var title = '';
                var description = '';
                return AlertDialog(
                  title: Text('Add Note'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          title = value;
                        },
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      TextField(
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: InputDecoration(hintText: 'Description'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        insertDatabase(title, description);
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.purple)),
                    ),
                    TextButton(
                      onPressed: () {
                        insertDatabase(title, description);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
