import 'package:flutter/material.dart';
import 'screens/dj_main_screen.dart';

void main() {
  runApp(const VirtualDJApp());
}

class VirtualDJApp extends StatelessWidget {
  const VirtualDJApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual DJ Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.redAccent,
          surface: Colors.grey[900]!,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DJMainScreen(),
      },
    );
  }
}
