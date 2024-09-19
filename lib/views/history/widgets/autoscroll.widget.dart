import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const AutoScrollingText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  _AutoScrollingTextState createState() => _AutoScrollingTextState();
}

class _AutoScrollingTextState extends State<AutoScrollingText> {
  late ScrollController _scrollController;
  late Timer _timer;
  bool _scrollForward = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startScrolling();
  }

  void _startScrolling() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentOffset = _scrollController.offset;

        if (_scrollForward) {
          if (currentOffset < maxScrollExtent) {
            _scrollController.animateTo(currentOffset + 3.0,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          } else {
            _scrollForward = false;
          }
        } else {
          if (currentOffset > 0) {
            _scrollController.animateTo(currentOffset - 3.0,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          } else {
            _scrollForward = true;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Text(widget.text, style: widget.style),
    );
  }
}
