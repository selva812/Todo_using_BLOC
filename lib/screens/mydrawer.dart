import 'package:flutter/material.dart';
import 'package:todo_using_bloc/screens/recyclebin.dart';
import 'package:todo_using_bloc/screens/task_screen.dart';

import '../blocs/bloc_export.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text(
                "Task Drawer",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TaskScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text("My Tasks"),
                    trailing: Text('${state.allTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Recycle Bin"),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Dark Mode",
                      style: TextStyle(fontSize: 20),
                    ),
                    Switch(
                        value: state.switchValue,
                        onChanged: (newvalue) {
                          newvalue
                              ? context.read<SwitchBloc>().add(SwitchOnEvent())
                              : context
                                  .read<SwitchBloc>()
                                  .add(SwitchOffEvent());
                        }),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
