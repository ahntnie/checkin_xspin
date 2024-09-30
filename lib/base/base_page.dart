import 'package:flutter/material.dart';
import 'package:klok/constants/app_color.dart';

class BasePage extends StatefulWidget {
  final bool showLogo;
  final bool showSearch;
  final String? title;
  final bool showLogout;
  final bool showAppBar;
  final Widget body;
  final Widget? bottomNav;
  final bool showLeading;
  final VoidCallback? onPressedLeading;
  final Widget? bottomSheet;
  const BasePage({
    super.key,
    this.showLogo = false,
    this.showSearch = false,
    this.title,
    this.showLogout = false,
    this.showAppBar = true,
    this.bottomSheet,
    required this.body,
    this.bottomNav,
    this.showLeading = true,
    this.onPressedLeading,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.extraColor,
        appBar: widget.showAppBar
            ? AppBar(
                toolbarHeight: 70,
                backgroundColor: AppColor.primaryColor,
                centerTitle: true,
                title: Text(
                  widget.title ?? '',
                  style: const TextStyle(
                      color: AppColor.extraColor, fontWeight: FontWeight.bold),
                ),
              )
            : null,
        body: widget.body,
        bottomNavigationBar: widget.bottomNav,
        bottomSheet: widget.bottomSheet,
      ),
    );
  }
}
