import 'package:flutter/material.dart';
import 'package:todo_using_bloc/screens/mydrawer.dart';
import 'package:todo_using_bloc/widgets/tasks_list.dart';

import '../blocs/bloc_export.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recycle Bin"),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text("Delete all tasks"),
                    ),
                    onTap: () => context.read<TasksBloc>().add(DeleteAllTask()),
                  ),
                ],
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${state.removedTasks.length}  Tasks'),
                ),
              ),
              TasksList(tasklist: state.removedTasks)
            ],
          ),
        );
      },
    );
  }
}
