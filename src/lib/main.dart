import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/coursesPage/courses_page.dart';
import 'package:src/pages/detailATeacherPage/detail-a-teacher_page.dart';
import 'package:src/pages/detailCoursePage/detail-course_page.dart';
import 'package:src/pages/detailLessonPage/detail-lesson_page.dart';
import 'package:src/pages/forgotPasswordPage/forgot-password_page.dart';
import 'package:src/pages/historyPage/history_page.dart';
import 'package:src/pages/listTeacherPage/list-teacher_page.dart';
import 'package:src/pages/loginPage/login_page.dart';
import 'package:src/pages/schedulePage/schedule_page.dart';
import 'package:src/pages/signUpPage/sign-up_page.dart';
import 'package:src/pages/videoCallPage/videoCallPage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:src/providers/UserProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return userProvider.isLoggedIn ? BottomNavBar() : LoginPage();
          },
        ),
        routes: {
          '/bottomNavBar': (context) => BottomNavBar(),
          '/loginPage': (context) => LoginPage(),
          '/signUpPage': (context) => SignUpPage(),
          '/forgotPasswordPage': (context) => ForgotPasswordPage(),
          '/listTeacherPage': (context) => ListTeacherPage(),
          '/detailATeacher': (context) => DetailATeacherPage(),
          '/schedulePage': (context) => SchedulePage(),
          '/historyPage': (context) => HistoryPage(),
          '/coursesPage': (context) => CoursesPage(),
          '/detailCoursePage': (context) => DetailCoursePage(),
          '/detailLessonPage': (context) => DetailLessonPage(),
          '/videoCallPage': (context) => VideoCallPage(),
        },
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color.fromRGBO(0, 113, 240, 1.0)),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    if (!userProvider.isLoggedIn) {
      return const LoginPage();
    }
    List<Widget> _buildScreens() {
      return [ListTeacherPage(), SchedulePage(), CoursesPage(), HistoryPage()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: Icon(Icons.home),
            title: ("Home"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
              },
            )),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            title: ("Schedule"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
              },
            )),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.school),
            title: ("Course"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
              },
            )),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.history),
            title: ("History"),
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: "/",
              routes: {
                '/listTeacherPage': (context) => ListTeacherPage(),
                '/detailATeacher': (context) => DetailATeacherPage(),
                '/schedulePage': (context) => SchedulePage(),
                '/historyPage': (context) => HistoryPage(),
                '/coursesPage': (context) => CoursesPage(),
                '/detailCoursePage': (context) => DetailCoursePage(),
                '/detailLessonPage': (context) => DetailLessonPage(),
                '/videoCallPage': (context) => VideoCallPage(),
              },
            )),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
