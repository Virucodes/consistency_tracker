//given a list of habits
//is habit completed today

import 'package:consistency_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();

  return completedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}

//prepare heatmap dataset

Map<DateTime, int> prepareHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> datasets = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      //normalize date to avoid time-mismatch
      final normalizeDate = DateTime(date.year, date.month, date.day);

      //if date is present in dataset increment its count
      if (datasets.containsKey(normalizeDate)) {
        datasets[normalizeDate] = datasets[normalizeDate]! + 1;
      } else {
        //else initialize with 1
        datasets[normalizeDate] = 1;
      }
    }
  
  }
    return datasets;
}
