import 'package:flutter/material.dart';
import 'package:weapon_classification/screen/about_screen.dart';
import 'package:weapon_classification/screen/weapon_screen.dart';
import 'package:weapon_classification/screen/home_screen.dart';
import 'package:weapon_classification/widget/bottom_navbar_widget.dart';
import 'package:weapon_classification/widget/header_widget.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedNavbar = 0;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Widget screenBottomNavigation(int index) {
    if (index == 0) {
      return const HomePage();
    } else if (index == 1) {
      return const DiseasePage();
    } else {
      return const AboutPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        child: screenBottomNavigation(_selectedNavbar),
      ),
      bottomNavigationBar: BottomNavbarWidget(
        currentIndex: _selectedNavbar,
        onTap: _changeSelectedNavbar,
      ),
    );
  }
}
