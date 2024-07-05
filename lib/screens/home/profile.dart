import 'package:flutter/material.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/components/container.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/screens/auth/login.dart';
import 'package:sdla/screens/pages/update_profile.dart';
import 'package:sdla/services/converter.dart';
import 'package:sdla/services/http_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String nama = "loading...";
  String image = "null";
  String? tanggal;
  int totalDurasi = 0;
  int durasiTerakhir = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      var response = await getUserDetails();
      var tripResponse = await getUserTrip();
      nama = response['name'];
      image = response['image'];

      totalDurasi = tripResponse['data']['total_duration'];
      List<dynamic> trips = tripResponse['data']['trips'];
      durasiTerakhir = trips[trips.length - 2]['duration'];
      tanggal = trips[trips.length - 2]['start_time'];
      setState(() {});
    } catch (e) {
      nama = "Fetch data error";
      print('Fetch data error: $e');
    }
  }

  Future<void> _navigateAndDisplayResult(BuildContext context) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpdateProfile()));

    // Check what was returned and act accordingly
    if (result != null) {
      await _fetchUserData();
      if (mounted) {
        setState(() {});
      }
    }
  }

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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: (image == "null")
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CircularProgressIndicator(
                                      color: kWhite,
                                    ),
                                  ),
                                )
                              : MyNetworkImage(
                                  imageURL: image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          nama,
                          style: kSemiBoldTextStyle.copyWith(
                              fontSize: 20, color: kWhite),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () async {
                          await _navigateAndDisplayResult(context);
                        },
                        child: const AppBarButton(child: Icon(Icons.settings))),
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
                ShadowContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aktivitas',
                        style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                      ),
                      /*
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Total Perjalanan 356 Km',
                        style: kRegularTextStyle.copyWith(fontSize: 12),
                      ),*/
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
                                targetConvert(totalDurasi),
                                style:
                                    kSemiBoldTextStyle.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Total Durasi',
                                style: kRegularTextStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          /*
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
                          */
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
                        convertTanggal(tanggal),
                        style: kSemiBoldTextStyle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        targetConvert(durasiTerakhir),
                        style: kRegularTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                MainButton(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () async {
                    try {
                      await logout();
                      print('berhasil logout!');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    } catch (e) {
                      print(e);
                    }
                  },
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
