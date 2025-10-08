import 'package:flutter/material.dart';
import 'package:my_app/constants.dart' as constants;

// Make users list mutable for editing/deleting
List users = List.from(constants.users);

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editUser(int index) {
    var user = users[index];
    TextEditingController nameController = TextEditingController(
      text: user['name'],
    );
    TextEditingController lastNameController = TextEditingController(
      text: user['lastName'],
    );
    TextEditingController passwordController = TextEditingController(
      text: user['password'],
    );
    TextEditingController birthDateController = TextEditingController(
      text: user['birthDate'],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: birthDateController,
                decoration: InputDecoration(labelText: 'Birth Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users[index]['name'] = nameController.text;
                  users[index]['lastName'] = lastNameController.text;
                  users[index]['password'] = passwordController.text;
                  users[index]['birthDate'] = birthDateController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          var user = users[index];

          if (user['flag'] == 0) {
            return SizedBox.shrink();
          }

          return Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ID: ${user['id']}'),
                      Text('${user['name']} ${user['lastName']}'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(child: Text('Password: ${user['password']}')),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${user['birthDate']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => _editUser(index),
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => _deleteUser(index),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
