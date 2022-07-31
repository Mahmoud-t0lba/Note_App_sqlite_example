import 'package:flutter/material.dart';
import 'package:sql_example/db/db.dart';

MySql sql = MySql();

class InsertButton extends StatelessWidget {
  const InsertButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: const Text('Insert'),
      onPressed: () async {
        int response = await sql.insertData(
            "INSERT INTO 'notes' ('note') VALUES ('note ===============')");

        print('<<<<<<<<<<<<<<<<<$response>>>>>>>>>>>>>');
      },
    );
  }
}

class ReadButton extends StatelessWidget {
  const ReadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: const Text('Read'),
      onPressed: () async {
        List<Map> response = await sql.readData("SELECT * FROM 'notes'");

        /* shortened function used */

        // List<Map> response = await sql.read("notes");
        for (var element in response) {
          print('<<<<<<<<<<<<<<<<<$element>>>>>>>>>>>>>\n');
        }
      },
    );
  }
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: const Text('Update'),
      onPressed: () async {
        int response = await sql
            .updateData("UPDATE 'notes' SET 'note' = 'Tolba' WHERE id = 1 ");
        print('<<<<<<<<<<<<<<<<<$response>>>>>>>>>>>>>');
      },
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: const Text('Delete'),
      onPressed: () async {
        int response = await sql.deleteData("DELETE FROM 'notes' WHERE id = 1");
        print('<<<<<<<<<<<<<<<<<$response>>>>>>>>>>>>>');
      },
    );
  }
}

class DeleteAllDBButton extends StatelessWidget {
  const DeleteAllDBButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: const Text('Delete All'),
      onPressed: () async => await sql.deleteAllDataBase(),
    );
  }
}
