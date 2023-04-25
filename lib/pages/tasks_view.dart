import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart' as swp;
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/components/extension.dart';
import 'package:tasklie_new/core/card_widget.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/pages/message_view.dart';
import 'package:tasklie_new/project_details/project_color.dart';

ScrollController _scrollController = ScrollController();

class TaskViewPage extends StatefulWidget {
  TaskViewPage({super.key});
  final String dateTime = "İyi Akşamlar!";
  final String userName = currentUser!.name;
  final String weekTask = "Haftalık Görevlerim";
  final String dayTask = "Bugünün Görevleri";
  final int weekTaskTotal = 6;
  final int dayTaskTotal = 3;
  final String tasktitle = "UI/UX Design";
  final String taskImportantLevel = "Öncelikli";
  final String taskdetail = "Giriş Sayfasının Oluşturulması";
  final String date = "Salı, 24 Aralık 2022";
  final int teamTotal = 3;
  final String dayTaskTitle = "Mobil Uygulama UI Tasarımı";
  final String dayTaskSubtitle = "Kripto Cüzdan Uygulaması";

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

double _dotPosition = 0;

class _TaskViewPageState extends State<TaskViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColorsUtitilty().backgroundPage,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 8.0),
        child: Column(
          children: [
            ListTileWidget(taskType: widget.weekTask, taskTotal: widget.weekTaskTotal),
            Expanded(
              child: swp.Swiper(
                // itemCount: currentTasks.length,
                itemCount: (() {
                  if (currentTasks.isNotEmpty) {
                    return currentTasks.length;
                  } else {
                    return 1;
                  }
                }()),
                autoplay: true,
                autoplayDelay: 5000,
                autoplayDisableOnInteraction: true,
                loop: false,
                physics: const BouncingScrollPhysics(),
                itemWidth: context.dynamicWidth(203),
                onIndexChanged: (value) {
                  setState(() => _dotPosition = value.toDouble());
                },
                itemBuilder: (context, index) {
                  (() {
                    if (currentTasks.isNotEmpty) {
                      return GestureDetector(
                        onTap: () {
                          String messageViewConversationId =
                              '${currentTasks[index].projectDocName.split('-')[1]}-${currentTasks[index].projectDocName.split('-')[3]}-${currentTasks[index].teamId}';
                          // messageViewConversationId = 'teamName-projectId-teamId'
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MessageView(messageViewConversationId: messageViewConversationId)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: ProjectColorsUtitilty().containerColor,
                          ),
                          width: context.dynamicWidth(203),
                          height: context.dynamicHeight(230),
                          child: Column(
                            children: [
                              Expanded(child: containerTitle()),
                              Expanded(child: containerNote()),
                              Expanded(child: containerTeamAvatars()),
                              Expanded(child: containerDate()),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 15,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: ProjectColorsUtitilty().containerColor,
                        ),
                        width: context.dynamicWidth(203),
                        height: context.dynamicHeight(230),
                        child: Center(
                          child: Text(
                            "Görev Yok",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      );
                    }
                  }());
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DotsIndicator(
                dotsCount: (() {
                  if (currentTasks.isNotEmpty) {
                    return currentTasks.length;
                  } else {
                    return 1;
                  }
                }()),
                position: _dotPosition,
                decorator: DotsDecorator(
                  activeColor: Colors.grey.shade800,
                  size: const Size.square(9.0),
                  activeSize: const Size(28.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  spacing: const EdgeInsets.symmetric(horizontal: 4),
                ),
              ),
            ),
            ListTileWidget(taskType: widget.dayTask, taskTotal: widget.dayTaskTotal),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
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
                        itemBuilder: ((context, index) {
                          return CardWidget(
                            date:
                                "${currentTasks[index].taskEndDate.toDate().day.toString().padLeft(2, '0')} - ${currentTasks[index].taskEndDate.toDate().month.toString().padLeft(2, '0')} - ${currentTasks[index].taskEndDate.toDate().year}",
                            taskSubtitle: currentTasks[index].teamName,
                            taskTitle: currentTasks[index].taskDescription,
                          );
                        }),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: ProjectColorsUtitilty().backgroundPage,
      elevation: 0.0,
      leading: leadingWidget(),
      title: GestureDetector(
        onTap: () {
          auth.signOut();
        },
        child: AppBarTitle(dateTime: widget.dateTime, userName: widget.userName),
      ),
      actions: [
        appBarIconSearch(),
        appBarIconNotification(),
      ],
    );
  }

  Row containerDate() {
    return Row(
      children: [
        const Icon(Icons.date_range_outlined),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            maxLines: 1,
            widget.date,
            style: GoogleFonts.workSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: ProjectColorsUtitilty().dateText,
            ),
          ),
        ),
      ],
    );
  }

  Row containerTeamAvatars() {
    return Row(
      children: [
        Stack(
          children: [
            const CircleAvatar(),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: CircleAvatar(
                backgroundColor: ProjectColorsUtitilty().teamTotal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.teamTotal}+",
                      style: GoogleFonts.workSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text containerNote() {
    return Text(
      widget.taskdetail,
      style: GoogleFonts.workSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
    );
  }

  Row containerTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          widget.tasktitle,
          style: GoogleFonts.workSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: ProjectColorsUtitilty().taskTitle,
          ),
        ),
        Text(
          widget.taskImportantLevel,
          style: GoogleFonts.workSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: ProjectColorsUtitilty().taskImportantText,
          ),
        ),
      ],
    );
  }

  Padding leadingWidget() {
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

  IconButton appBarIconNotification() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.bell,
        color: Colors.black,
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
}

class BottomNagivationBar extends StatelessWidget {
  const BottomNagivationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(105),
      child: Card(
          color: ProjectColorsUtitilty().backgroundPage,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          margin: const EdgeInsets.all(19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.home_rounded,
                    color: Color.fromARGB(255, 162, 158, 182),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bolt_horizontal_circle_fill,
                    color: Color.fromARGB(255, 162, 158, 182),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Color.fromARGB(255, 162, 158, 182),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.settings,
                    color: Color.fromARGB(255, 162, 158, 182),
                  )),
            ],
          )),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.taskType,
    required this.taskTotal,
  }) : super(key: key);

  final String taskType;
  final int taskTotal;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0, right: 10),
      title: Text(
        taskType,
        style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
      subtitle: Text(
        "$taskTotal Görev Yapılmayı Bekliyor",
        style: GoogleFonts.workSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      trailing: SizedBox(
        width: context.dynamicWidth(100),
        height: context.dynamicHeight(37),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune_rounded,
                  color: Colors.black,
                )),
            VerticalDivider(
              indent: 0.5,
              width: 0,
              color: ProjectColorsUtitilty().buttonSide,
              thickness: 1,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    this.dateTime,
    required this.userName,
  }) : super(key: key);

  final String? dateTime;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title1(),
        userNameText(),
      ],
    );
  }

  Text userNameText() {
    return Text(
      userName,
      style: GoogleFonts.workSans(
        color: ProjectColorsUtitilty().appBarText2,
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text title1() {
    return Text(
      dateTime!,
      style: GoogleFonts.workSans(
        color: ProjectColorsUtitilty().appBarText1,
        fontSize: 12,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
