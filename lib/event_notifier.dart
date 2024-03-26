library flutter_event_notifier;

import 'dart:async';

class EventNotifier {
  EventNotifier._();

  static final EventNotifier _instance = EventNotifier._();

  static EventNotifier get instance => _instance;

  final StreamController<String> _publisher =
      StreamController<String>.broadcast();

  void notifyEventId(String eventId) {
    _publisher.sink.add(eventId);
  }
}

StreamSubscription<String> callbackOnNotify(
    final String eventId, final void Function() callback) {
  return EventNotifier.instance._publisher.stream.listen((streamEventId) {
    if (streamEventId == eventId) {
      callback();
    }
  });
}
