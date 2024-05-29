import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_using_bloc/blocs/task_bloc/tasks_bloc.dart';
import 'package:todo_using_bloc/model/task.dart';
import 'package:todo_using_bloc/screens/add_task_screen.dart';
import 'package:todo_using_bloc/screens/mydrawer.dart';
import 'package:todo_using_bloc/widgets/tasks_list.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  static const id = 'tasks_screen';
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Todo list"),
            actions: [
              IconButton(
                  onPressed: () => _addTask(context),
                  icon: const Icon(Icons.add))
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${state.allTasks.length} Tasks'),
                ),
              ),
              TasksList(tasklist: tasksList)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: "Add",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
