import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curd/updatestudent.dart';

class liststudent extends StatefulWidget {
  const liststudent({Key? key}) : super(key: key);

  @override
  State<liststudent> createState() => _liststudentState();
}

class _liststudentState extends State<liststudent> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  @override
  Future<void> deleteUser(id) {
    //print("user deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('user deleted '))
        .catchError((error) => print('failed to delete user $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          }
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
                        color: Colors.blueGrey,
                        child: const Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.blueGrey,
                        child: const Center(
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.blueGrey,
                        child: const Center(
                          child: Text(
                            'Action',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                        child: Container(
                          color: Colors.blueGrey,
                          child: Center(
                            child: Text(
                              storedocs[i]['name'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blueGrey,
                          child: Center(
                            child: Text(
                              storedocs[i]['email'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => updatestudentpage(
                                      id: storedocs[i]['id'],
                                    ),
                                  ))
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.deepPurple,
                            ),
                          ),
                          IconButton(
                              onPressed: () => {deleteUser(storedocs[i]['id'])},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.deepPurple,
                              ))
                        ],
                      )),
                    ]),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
