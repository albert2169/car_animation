import 'package:animated_car/car_animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Call init before using Rive.
  await RiveNative.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const CarAnimationScreen(),
    );
  }
}
