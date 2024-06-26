# Flutter Event Notifier

## Introduction
Flutter Event Notifier is a simple library designed to facilitate event notification and subscription management in Flutter applications. It provides a convenient way to notify components of specific events and subscribe to those events with callbacks.

Its a independent solution to trigger a callback function whenever a specific eventID has been published on a event queue. 

## Installation
To use Flutter Event Notifier in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  simple_event_notifier: ^0.0.3
```

Then, run flutter pub get to install the package.


## Usage
Import the flutter_simple_event_notifier library into your Dart file.

```dart
import 'package:simple_event_notifier/simple_event_notifier.dart';
```

Initialize an singleton instance of EventNotifier.
```dart
EventNotifier notifier = EventNotifier.instance;
```

Subscribe to events and specify a callback function to handle the event.
```dart
StreamSubscription<String> subscription = EventNotifier.receive('my_event_id', () {
  // Handle the event
});
```

Notify events using notifyEventId().

```dart
EventNotifier.notify('my_event_id');
```

Don't forget to cancel the subscription when it's no longer needed.
```dart
subscription.cancel();
```

### Example

```dart
import 'dart:async';
import 'package:flutter/material.dart';
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
```

# Features and Limitations
Provides a simple API for event notification and subscription management.
Supports multiple subscribers for the same event.

Does not support event payloads out of the box. You can extend the library to handle event data if needed.
## Feedback and Contributions
Feedback, bug reports, and contributions are welcome! 
If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request on GitHub.