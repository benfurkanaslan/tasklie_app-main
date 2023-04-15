import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasklie_new/components/extension.dart';
import 'package:tasklie_new/pages/calendar.dart';
import 'package:tasklie_new/pages/profile.dart';
import 'package:tasklie_new/pages/project_detail.dart';
import 'package:tasklie_new/pages/tasks_view.dart';
import 'package:tasklie_new/project_details/project_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

PageController _pageController = PageController();

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const BottomNagivationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _pageController,
        children: [
          Profile(),
          TaskViewPage(),
          const ProjectDetail(),
          const Calendar(),
        ],
      ),
    );
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
              onPressed: () {
                _pageController.jumpToPage(0);
              },
              icon: const Icon(
                CupertinoIcons.home,
                color: Color.fromARGB(255, 162, 158, 182),
              ),
            ),
            IconButton(
              onPressed: () {
                _pageController.jumpToPage(1);
              },
              icon: const Icon(
                CupertinoIcons.profile_circled,
                color: Color.fromARGB(255, 162, 158, 182),
              ),
            ),
            IconButton(
              onPressed: () {
                _pageController.jumpToPage(2);
              },
              icon: const Icon(
                CupertinoIcons.checkmark_alt_circle,
                color: Color.fromARGB(255, 162, 158, 182),
              ),
            ),
            IconButton(
              onPressed: () {
                _pageController.jumpToPage(3);
              },
              icon: const Icon(
                CupertinoIcons.calendar,
                size: 22,
                color: Color.fromARGB(255, 162, 158, 182),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
