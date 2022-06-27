// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:transportation/pages/history/history_page.dart';
import 'package:transportation/pages/home/home_page.dart';
import 'package:transportation/pages/order/order_page.dart';
import 'package:transportation/pages/profile/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = PageController(initialPage: 0);
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          OrderPage(),
          HistoryPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          if (!mounted) return;
          setState(() => selectedTab = index);

          controller.animateToPage(
            index,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutQuad,
          );
        },
        activeColor: Color(0xFFF59D31),
        iconSize: 24,
        selectedIndex: selectedTab,
        barItems: [
          BarItem(title: 'Home', icon: CupertinoIcons.house_fill),
          BarItem(title: 'Order', icon: CupertinoIcons.doc_on_doc_fill),
          BarItem(title: 'History', icon: Icons.view_agenda),
          BarItem(title: 'Profile', icon: Icons.person),
        ],
      ),
    );
  }
}
