import 'package:flutter/material.dart';
import 'package:todoapp/app/todo_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: TodoApp()));
}
