import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_using_bloc/blocs/task_bloc/tasks_bloc.dart';
import 'package:todo_using_bloc/model/task.dart';
import 'package:todo_using_bloc/widgets/tasks_list.dart';

class FavouriteTaskScreen extends StatelessWidget {
  const FavouriteTaskScreen({super.key});
  static const id = 'tasks_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasksList = state.favouriteTasks;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text('${tasksList.length} Tasks'),
            ),
          ),
          TasksList(tasklist: tasksList)
        ],
      );
    });
  }
}
