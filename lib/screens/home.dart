// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sql_example/screens/edit_notes.dart';
import 'package:sql_example/widgets/custom_db_widget.dart';
import 'package:sql_example/widgets/slider_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  List notes = [];

  Future readData() async {
    List<Map> response = await sql.readData('SELECT * FROM notes');
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (context, i) {
                return Card(
                  color: Colors.white30,
                  child: SliderItem(
                    menuItems: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          int response = await sql.deleteData(
                              "DELETE FROM 'notes' WHERE id = ${notes[i]['id']}");

                          /* shortened function used */
                          // int response = await sql.delete(
                          //   "notes",
                          //   "id = ${notes[i]['id']}",
                          // );
                          if (response > 0) {
                            notes.removeWhere(
                                (element) => element['id'] == notes[i]['id']);
                            setState(() {});
                          }
                          print('<<<<<<<<<<<<<<<<<$response>>>>>>>>>>>>>');
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditNotes(
                                note: notes[i]['note'],
                                title: notes[i]['title'],
                                color: notes[i]['color'],
                                id: notes[i]['id'],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text('${notes[i]['note']}'),
                      subtitle: Text('${notes[i]['title']}'),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addNotes');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
