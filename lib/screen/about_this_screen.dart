import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutThisApp extends StatefulWidget {
  const AboutThisApp({super.key});

  @override
  State<AboutThisApp> createState() => _AboutThisAppState();
}

class _AboutThisAppState extends State<AboutThisApp> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ABOUT THIS APP',
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/img/initomat.jpg'),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Aplikasi ini dibuat untuk memenuhi syarat kelulusan.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
