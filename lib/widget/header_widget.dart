import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF2465ac),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
