import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

String now() => DateTime.now().toIso8601String();

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Container(
      color: Colors.teal,
      height: 100,
      width: double.infinity,
      child: Center(
        child: Text(
          seconds.value,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

@immutable
class Minutes {
  final String value;
  Minutes() : value = now();
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Container(
      color: Colors.purple.shade300,
      height: 100,
      width: double.infinity,
      child: Center(
          child: Text(
        minutes.value,
        style: const TextStyle(fontSize: 20),
      )),
    );
  }
}

// Stream<String> newStream(Duration duration) =>
//     Stream.periodic(duration, (_) => now());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Center(
          child: MultiProvider(
            providers: [
              StreamProvider.value(
                  value: Stream<Seconds>.periodic(
                    const Duration(seconds: 1),
                    (_) => Seconds(),
                  ),
                  initialData: Seconds()),
              StreamProvider.value(
                  value: Stream<Minutes>.periodic(
                    const Duration(minutes: 1),
                    // const Duration(seconds: 5),
                    (_) => Minutes(),
                  ),
                  initialData: Minutes()),
            ],
            child: Column(
              children: const [
                SecondsWidget(),
                MinutesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
