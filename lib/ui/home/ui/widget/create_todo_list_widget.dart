import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateTodoListWidget extends StatefulWidget {
  const CreateTodoListWidget({super.key});

  @override
  State<CreateTodoListWidget> createState() => _CreateTodoListWidgetState();
}

class _CreateTodoListWidgetState extends State<CreateTodoListWidget> {
  late final TextEditingController _taskController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _taskController.dispose();
  }

  DateTime? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: isLoading
          ? [
              const Center(
                child: CircularProgressIndicator(),
              )
            ]
          : [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    if (_taskController.text.isEmpty || _selectedTime == null) {
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    Map<String, dynamic> data = {
                      "task-name": _taskController.text,
                      "task-deadline": _selectedTime
                    };
                    await FirebaseFirestore.instance
                        .collection("Tasks")
                        .add(data);
                    setState(() {
                      isLoading = false;
                    });
                   // ignore: use_build_context_synchronously
                   Navigator.pop(context);
                  },
                  child: const Text("Create")),
            ],
      title: const Text("Create Task"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _taskController,
            decoration: const InputDecoration(
              labelText: "Task Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          _selectedTime == null
              ? ElevatedButton(
                  onPressed: () async {
                    _selectedTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    setState(() {});
                  },
                  child: const Text("Choose date"),
                )
              : Text(
                  "${_selectedTime!.day}.${_selectedTime!.month}.${_selectedTime!.year}",
                ),
        ],
      ),
    );
  }
}
