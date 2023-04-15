import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/components/extension.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  //string değişkrn tanımlama
  final String title = "Planla";
  final String title2 = "Planlamaya başla ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //add image without container
          Image.asset(
            'assets/book.png',
            fit: BoxFit.cover,
            height: context.dynamicHeight(500),
          ),
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 37,
                color: Colors.black,
              )),
          Text(title2,
              textAlign: TextAlign.center,
              // style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w100),
              style: GoogleFonts.poppins(
                fontSize: 22,
                color: Colors.black,
              )),
          const SizedBox(height: 20),
          InkWell(
            child: Container(
              width: context.dynamicWidth(300),
              height: context.dynamicHeight(50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 84, 119, 248), Color.fromARGB(255, 87, 171, 249)],
                  )),
              child: const Center(
                child: Text(
                  'Başla',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          Text(
            "Don’t Have An Account? Get Started!",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
