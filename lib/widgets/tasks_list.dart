import 'package:flutter/material.dart';
import 'package:todo_using_bloc/model/task.dart';
import 'package:todo_using_bloc/widgets/tasktile.dart';
import 'package:uuid/uuid.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
    required this.tasklist,
  });
  final List<Task> tasklist;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ExpansionPanelList.radio(
        children: widget.tasklist
            .map(
              (task) => ExpansionPanelRadio(
                value: uuid.v1(),
                headerBuilder: (context, isOpen) => TaskTile(task: task),
                body: ListTile(
                  title: SelectableText.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Text \n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: task.title),
                        const TextSpan(
                          text: "\n\n Description \n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: task.description)
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}


// Expanded(
//       child: ListView.builder(
//           itemCount: tasklist.length,
//           itemBuilder: (context, index) {
//             var task = tasklist[index];
//             return TaskTile(task: task);
//           }),
//     );