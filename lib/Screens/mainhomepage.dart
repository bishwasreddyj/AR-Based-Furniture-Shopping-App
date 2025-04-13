// import 'package:artest1/Screens/homepage.dart';
import 'package:arfurnitureapp/Screens/cart.dart';
import 'package:arfurnitureapp/Screens/homepage.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),

        children: [HomePage(), CartScreen()],
      ),
    );
  }
}
