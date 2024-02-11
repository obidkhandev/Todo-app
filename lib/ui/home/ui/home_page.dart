import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Tasks")
              .orderBy("task-deadline")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final docs = snapshot.data?.docs;

              return ListView.builder(
                itemCount: docs?.length ?? 0,
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 100),
                itemBuilder: (context, index) {
                  final doc = docs![index].data();

                  Timestamp time = doc["task-deadline"];
                  time.toDate();
                  // DateTime time = doc["task-deadline"];

                  return ListTile(
                    leading: Text(
                      "${index + 1}.",
                      style: const TextStyle(fontSize: 18),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    title: Text(doc["task-name"]),
                    subtitle: Text(
                        "${time.toDate().day}.${time.toDate().month}.${time.toDate().year}"),
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Tasks")
                              .doc(docs[index].id)
                              .delete();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade400,
                        )),
                  );
                },
              );
            }
            return const Center(
              child: Text("No Data"),
            );
          }),
    );
  }
}
