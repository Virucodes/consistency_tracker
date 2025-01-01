import 'package:consistency_tracker/components/my_drawer.dart';
import 'package:consistency_tracker/components/my_habit_tile.dart';
import 'package:consistency_tracker/database/habit_database.dart';
import 'package:consistency_tracker/utils/habit_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consistency_tracker/models/habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //read the existing habit on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }

  //text controller
  final TextEditingController textController = TextEditingController();

  //create new habit
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Create a New Text",
                ),
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: () {
                    //get a new habit
                    String newHabitName = textController.text;

                    //save to db
                    context.read<HabitDatabase>().addHabit(newHabitName);

                    //pop box
                    Navigator.pop(context);

                    //clear controller
                    textController.clear();
                  },
                  child: const Text("Save"),
                ),

                //cancel button
                MaterialButton(
                  onPressed: () {
                    //pop box
                    Navigator.pop(context);

                    //clear controller
                    textController.clear();
                  },
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  //check habit on or off

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabits(habit.id, value);
    }
  }

  //edit habit
  void editHabitBox(Habit habit) {
    //set controller's text to current habit name
    textController.text = habit.name;

    showDialog(
      context: context,
       builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
             //save button
                MaterialButton(
                  onPressed: () {
                    //get a new habit
                    String newHabitName = textController.text;

                    //save to db
                    context.read<HabitDatabase>().updateHabitName(habit.id, newHabitName);

                    //pop box
                    Navigator.pop(context);

                    //clear controller
                    textController.clear();
                  },
                  child: const Text("Save"),
                ),

                //cancel button
                MaterialButton(
                  onPressed: () {
                    //pop box
                    Navigator.pop(context);

                    //clear controller
                    textController.clear();
                  },
                  child: const Text("Cancel"),
                )
          ],
       ));


  }

  //delete habit
  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
       builder: (context) => AlertDialog(
          content: const Text("Are you sure you want to delete?"),
          actions: [
             //save button
                MaterialButton(
                  onPressed: () {
                    
                    //save to db
                    context.read<HabitDatabase>().deleteHabits(habit.id);

                    //pop box
                    Navigator.pop(context);

                  },
                  child: const Text("Delete"),
                ),

                //cancel button
                MaterialButton(
                  onPressed: () {
                    //pop box
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
          ],
       ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: _buildHabitList(),
    );
  }

  Widget _buildHabitList() {
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits = habitDatabase.currentHaibts;

    //return list of habit UI

    return ListView.builder(
        itemCount: currentHabits.length,
        itemBuilder: (context, index) {
          //get each individual habit
          final habit = currentHabits[index];

          //check habit is completed
          bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

          //return habit title UI
          return MyHabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (value) => checkHabitOnOff(value, habit),
            editHabit: (context) => editHabitBox(habit),
            deleteHabit: (context) => deleteHabitBox(habit),
          );
        });
  }
}
