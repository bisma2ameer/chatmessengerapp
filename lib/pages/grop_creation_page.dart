import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Create a new page or dialog for group creation.
class GroupCreationPage extends StatefulWidget {
  @override
  State<GroupCreationPage> createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends State<GroupCreationPage> {
  List<User> users = []; // List of users from Firebase
  List<String> selectedUserIds = [];
  String groupName = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              createGroup();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display the list of users with checkboxes for selection
          _buildUserList(),

          // Input fields for group name and category
          TextField(
            onChanged: (value) {
              groupName = value;
            },
            decoration: InputDecoration(labelText: 'Group Name'),
          ),
          TextField(
            onChanged: (value) {
              category = value;
            },
            decoration: InputDecoration(labelText: 'Category'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final isSelected = selectedUserIds.contains(user.uid);

        return ListTile(
          title: Text(user.uid),
          leading: Checkbox(
            value: isSelected,
            onChanged: (bool? selected) {
              setState(() {
                if (selected != null) {
                  if (selected) {
                    selectedUserIds.add(user.uid);
                  } else {
                    selectedUserIds.remove(user.uid);
                  }
                }
              });
            },
          ),
        );
      },
    );
  }

  void createGroup() {
    if (selectedUserIds.length >= 2) {
      // Create the group in your database with selectedUserIds, groupName, and category.
      // After creating the group, you can navigate to it or perform other actions.
    } else {
      // Show an error message or notification if fewer than 2 users are selected.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Select at least 2 users to create a group.'),
        ),
      );
    }
  }
}
