// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:tasklie_new/components/extension.dart';
// import 'package:tasklie_new/main.dart';
// import 'package:tasklie_new/pages/create_team.dart';
// import 'package:tasklie_new/pages/createproject.dart';

// class GetStartedButton extends StatefulWidget {
//   const GetStartedButton({Key? key}) : super(key: key);

//   @override
//   State<GetStartedButton> createState() => _GetStartedButtonState();
// }

// String createTeamProjectRefName = '';

// class _GetStartedButtonState extends State<GetStartedButton> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         String result = '';
//         Random random = Random();
//         for (int i = 0; i < 20; i++) {
//           result += random.nextInt(10).toString();
//         }
//         if (getStartedButtonCategoryIndex == 0) {
//           if (!mounted) return;
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen bir kategori seçiniz")));
//           return;
//         }
//         if (getStartedButtonFormKey.currentState!.validate()) {
//           if (!mounted) return;
//           Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTeams(projectID: result)));
//         } else {
//           if (!mounted) return;
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen tüm alanları doldurunuz")));
//           return;
//         }

//         createTeamProjectRefName = '$getStartedButtonCategoryIndex-${getStartedButtonProjectNameController.text}-${currentUser!.email}-$result';
//         if (!mounted) return;
//         Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTeams(projectID: result)));
//       },
//       child: Container(
//         width: context.dynamicWidth(300),
//         height: context.dynamicHeight(50),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           gradient: const LinearGradient(
//             colors: [Color.fromARGB(255, 84, 119, 248), Color.fromARGB(255, 87, 171, 249)],
//           ),
//         ),
//         child: const Center(
//           child: Text(
//             'Takım Oluşturmaya Geç',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }
