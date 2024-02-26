import 'package:flutter/material.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/constants/constant.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/profile.png'),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Bagas Saputra',
                          style: kSemiBoldTextStyle.copyWith(
                              fontSize: 20, color: kWhite),
                        )
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: AppBarButton(child: Icon(Icons.settings)),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            color: kWhite,
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 45),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFDFEFF),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 1,
                            offset: const Offset(1, 4),
                            blurRadius: 4)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aktivitas',
                        style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Total Perjalanan 356 Km',
                        style: kRegularTextStyle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'images/car.png',
                            height: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                '56j 24M',
                                style:
                                    kSemiBoldTextStyle.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Durasi',
                                style: kRegularTextStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                '100',
                                style:
                                    kSemiBoldTextStyle.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Km/Jam',
                                style: kRegularTextStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                '356',
                                style:
                                    kSemiBoldTextStyle.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Kilometer',
                                style: kRegularTextStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Aktivitas Terakhir',
                        style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kamis 21 Februari 2024',
                        style: kSemiBoldTextStyle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '18j 24m',
                        style: kRegularTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                MainButton(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {},
                  gradient: kGradientRed,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
