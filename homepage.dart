import 'package:flutter/material.dart';
import 'package:flutter_curd/liststudent.dart';

import 'addstudent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Flutter curd'),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const addstudent(),
                ),
              )
            },
            child: const Text('Add', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
          ),
        ]),
      ),
      body: const liststudent(),
    );
  }
}
