import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_event_notifier/event_notifier.dart';

void main() {

  var notified = 0;
  StreamSubscription<String>? subscription;

  incrementNotified(){
    notified++;
  }

  setUp(() {
    notified = 0;
  });

  tearDown(() => {
    subscription!.cancel()
  });

  test('notified on eventId', () async {
    const eventId = "eventId";
    subscription = callbackOnNotify(eventId, incrementNotified);
    EventNotifier.instance.notifyEventId(eventId);
    await Future.delayed(const Duration(seconds: 1));
    expect(notified, 1);
  });

  test('notified twice on eventId', () async {
    const eventId = "eventId";
    subscription = callbackOnNotify(eventId, incrementNotified);
    EventNotifier.instance.notifyEventId(eventId);
    EventNotifier.instance.notifyEventId(eventId);
    await Future.delayed(const Duration(seconds: 1));
    expect(notified, 2);
  });

  test('not notified on OtherEventId', () async {
    const eventId = "eventId";
    subscription = callbackOnNotify("OtherEventId", incrementNotified);
    EventNotifier.instance.notifyEventId(eventId);
    await Future.delayed(const Duration(seconds: 1));
    expect(notified, 0);
  });
}

