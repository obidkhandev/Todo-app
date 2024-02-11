import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/ui/widget/create_todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          "HomePage",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const CreateTodoListWidget();
              });
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 100),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              "${index + 1}.",
              style: TextStyle(fontSize: 18),
            ),
            contentPadding: const EdgeInsets.all(8),
            title: Text("Title"),
            subtitle: Text("Subtitle"),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade400,
                )),
          );
        },
      ),
    );
  }
}
