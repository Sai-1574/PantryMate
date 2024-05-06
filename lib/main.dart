import 'package:flutter/material.dart';
// import 'package:lastone/pages/pantry.dart';
// import 'package:lastone/pages/chat_page.dart';
import 'package:lastone/pages/pantry.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RecipeGeneratorPage(),
    );
  }
}


