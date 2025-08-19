import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/widgets/widgets.dart';
import 'package:todoapp/utils/utils.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            hintText: "${DateFormat.yMMMd().format(date)}",
            title: "Date",
            readOnly: true,

            suffixIcon: IconButton(
              onPressed: () => _selectDate(context, ref),
              icon: FaIcon(FontAwesomeIcons.calendar),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: CommonTextField(
            hintText: Helpers.timeToString(time),
            title: "Time",
            readOnly: true,

            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: FaIcon(FontAwesomeIcons.clock),
            ),
          ),
        ),
      ],
    );
  }
}

void _selectTime(BuildContext context, WidgetRef ref) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    ref.read(timeProvider.notifier).state = pickedTime;
  }
}

void _selectDate(BuildContext context, WidgetRef ref) async {
  final initialDate = ref.read(dateProvider);
  DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime(2025),
    lastDate: DateTime(2077),
    initialDate: initialDate,
  );
  if (pickedDate != null) {
    ref.read(dateProvider.notifier).state = pickedDate;
  }
}
