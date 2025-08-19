import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/providers/providers.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepositories _repositories;
  TaskNotifier(this._repositories) : super(const TaskState.initial()) {
    getTasks();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repositories.createTask(task);
      getTasks();
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repositories.deleteTask(task);
      getTasks();
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isCompleted: isCompleted);

      await _repositories.updateTask(updatedTask);
      getTasks();
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getTasks() async {
    try {
      final tasks = await _repositories.getAllTasks();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint("$e");
    }
  }
}
