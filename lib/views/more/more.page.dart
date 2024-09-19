import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:klok/base/base_page.dart';
import 'package:klok/views/more/widgets/custombutton.widget.dart';
import 'package:klok/views/more/widgets/info_app.widget.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'Khác',
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomMenuButton(
                  icon: Icons.info,
                  text: 'Thông tin ứng dụng',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const InfoApp()),
                    );
                  }),
              CustomMenuButton(
                  icon: Icons.share, text: 'Chia sẻ ứng dụng', onTap: () {}),
            ],
          ),
        ));
  }
}
