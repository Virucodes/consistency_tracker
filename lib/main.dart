import 'package:consistency_tracker/database/habit_database.dart';
import 'package:consistency_tracker/pages/home_page.dart';
import 'package:consistency_tracker/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(MultiProvider(
     providers: [
        ChangeNotifierProvider(create:(context) => HabitDatabase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

     ],
     child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
