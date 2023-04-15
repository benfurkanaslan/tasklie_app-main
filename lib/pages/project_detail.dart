import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/core/card_widget.dart';
import 'package:tasklie_new/main.dart';
import '../project_details/project_color.dart';

ScrollController _scrollController = ScrollController();

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({super.key});
  final String date = "Mon, 10 July 2022";

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColorsUtitilty().backgroundPage,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
          statusBarColor: const Color.fromARGB(255, 255, 255, 255),
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: ProjectColorsUtitilty().backgroundPage,
        elevation: 0.0,
        title: Text(PageString().appBarTitle, style: Style().styel1, maxLines: 1),
        actions: [ProjectButtons().appBarAddButton],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProjectButtons().topIcons(PageString().textButton2),
                  ProjectButtons().topIcons(PageString().textButton3),
                  ProjectButtons().topIcons(PageString().textButton4),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  PageString().title1,
                  style: GoogleFonts.workSans(
                    color: ProjectColorsUtitilty().appBarText2,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      PageString().textButton1,
                      style: GoogleFonts.workSans(
                        color: ProjectColorsUtitilty().appBarText1,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentTasks.length,
                      itemBuilder: (context, index) {
                        return CardWidget(taskTitle: taskString[index], taskSubtitle: taskString[index + 1], date: widget.date);
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageString {
  final String appBarTitle = "Project Detail";
  final String title1 = "Süreçteki Projeler";
  final String textButton1 = "Dahasını Gör";
  final String textButton2 = "Tümü";
  final String textButton3 = "Öncelikli";
  final String textButton4 = "Okunmamış";
}

List<String> taskString = [
  "UI/UX Tasarımı",
  "Kripto Cüzdan Uygulaması",
  "Uygulama Designı",
  "Kripto Cüzdan Uygulaması",
  "Design App Screens ",
  "Kripto Cüzdan Uygulaması",
  "UI/UX Tasarımı",
  "Kripto Cüzdan Uygulaması",
];

// ignore: camel_case_types

class Style {
  final TextStyle styel1 = GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: ProjectColorsUtitilty().appBarText2,
  );
}

class ProjectButtons {
  final IconButton appBarAddButton = IconButton(
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.add,
        color: Colors.black,
      ));

  SizedBox topIcons(String text) {
    return SizedBox(
      width: 91,
      height: 27,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: BorderSide(width: 1, color: ProjectColorsUtitilty().iconColor),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: ProjectColorsUtitilty().iconColor,
            fontSize: 9,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
