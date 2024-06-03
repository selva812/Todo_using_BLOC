import 'package:flutter/material.dart';
import 'package:todo_using_bloc/blocs/bloc_export.dart';
import 'package:todo_using_bloc/model/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({
    super.key,
    required this.oldTask,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptioncontroller =
        TextEditingController(text: oldTask.description);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          const Text(
            "Edit Task",
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
                  var editedtask = Task(
                      title: titlecontroller.text,
                      description: descriptioncontroller.text,
                      id: oldTask.id,
                      isFavourite: oldTask.isFavourite,
                      isDone: false,
                      date: DateTime.now().toString());
                  context.read<TasksBloc>().add(
                        EditTask(oldTask: oldTask, newTask: editedtask),
                      );
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
