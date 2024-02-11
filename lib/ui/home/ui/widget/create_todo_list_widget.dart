import 'package:flutter/material.dart';

class CreateTodoListWidget extends StatefulWidget {
  const CreateTodoListWidget({super.key});

  @override
  State<CreateTodoListWidget> createState() => _CreateTodoListWidgetState();
}

class _CreateTodoListWidgetState extends State<CreateTodoListWidget> {
  DateTime? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        TextButton(onPressed: () {}, child: const Text("Create")),
      ],
      title: Text("Create Task"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
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
                  child: Text("Choose date"),
                )
              : Text(
                  "${_selectedTime!.day}.${_selectedTime!.month}.${_selectedTime!.year}"),
        ],
      ),
    );
  }
}
