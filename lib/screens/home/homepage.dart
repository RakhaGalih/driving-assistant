import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sdla/components/appbar.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/screens/home/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isStarted = false;
  bool isPaused = false;
  Timer? _timer;
  int _time = 0;
  final int _target = 67;
  int? _remainding;
  double? _ratio;
  int _hoursTime = 0;
  int _minutesTime = 0;
  int _secondsTime = 0;
  int _hoursRemainder = 0;
  int _minutesRemainder = 0;
  int _secondsRemainder = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_remainding == 0) {
          setState(() {
            timer.cancel();
            isPaused = true;
          });
        } else {
          setState(() {
            _time++;
            _remainding = _target - _time;
            _ratio = _time / _target;
            timeCorvert();
            remainingTimeCorvert();
          });
        }
      },
    );
  }

  String addZero(int value) {
    if ((value / 10).floor() == 0) {
      return '0$value';
    } else {
      return '$value';
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

  String targetConvert(int? time) {
    int temp;
    int hours = (time! / 3600).floor();
    temp = time - hours * 3600;
    int minutes = (temp / 60).floor();
    temp = temp - minutes * 60;
    int seconds = temp;
    if (hours != 0) {
      return '$hours Jam $minutes Menit';
    } else if (minutes != 0) {
      return '$minutes Menit $seconds Detik';
    } else {
      return '$seconds Detik';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            BackGroundAppBar(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo,',
                        style: kRegularTextStyle.copyWith(
                            fontSize: 16, color: kWhite),
                      ),
                      Text(
                        'Rakha',
                        style: kSemiBoldTextStyle.copyWith(
                            fontSize: 32, color: kWhite),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Siap Mulai Perjalanan Hari Ini',
                        style: kMediumTextStyle.copyWith(
                            fontSize: 12, color: kWhite),
                      )
                    ],
                  ),
                  AppBarButton(
                    child: const Stack(
                      children: [
                        Icon(Icons.notifications),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notifcation()));
                    },
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              color: kWhite,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: width * 0.75,
                    width: width * 0.75,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: width * 0.75,
                          width: width * 0.75,
                          child: CircularProgressIndicator(
                            value: (_ratio == null) ? 0 : _ratio,
                            color: kBlue,
                            backgroundColor: kIndigo,
                            strokeWidth: 10,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${addZero(_hoursTime)} : ${addZero(_minutesTime)} : ${addZero(_secondsTime)}',
                                  style:
                                      kSemiBoldTextStyle.copyWith(fontSize: 40),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sisa waktu : ',
                                      style: kLightTextStyle.copyWith(
                                          fontSize: 15),
                                    ),
                                    Text(
                                      (_remainding == null)
                                          ? '-'
                                          : targetConvert(_remainding),
                                      style: kMediumTextStyle.copyWith(
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Target : ${targetConvert(_target)}',
                    style: kLightTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  (isStarted)
                      ? (isPaused)
                          ? MainButton(
                              title: 'Lanjutkan',
                              icon: Icons.play_arrow,
                              onTap: () {
                                setState(() {
                                  startTimer();
                                  isPaused = false;
                                });
                              },
                            )
                          : MainButton(
                              title: 'Jeda',
                              icon: Icons.pause,
                              onTap: () {
                                setState(() {
                                  _timer?.cancel();
                                  isPaused = true;
                                });
                              },
                            )
                      : MainButton(
                          title: 'Mulai',
                          icon: Icons.play_arrow,
                          onTap: () {
                            setState(() {
                              _time = 0;
                              startTimer();
                              isStarted = true;
                            });
                          },
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  (isPaused)
                      ? SecondaryButton(
                          title: 'Mulai Ulang',
                          icon: Icons.restart_alt,
                          onTap: () {
                            setState(() {
                              _time = 0;
                              _remainding = _target - _time;
                              _ratio = _time / _target;
                              timeCorvert();
                              remainingTimeCorvert();
                            });
                          })
                      : SecondaryButton(
                          title: 'Cek Lokasi', icon: Icons.place, onTap: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
