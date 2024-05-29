import 'package:flutter/material.dart';
import 'package:todo_using_bloc/model/task.dart';
import 'package:todo_using_bloc/widgets/tasktile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasklist,
  });
  final List<Task> tasklist;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: tasklist.length,
          itemBuilder: (context, index) {
            var task = tasklist[index];
            return TaskTile(task: task);
          }),
    );
  }
}
