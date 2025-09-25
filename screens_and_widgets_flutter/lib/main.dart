import 'package:flutter/material.dart';
import 'ui_elements_menu.dart';
import 'stacked_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layouts en Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UIElementsMenu(),
      routes: {'/stacked': (context) => const StackedWidgetsExample()},
    );
  }
}
