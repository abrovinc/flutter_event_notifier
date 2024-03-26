library event_notifier;

import 'dart:async';

class EventNotifier {
  EventNotifier._();

  static final EventNotifier _instance = EventNotifier._();

  static EventNotifier get instance => _instance;

  final StreamController<String> _publisher =
      StreamController<String>.broadcast();

  static void notify(String eventId) {
    instance._publisher.sink.add(eventId);
  }

  static StreamSubscription<String> receive(
      final String eventId, final void Function() callback) {
    return instance._publisher.stream.listen((streamEventId) {
      if (streamEventId == eventId) {
        callback();
      }
    });
  }
}
