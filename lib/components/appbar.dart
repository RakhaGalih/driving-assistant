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
