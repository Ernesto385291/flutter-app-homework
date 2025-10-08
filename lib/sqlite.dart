import 'package:flutter/material.dart';
import 'package:my_app/utils/database.dart';

class Sqlite extends StatefulWidget {
  const Sqlite({super.key});

  @override
  State<Sqlite> createState() => _SqliteState();
}

class _SqliteState extends State<Sqlite> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _dbHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showAddDataDialog(context);
              },
              child: Text('Add data'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDataDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter name',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter age',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String name = nameController.text.trim();
                final String ageText = ageController.text.trim();

                if (name.isEmpty || ageText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                  return;
                }

                final int? age = int.tryParse(ageText);
                if (age == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid age')),
                  );
                  return;
                }

                try {
                  await _dbHelper.insert({
                    DatabaseHelper.columnName: name,
                    DatabaseHelper.columnAge: age,
                  });

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data added successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error adding data: $e')),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
