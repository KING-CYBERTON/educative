import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/realtime_coontoller.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  final Widget tabletScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
    required this.tabletScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
   final real = Get.put(Realtime());
  @override
  Widget build(BuildContext context) {
    const int webScreenSize = 600;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        return constraints.maxWidth > 900
            ? widget.webScreenLayout
            : widget.tabletScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
