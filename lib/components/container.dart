// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sdla/constants/constant.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  const ShadowContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [kBasicBoxShadow]),
      child: child,
    );
  }
}
