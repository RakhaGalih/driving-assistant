import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdla/components/appbar.dart';
import 'package:sdla/components/container.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/services/converter.dart';
import 'package:sdla/services/provider.dart';

class Notifcation extends StatelessWidget {
  const Notifcation({super.key});

  @override
  Widget build(BuildContext context) {
    final timerService = Provider.of<TimerService>(context);
    return Scaffold(
      body: Column(
        children: [
          const GradientAppBar(),
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
                child: FutureBuilder<List<DateTime>>(
                    future: timerService.getNotifications(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Peringatan',
                                            style: kSemiBoldTextStyle
                                                .copyWith(fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                           Text(
                                                convertTanggal(snapshot.data![index].toString()),
                                                style:
                                                    kMediumTextStyle.copyWith(
                                                        fontSize: 12,
                                                        color: kGreyText),
                                              ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Anda Telah Berkendara selama 7 jam, Segera Istirahat',
                                            style: kRegularTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    })),
          ),
        ],
      ),
    );
  }
}
