import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:todoapp/data/models/models.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/extensions.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:todoapp/widgets/widgets.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DisplayWhiteText(text: "Add New Task")),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: "Task Title",
                title: "Task Title",
                controller: titleController,
              ),
              Gap(10),
              SelectCategory(),
              Gap(10),
              SelectDateTime(),
              Gap(10),
              CommonTextField(
                hintText: "...",
                title: "Note",
                maxLines: 5,
                controller: noteController,
              ),
              Gap(20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    context.colorScheme.primary,
                  ),
                ),
                onPressed: _createTask,
                child: DisplayWhiteText(text: "Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = titleController.text.trim();
    final note = noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);
    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Title is empty")));
    } else if (note.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Note is empty")));
    } else {
      final task = Task(
        title: title,
        note: note,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        isCompleted: false,
        category: category,
      );
      await ref.read(taskProvider.notifier).createTask(task).then((val) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Task created successfully")));

        context.go(RouteLocation.home);
      });
    }
  }
}
