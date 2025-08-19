import 'package:flutter/material.dart';
import 'task_keys.dart';

@immutable
class DBKeys {
  const DBKeys._();
  static const String dbName = "tasks";
  static const String dbTable = "tasks";
  static const String idColumn = TaskKeys.id;
  static const String titleColumn = TaskKeys.title;
  static const String noteColumn = TaskKeys.note;
  static const String timeColumn = TaskKeys.time;
  static const String dateColumn = TaskKeys.date;
  static const String isCompletedColumn = TaskKeys.isCompleted;
  static const String categoryColumn = TaskKeys.category;
}
