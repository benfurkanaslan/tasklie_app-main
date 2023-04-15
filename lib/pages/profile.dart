import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/components/extension.dart';
import 'package:tasklie_new/core/card_widget.dart';
import 'package:tasklie_new/core/my_task_container.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/pages/createproject.dart';
import 'package:tasklie_new/pages/message_view.dart';

import '../project_details/project_color.dart';

ScrollController _scrollController = ScrollController();

class Profile extends StatefulWidget {
  Profile({super.key});
  final String userName = currentUser!.name;
  final String listTitle = "${currentTasks.length} Görev";
  final String listTitle2 = "Son Projeler - (${currentTasks.length})";
  final String listTextButton = "Hepsini Gör";
  final List<String> myTaskString = [
    "In Process",
    "Running",
    "Complete",
    "Cancel",
  ];
  final List<String> myTask = [
    "UI/UX Tasarımı",
    "Kripto Cüzdan Uygulaması",
    "2 Ekranın Geliştirilmesi",
    "Kripto Cüzdan Uygulaması",
  ];
  final String date = "Mon, 10 July 2022";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: ProjectColorsUtitilty().backgroundPage,
        elevation: 0.0,
        leading: leadingWidget(),
        title: Text(widget.userName, style: TextStyle(color: ProjectColorsUtitilty().appBarText1)),
        actions: [
          appBarIconSearch(),
          appBarIconNotification(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 21.0, right: 21.0),
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    widget.listTitle,
                    style: GoogleFonts.workSans(
                      color: ProjectColorsUtitilty().appBarText2,
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateProjectPage()));
                    },
                    icon: const Icon(CupertinoIcons.add, color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTaskContainer(title: widget.myTaskString[0], taskNum: 0),
                    MyTaskContainer(title: widget.myTaskString[1], taskNum: 0),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTaskContainer(title: widget.myTaskString[2], taskNum: 0),
                      MyTaskContainer(title: widget.myTaskString[3], taskNum: 0),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    widget.listTitle2,
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
                      widget.listTextButton,
                      style: GoogleFonts.workSans(
                        color: ProjectColorsUtitilty().appBarText1,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: currentTasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            String messageViewConversationId =
                                '${currentTasks[index].projectDocName.split('-')[1]}-${currentTasks[index].projectDocName.split('-')[3]}-${currentTasks[index].teamId}';
                            // teamName-projectId-teamId
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MessageView(messageViewConversationId: messageViewConversationId)));
                          },
                          child: CardWidget(
                            taskTitle: currentTasks[index].teamName,
                            taskSubtitle: currentTasks[index].taskDescription,
                            date:
                                "${currentTasks[index].taskEndDate.toDate().day.toString().padLeft(2, '0')} - ${currentTasks[index].taskEndDate.toDate().month.toString().padLeft(2, '0')} - ${currentTasks[index].taskEndDate.toDate().year}",
                          ),
                        );
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

  Text appBarTitle() {
    return Text(
      widget.userName,
      style: GoogleFonts.workSans(
        color: ProjectColorsUtitilty().appBarText2,
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  IconButton appBarIconSearch() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.search,
          color: Colors.black,
          size: 25,
        ));
  }

  IconButton appBarIconNotification() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.bell,
        color: Colors.black,
      ),
    );
  }

  Padding leadingWidget() {
    if (currentUser!.photoUrl == '*') {
      return const Padding(
        padding: EdgeInsets.only(left: 14.0),
        child: Icon(CupertinoIcons.person, size: 45),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 14.0,
        ),
        child: Container(
          width: context.dynamicWidth(45),
          height: context.dynamicHeight(45),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: Image.network(currentUser!.photoUrl, fit: BoxFit.cover).image),
          ),
        ),
      );
    }
  }
}
