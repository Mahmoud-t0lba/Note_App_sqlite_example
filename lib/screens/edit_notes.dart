// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sql_example/screens/home.dart';
import 'package:sql_example/widgets/custom_db_widget.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;

  const EditNotes({
    Key? key,
    this.note,
    this.color,
    this.id,
    this.title,
  }) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Edit Note'),
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
                    child: const Text('Edit Note'),
                    onPressed: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );

                      int response = await sql.updateData('''
                      UPDATE notes SET 
                      note = "${note.text}",
                      title = "${title.text}",
                      color = "${color.text}"
                      WHERE id = ${widget.id} 
                      ''');

                      /* shortened function used */

                      // int responsse = await sql.update(
                      //   "notes",
                      //   {
                      //     "note": note.text,
                      //     "title": title.text,
                      //     "color": color.text,
                      //   },
                      //   "id = ${widget.id}",
                      // );

                      print('<<<<<<<$response>>>>>>>>');
                    },
                  ),

                  /// ================================
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
