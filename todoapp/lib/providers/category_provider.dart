import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/utils/utils.dart';

final categoryProvider = StateProvider<TaskCategory>((ref) {
  return TaskCategory.others;
});
