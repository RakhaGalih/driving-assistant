import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sdla/services/converter.dart';
import 'package:sdla/services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TimerService(this.flutterLocalNotificationsPlugin);
  bool _isStarted = false;
  bool _isPaused = false;
  int _time = 0;
  final int _target = 25200;
  int? _remainding;
  double _ratio = 0;

  int _hoursTime = 0;
  int _minutesTime = 0;
  int _secondsTime = 0;
  int _hoursRemainder = 0;
  int _minutesRemainder = 0;
  int _secondsRemainder = 0;
  late Timer _timer;
  

  bool get isStarted => _isStarted;
  bool get isPaused => _isPaused;
  int get time => _time;
  int get target => _target;
  int? get remainding => _remainding;
  double get ratio => _ratio;

  int get hoursTime => _hoursTime;
  int get minutesTime => _minutesTime;
  int get secondsTime => _secondsTime;
  int get hoursRemainder => _hoursRemainder;
  int get minutesRemainder => _minutesRemainder;
  int get secondsRemainder => _secondsRemainder;

  Future<void> startTimer() async {
    try {
      Map<String, dynamic> response = await startTrip();
      print(response['success']);
      _isPaused = false;
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) async {
          if (_remainding == 0) {
            await stopTimer();
            timer.cancel();
            _isPaused = true;
            await _showNotification(); // Call notification method
          } else {
            _time++;
            _remainding = _target - _time;
            _ratio = _time / _target;
            timeCorvert();
            remainingTimeCorvert();
          }
          notifyListeners();
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void timeCorvert() {
    int temp;
    _hoursTime = (_time / 3600).floor();
    temp = _time - _hoursTime * 3600;
    _minutesTime = (temp / 60).floor();
    temp = temp - _minutesTime * 60;
    _secondsTime = temp;
  }

  void remainingTimeCorvert() {
    int temp;
    _hoursRemainder = (_remainding! / 3600).floor();
    temp = _remainding! - _hoursRemainder * 3600;
    _minutesRemainder = (temp / 60).floor();
    temp = temp - _minutesRemainder * 60;
    _secondsRemainder = temp;
  }

  void mulai() async {
    _time = 0;
    await startTimer();
    _isStarted = true;
    notifyListeners();
  }

  void mulaiUlang() {
    _time = 0;
    _remainding = _target - _time;
    _ratio = _time / _target;

    notifyListeners();
  }

  Future<void> stopTimer() async {
    try {
      Map<String, dynamic> response = await stopTrip();
      print(response['success']);
      _timer.cancel();
      _isPaused = true;
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  
  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'pomodoro_channel',
      'Pomodoro Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Pomodoro Timer',
      'Time to take a break!',
      platformChannelSpecifics,
    );
    _saveNotification();
  }

  Future<void> _saveNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.add(now.toIso8601String());
    await prefs.setStringList('notifications', notifications);
  }

  Future<List<DateTime>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    return notifications
        .map((notification) => DateTime.parse(notification))
        .toList();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class SelectedDateProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  int _durasi = 0;

  DateTime get selectedDay => _selectedDay;
  int get durasi => _durasi;

  void setSelectedDay(DateTime newDay) {
    _selectedDay = newDay;
    fetchDataTrip(); // Don't await here to allow the UI to remain responsive
    notifyListeners();
  }

  Future<void> fetchDataTrip() async {
    try {
      var tripResponse = await getUserTrip();
      Map<String, dynamic> dailyDuration =
          tripResponse["data"]["daily_durations"];
      _durasi = dailyDuration[dateTimeConverter(_selectedDay)] ?? 0;
    } catch (e) {
      print('Fetch data error: $e');
      _durasi =
          0; // Handle error condition, set _durasi to 0 or any default value
    }
    notifyListeners();
  }
}
