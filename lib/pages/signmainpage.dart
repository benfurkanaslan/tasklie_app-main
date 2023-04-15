import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/components/re_usable_register_button.dart';
import 'package:tasklie_new/pages/register_page.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Text(
            "Hesap Oluştur",
            textAlign: TextAlign.left,
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text("Loram ipsun after that...",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              )),
          const SizedBox(
            height: 20,
          ),
          const ReUsableRegisterButton(
            icon: Icon(FontAwesomeIcons.google, color: Colors.black),
            text: "Google ile devam et",
          ),
          const SizedBox(
            height: 20,
          ),
          const ReUsableRegisterButton(
            icon: Icon(FontAwesomeIcons.apple, color: Colors.black),
            text: "Apple ile devam et",
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Or continue with",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF9CA4AB),
              )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 327,
            height: 56,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 10, 17, 60)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
              ),
              child: const Text(
                "Continue with email",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA4AB),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Login',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: RichText(
              text: TextSpan(
                text: 'By signing up you agree to our ',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA4AB),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms and Conditions of Use',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
