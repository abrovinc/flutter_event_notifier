import 'dart:async';

import 'package:event_notifier/event_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var notified = 0;
  StreamSubscription<String>? subscription;

  incrementNotified() {
    notified++;
  }

  setUp(() {
    notified = 0;
  });

  tearDown(() => {subscription!.cancel()});

  test('notified on eventId', () async {
    const eventId = "eventId";
    subscription = EventNotifier.receive(eventId, incrementNotified);
    EventNotifier.notify(eventId);
    await Future.delayed(const Duration(seconds: 1));
    expect(notified, 1);
  });

  test('notified twice on eventId', () async {
    const eventId = "eventId";
    subscription = EventNotifier.receive(eventId, incrementNotified);
    EventNotifier.notify(eventId);
    EventNotifier.notify(eventId);
    await Future.delayed(const Duration(seconds: 1));
    expect(notified, 2);
  });

  test('not notified on OtherEventId', () async {
    const eventId = "eventId";
    subscription = EventNotifier.receive("OtherEventId", incrementNotified);
    EventNotifier.notify(eventId);
    await Future.delayed(const Duration(seconds: 1));
    expect(notified, 0);
  });
}
