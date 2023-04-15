import 'package:flutter/material.dart';
import 'package:tasklie_new/components/extension.dart';

class ReUsableRegisterButton extends StatelessWidget {
  final String text;
  final Icon? icon;
  const ReUsableRegisterButton({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: context.dynamicWidth(327),
          height: context.dynamicHeight(56),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.black))),
            ),
            child: Row(
              children: [
                icon!,
                // Icon(FontAwesomeIcons.google, color: Colors.black,)
                const SizedBox(width: 10),

                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
