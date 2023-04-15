import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/components/extension.dart';

class MyTaskContainer extends StatelessWidget {
  const MyTaskContainer({super.key, required this.title, required this.taskNum});
  final String title;
  final int taskNum;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.dynamicWidth(165),
      height: context.dynamicHeight(96),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(87, 124, 255, 0.71),
        image: DecorationImage(
          alignment: Alignment.topRight,
          image: Image.asset("assets/1.png").image,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.workSans(
              color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$taskNum Projects",
            style: GoogleFonts.workSans(
              color: Colors.white,
              fontSize: 10,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
