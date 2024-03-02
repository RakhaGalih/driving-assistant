import 'package:flutter/material.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/calendar.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/screens/home/notification.dart';

class Riwayat extends StatelessWidget {
  const Riwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 242,
            decoration: const BoxDecoration(gradient: kGradientBlue),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Aktivitas',
                          style: kSemiBoldTextStyle.copyWith(
                              fontSize: 20, color: kWhite),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Total Perjalanan 356 Km',
                          style: kRegularTextStyle.copyWith(
                              fontSize: 12, color: kWhite),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '56j 24M',
                                  style: kSemiBoldTextStyle.copyWith(
                                      fontSize: 15, color: kWhite),
                                ),
                                Text(
                                  'Durasi',
                                  style: kRegularTextStyle.copyWith(
                                      fontSize: 12, color: kWhite),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '100',
                                  style: kSemiBoldTextStyle.copyWith(
                                      fontSize: 15, color: kWhite),
                                ),
                                Text(
                                  'Km/Jam',
                                  style: kRegularTextStyle.copyWith(
                                      fontSize: 12, color: kWhite),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '356',
                                  style: kSemiBoldTextStyle.copyWith(
                                      fontSize: 15, color: kWhite),
                                ),
                                Text(
                                  'Kilometer',
                                  style: kRegularTextStyle.copyWith(
                                      fontSize: 12, color: kWhite),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: AppBarButton(
                      child: const Icon(Icons.notifications),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Notifcation()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const MyCalendar()
        ],
      ),
    );
  }
}
