import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/player/player_provider.dart';
import 'features/welcome/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerProvider(),
      child: MaterialApp(
        title: 'GenX Radio App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color.fromARGB(255, 107, 97, 123),
          scaffoldBackgroundColor: Colors.black,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: const WelcomeScreen(), // Starts from the Welcome screen
      ),
    );
  }
}
