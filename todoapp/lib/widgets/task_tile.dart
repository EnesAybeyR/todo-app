import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:todoapp/widgets/circle_container.dart';

import '../data/data.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({super.key, required this.task, this.onCompleted});
  final Task task;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final style = context.textTheme;
    final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    final double backgroundOpacity = task.isCompleted ? 0.1 : 0.3;
    final textDecoration = task.isCompleted
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(backgroundOpacity),
            child: Center(
              child: Icon(
                task.category.icon,
                color: task.category.color.withOpacity(iconOpacity),
              ),
            ),
          ),
          Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  task.time,
                  style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            activeColor: colors.primary,
            side: BorderSide(color: colors.primary),
            value: task.isCompleted,
            onChanged: onCompleted,
          ),
          GestureDetector(
            onTap: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Are you sure"),
                  content: Text("Are you sure you want to delete?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text("No"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await ref.read(taskProvider.notifier).deleteTask(task);
                        Navigator.pop(ctx);
                      },
                      child: Text("Yes"),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.delete, size: 26),
            ),
          ),
        ],
      ),
    );
  }
}
