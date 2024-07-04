// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sdla/constants/constant.dart';

class AppBarButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Function()? onTap;
  const AppBarButton({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 48,
        height: height ?? 48,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: kWhite, shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(1, 3),
              blurRadius: 4,
              spreadRadius: 1)
        ]),
        child: child,
      ),
    );
  }
}
