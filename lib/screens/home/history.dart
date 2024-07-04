import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/calendar.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/screens/home/notification.dart';
import 'package:sdla/services/converter.dart';
import 'package:sdla/services/provider.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SelectedDateProvider>(context, listen: false).fetchDataTrip();
  }

  @override
  Widget build(BuildContext context) {
    final SelectedDateProvider selectedDateProvider =
        Provider.of<SelectedDateProvider>(context);
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
                        /*
                        Text(
                          'Total Perjalanan 356 Km',
                          style: kRegularTextStyle.copyWith(
                              fontSize: 12, color: kWhite),
                        ),*/
                        Text(
                          convertTanggal(
                              selectedDateProvider.selectedDay.toString()),
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
                                  targetConvert(selectedDateProvider.durasi),
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
                            /*
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
                            )*/
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
