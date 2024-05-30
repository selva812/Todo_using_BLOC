import 'package:flutter/material.dart';

import '../model/task.dart';

class PopUpMenu extends StatelessWidget {
  final VoidCallback cancelorDeletecallback;
  final VoidCallback likeorDislike;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;
  const PopUpMenu(
      {super.key,
      required this.task,
      required this.cancelorDeletecallback,
      required this.likeorDislike,
      required this.restoreTaskCallback,
      required this.editTaskCallback});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: editTaskCallback,
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeorDislike,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavourite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavourite == false
                        ? const Text("Add to Bookmark")
                        : const Text("Remove from Bookmark"),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelorDeletecallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text("Delete"),
                  ),
                ),
              ]
          : (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: restoreTaskCallback,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text("Restore"),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text("Delete Forever"),
                  ),
                  onTap: () {},
                ),
              ],
    );
  }
}
