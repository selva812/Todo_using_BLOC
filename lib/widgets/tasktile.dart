import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_using_bloc/model/task.dart';
import 'package:todo_using_bloc/screens/edit_tak.dart';
import 'package:todo_using_bloc/widgets/popup_menu.dart';

import '../blocs/bloc_export.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavourite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy  hh-mm").format(DateTime.now()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
              PopUpMenu(
                task: task,
                cancelorDeletecallback: () =>
                    _removeOrDeleteTask(context, task),
                likeorDislike: () => context
                    .read<TasksBloc>()
                    .add(MarkFavouriteTask(task: task)),
                editTaskCallback: () {
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                restoreTaskCallback: () =>
                    context.read<TasksBloc>().add(RestoreTask(task: task)),
              )
            ],
          ),
        ],
      ),
    );
  }
}



// ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//             decoration: task.isDone! ? TextDecoration.lineThrough : null),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDeleted == false
//             ? (value) {
//                 context.read<TasksBloc>().add(UpdateTask(task: task));
//               }
//             : null,
//       ),
//       onLongPress: () => _removeOrDeleteTask(context, task),
//     );
