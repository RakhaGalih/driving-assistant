// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sdla/constants/constant.dart';

class BackGroundAppBar extends StatelessWidget {
  final Widget? child;
  const BackGroundAppBar({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 242,
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: kGradientBlue),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('images/background.png',
              alignment: Alignment.bottomCenter,
              width: width,
              fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SafeArea(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: child)),
        ),
      ]),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  const GradientAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(gradient: kGradientBlue),
      child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const SizedBox(
                  width: 20,
                  child: Icon(
                    Icons.arrow_back,
                    color: kWhite,
                  ),
                ),
              ),
              Text(
                'Riwayat',
                style: kSemiBoldTextStyle.copyWith(fontSize: 16, color: kWhite),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )),
    );
  }
}
