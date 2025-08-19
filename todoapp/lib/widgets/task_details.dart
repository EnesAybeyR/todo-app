import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/data/models/models.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:todoapp/widgets/circle_container.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    return Padding(
      padding: EdgeInsets.all(30),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleContainer(
              color: task.category.color.withOpacity(0.3),
              child: Center(
                child: Icon(task.category.icon, color: task.category.color),
              ),
            ),
            Gap(16),
            Text(
              task.title.toUpperCase(),
              style: style.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              task.time,
              style: style.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            Gap(16),
            Visibility(
              visible: !task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("task to be completed on ${task.date}"),
                  Icon(
                    Icons.check_box_outline_blank,
                    color: task.category.color,
                    size: 14,
                  ),
                ],
              ),
            ),

            Divider(thickness: 1.5, color: task.category.color),

            Text(
              task.note.isEmpty
                  ? "There is no additional note for this task"
                  : task.note,
            ),
            Visibility(
              visible: task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("task is completed"),
                  Icon(Icons.check_box, color: Colors.green, size: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
