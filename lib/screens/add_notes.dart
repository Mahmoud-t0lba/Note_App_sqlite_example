import 'package:flutter/material.dart';
import 'package:sql_example/screens/home.dart';
import 'package:sql_example/widgets/custom_db_widget.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Notes'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: 'Note',
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      hintText: 'Color',
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Add Note'),
                    onPressed: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );

                      int response = await sql.insertData('''
                      INSERT INTO notes (note , title , color)
                      VALUES ("${note.text}" , "${title.text}" , "${color.text}")
                      ''');

                      // int response = await sql.insert("notes", {
                      //   "note": note.text,
                      //   "title": title.text,
                      //   "color": color.text,
                      // });
                      print('<<<<<<<$response>>>>>>>>');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
