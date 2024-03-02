import 'package:flutter/material.dart';
import 'package:sdla/components/appbar.dart';
import 'package:sdla/components/container.dart';
import 'package:sdla/constants/constant.dart';

class Notifcation extends StatelessWidget {
  const Notifcation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const GradientAppBar(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
              child: Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ShadowContainer(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Peringatan',
                                      style: kSemiBoldTextStyle.copyWith(
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '21:00',
                                      style: kMediumTextStyle.copyWith(
                                          fontSize: 14, color: kGreyText),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Anda Telah Berkendara selama 7 jam, Segera Istirahat',
                                  style:
                                      kRegularTextStyle.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
