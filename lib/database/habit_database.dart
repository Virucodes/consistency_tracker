import 'package:consistency_tracker/models/app_settings.dart';
import 'package:consistency_tracker/models/habit.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /*
    SETUP


  */

  //INITIALISATION- DATABASE

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppSettingsSchema], directory: dir.path);
  }

  //Save first date of app startup(for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //Get first date of app startup (for heatmap)

  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }
  /*

   CRUD-OPERATIONS

   */

  //list of Habits
  final List<Habit> currentHaibts = [];

  //CREATE -  add a new habit
  Future<void> addHabit(String habitName) async {
    //create a new habit
    final newHabit = Habit()..name = habitName;

    //save a habit
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //read habit

    readHabits();
  }

  //READ - read saved habits from db

  Future<void> readHabits() async {
    //fetch all habits from the database
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    //give to the current habits

    currentHaibts.clear();
    currentHaibts.addAll(fetchedHabits);

    //update UI
    notifyListeners();
  }

  //UPDATE - check habit on or off

  Future<void> updateHabits(int id, bool isCompleted) async {
    //find the specific habit
    final habit = await isar.habits.get(id);

    //update completion status
    if (habit != null) {
      //-> if habit is completed add the current date to completed List
      isar.writeTxn(() async {
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();

          //add the current date if it's not already in list

          habit.completedDays.add(DateTime(
            today.year,
            today.month,
            today.day,
          ));
        }
        //-> if habit is not completed -> remove the current date from completed list
        else {
          //remove the currentdate if the habit is marked as not completed

          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }

        //save the updated habits

        await isar.habits.put(habit);
      });
    }

    //re-read from db
    readHabits();
  }

  //UPDATE - edit habit name
  Future<void> updateHabitName(int id, String newHabitName) async {
    //find the specific habit
    final habit = await isar.habits.get(id);

    //update habit name

    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newHabitName;
        //save updated habit back to db
        await isar.habits.put(habit);
      });
    }

    //re-read from db
    readHabits();
  }

  //DELETE - delete a habit
  Future<void> deleteHabits(int id) async {
    // Perfrom the delete
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    // re-read from db
    readHabits();
  }
}
