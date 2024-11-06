import 'package:demo/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:demo/Provider/provider.dart';
import 'package:provider/provider.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RegistrationProvider(),
      child: const MaterialApp(
        home: StartScreen(),
      ),
    ),
  );
}
