import 'package:flutter/material.dart';
import 'package:habit_tracker/View/Screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'DataBase/habit_datebase.dart';
import 'Provider/theme_provider.dart';
import 'View/Screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HabitDatabase(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
