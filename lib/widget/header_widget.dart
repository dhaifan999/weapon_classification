import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Klasifikasi Senjata',
        style: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF2465ac),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
