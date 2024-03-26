import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_event_notifier/simple_event_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late StreamSubscription<String> subscription;

  @override
  void initState() {
    subscription = EventNotifier.receive('button_pressed', eventTriggerCallback);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void eventTriggerCallback(){
    print("eventTriggerCallback");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event Notifier Example'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () {
              EventNotifier.notify('button_pressed');
            },
            child: Text('Press me'),
          ),
        ),
      ),
    );
  }
}