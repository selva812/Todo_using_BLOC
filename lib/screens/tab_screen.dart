import 'package:flutter/material.dart';
import 'package:todo_using_bloc/screens/add_task_screen.dart';
import 'package:todo_using_bloc/screens/complete_task_screen.dart';
import 'package:todo_using_bloc/screens/favourite_task_screen.dart';
import 'package:todo_using_bloc/screens/mydrawer.dart';
import 'package:todo_using_bloc/screens/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> pageDetails = [
    {'pageName': const PendingTaskScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTaskScreen(), 'title': 'Completed Tasks'},
    {'pageName': const FavouriteTaskScreen(), 'title': 'Favourite Tasks'},
  ];

  var seletedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageDetails[seletedPageIndex]['title']),
        actions: [
          IconButton(
              onPressed: () => _addTask(context), icon: const Icon(Icons.add))
        ],
      ),
      drawer: MyDrawer(),
      body: pageDetails[seletedPageIndex]['pageName'],
      floatingActionButton: seletedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: "Add",
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: seletedPageIndex,
        onTap: (index) {
          setState(() {
            seletedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp),
              label: "Pending Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: "Completed Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "favorite Tasks"),
        ],
      ),
    );
  }
}
