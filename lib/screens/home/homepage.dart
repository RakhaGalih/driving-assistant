import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdla/components/appbar.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/screens/home/notification.dart';
import 'package:sdla/services/converter.dart';
import 'package:sdla/services/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<TimerService>(builder: (context, timerService, child) {
        return SingleChildScrollView(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                              value: timerService.ratio,
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
                                    '${addZero(timerService.hoursTime)} : ${addZero(timerService.minutesTime)} : ${addZero(timerService.secondsTime)}',
                                    style: kSemiBoldTextStyle.copyWith(
                                        fontSize: 40),
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
                                        (timerService.remainding == null)
                                            ? '-'
                                            : targetConvert(
                                                timerService.remainding ?? 0),
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
                      'Target : ${targetConvert(timerService.target)}',
                      style: kLightTextStyle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    (timerService.isStarted)
                        ? (timerService.isPaused)
                            ? MainButton(
                                title: 'Lanjutkan',
                                icon: Icons.play_arrow,
                                onTap: () {
                                  timerService.startTimer();
                                },
                              )
                            : MainButton(
                                title: 'Jeda',
                                icon: Icons.pause,
                                onTap: () async {
                                  await timerService.stopTimer();
                                },
                              )
                        : MainButton(
                            title: 'Mulai',
                            icon: Icons.play_arrow,
                            onTap: () {
                              timerService.mulai();
                            },
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (timerService.isPaused)
                      SecondaryButton(
                          title: 'Mulai Ulang',
                          icon: Icons.restart_alt,
                          onTap: () {
                            timerService.mulaiUlang();
                          })
                    /*SecondaryButton(
                            title: 'Cek Lokasi', icon: Icons.place, onTap: () {})*/
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
