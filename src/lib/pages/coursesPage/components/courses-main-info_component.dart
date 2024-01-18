import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import 'package:src/pages/coursesPage/components/course-card.dart';
import 'package:src/providers/courses_provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../utilities/const.dart';

class CoursesMainInfoComponent extends StatefulWidget {
  const CoursesMainInfoComponent({Key? key}) : super(key: key);

  @override
  State<CoursesMainInfoComponent> createState() =>
      _CoursesMainInfoComponentState();
}

class _CoursesMainInfoComponentState extends State<CoursesMainInfoComponent> {
  List<String> itemsLevel = [];
  List<String> itemsCategory = [];
  List<String> itemsSort = ["Level decreasing", "Level ascending"];

  List<String> selectedLevel = [];
  List<String> selectedCategory = [];
  List<String> selectedSort = [];

  @override
  void initState() {
    // TODO: implement initState

    for (var element in ConstValue.levelList) {
      itemsLevel.add(element);
    }
    for (var element in Specialities.specialities) {
      itemsCategory.add(element.name!);
    }
    for (var element in Specialities.topics) {
      itemsCategory.add(element.name!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final courseProvider = Provider.of<CoursesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchCourse(),
          SizedBox(height: 16),
          _buildSubTitle(),
          SizedBox(height: 16),
          _buildSelect("Select level", itemsLevel, selectedLevel),
          SizedBox(height: 16),
          _buildSelect("Select category", itemsCategory, selectedCategory),
          SizedBox(height: 16),
          _buildSelect("Sort by level", itemsSort, selectedSort),
          SizedBox(height: 16),
           TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black38,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            onTap: (index) {
              if(index == 0) {
                courseProvider.callApiGetCourses(1, null, null, null, null, null, authProvider, (error) => {
                  // show message error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  )
                });

              }
            },
            tabs: [
              Tab(text: 'Course'),
              Tab(text: 'Book'),
              Tab(text: 'Interactive book'),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildSearchCourse() {
    return Container(
      child: Row(
        children: [
          SvgPicture.asset('lib/assets/images/course.svg',
              semanticsLabel: "Course", height: 100),
          SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Discover Courses",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          hintText: 'Courses',
                          isDense: true,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      child: Container(
                        color: Colors.grey.shade100,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_rounded,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    return Container(
      child: const Text(
        'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.',
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 16, color: Colors.black38, height: 1.2),
      ),
    );
  }

  Widget _buildSelect(
      String title, List<String> selects, List<String> selected) {
    return Container(
      height: 42,
      child: DropDownMultiSelect(
        isDense: true,
        onChanged: (List<String> x) {
          setState(() {
            selected = x;
          });
        },
        options: selects,
        selectedValues: selected,
        whenEmpty: title,
      ),
    );
  }
}
