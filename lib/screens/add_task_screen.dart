import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_using_bloc/blocs/bloc_export.dart';
import 'package:todo_using_bloc/model/task.dart';

import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          const Text(
            "Add Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              controller: titlecontroller,
              autofocus: true,
              decoration: const InputDecoration(
                  label: Text("Title"), border: OutlineInputBorder()),
            ),
          ),
          TextField(
            controller: descriptioncontroller,
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
                label: Text("Description"), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  var task = Task(
                      title: titlecontroller.text,
                      description: descriptioncontroller.text,
                      id: uuid.v1(),
                      date: DateFormat('dd-MM-yyyy hh-mm')
                          .format(now)
                          .toString());
                  context.read<TasksBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
