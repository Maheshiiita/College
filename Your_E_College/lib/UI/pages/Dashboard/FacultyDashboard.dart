
import 'package:ourESchool/UI/pages/AllStudents/AllStudents.dart';
import 'package:ourESchool/UI/pages/AllFaculties/AllFaculties.dart';
import 'package:ourESchool/UI/pages/Dashboard/AcademicCalendar/AcademicCalendar.dart';
import 'package:ourESchool/UI/pages/Dashboard/Attendance/MarkAttendance.dart';
import 'package:ourESchool/UI/pages/Dashboard/CommitteeFormation/AdminViewCommittee.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/AdminCoursesRegistration.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/DirectorViewCourseRegistration.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/StudentCourseRegistration.dart';

import 'package:ourESchool/UI/pages/Dashboard/Subjects/Subjects.dart';
import 'package:ourESchool/UI/pages/Students/Students.dart';
import 'package:ourESchool/UI/pages/Students/TotalStudents.dart';
import 'package:ourESchool/core/helpers/FirebaseAnalytics.dart';
import 'package:ourESchool/imports.dart';

class MainDashboard extends StatefulWidget with AnalyticsScreen {
  static const id = 'MainDashboard';
  MainDashboard({Key key}) : super(key: key) {
    // setCurrentScreen();
  }
  static String pageName = string.dashboard;

  _MainDashboardState createState() => _MainDashboardState();

  @override
  String get screenName => 'ParentAndTeacher Dashboard';
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    ColumnReusableCardButton(
                      directionIconHeroTag: "Students",
                      height: 50,
                      tileColor: Colors.deepPurpleAccent,
                      label:  "Students",
                      icon: FontAwesomeIcons.child,
                      onPressed: () {
                        kopenPage(context, ChildrensPage());
                      },
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.deepOrangeAccent,
                            label: string.e_card,
                            onPressed: () {
                              kopenPage(context, ECardPage());
                            },
                            icon: Icons.perm_contact_calendar,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RowReusableCardButton(
                            tileColor: null,
                            icon: Icons.av_timer,
                            label: string.timetable,
                            onPressed: () {
                              kopenPage(context, TimeTablePage());
                            },
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      directionIconHeroTag: string.announcement,
                      height: 50,
                      tileColor: Colors.orangeAccent,
                      label: string.announcement,
                      icon: CustomIcons.megaphone,
                      onPressed: () {
                        kopenPage(context, AnnouncementPage());
                      },
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.blueGrey,
                            icon: CustomIcons.search,
                            label: string.holidays,
                            onPressed: () {
                              kopenPage(context, HolidayPage());
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RowReusableCardButton(
                            tileColor: Colors.lightGreen,
                            label: string.assignment,
                            onPressed: () {
                              kopenPage(context, AssignmentsPage());
                            },
                            icon: Icons.assignment,
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      height: 50,
                      tileColor: Colors.grey,
                      label: string.transportation,
                      onPressed: () {
                        kopenPage(context, TransportationPage());
                      },
                      icon: FontAwesomeIcons.bus,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowReusableCardButton(
                                tileColor: Colors.deepPurple,
                                icon: FontAwesomeIcons.female,
                                label: string.parenting_guide,
                                onPressed: () {
                                  kopenPage(context, ParentingGuidePage());
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RowReusableCardButton(
                                tileColor: Colors.blue,
                                icon: Icons.web_sharp,
                                label: "Course Reg.",
                                onPressed: () {
                                  kopenPage(context,AdminCourseRegistration());
                                },
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowReusableCardButton(
                                tileColor: Colors.indigo,
                                icon: FontAwesomeIcons.markdown,
                                label:"Mark Upload",
                                onPressed: () {
                                  kopenPage(context, StudentScreen());
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RowReusableCardButton(
                                    tileColor: Colors.teal,
                                    icon: FontAwesomeIcons.peopleArrows,
                                    label:"Committees",
                                    onPressed: () {
                                        kopenPage(context, AdminViewCommittee());
                                    },
                                  ) ,
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
                    ColumnReusableCardButton(
                      height: 60,
                      tileColor: Colors.grey,
                      label: "Academic Calender",
                      onPressed: () {
                        kopenPage(context, LoadFirbaseStoragePdf());
                      },
                      icon: FontAwesomeIcons.calendar,
                    ),

                    SizedBox(
                      height: 80,
                      child: ListView(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowReusableCardButton(
                                tileColor: Colors.redAccent,
                                icon: FontAwesomeIcons.child,
                                label:"All Students",
                                onPressed: () {
                                  kopenPage(context, DashboardScreen());
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RowReusableCardButton(
                                    tileColor: Colors.green,
                                    icon: FontAwesomeIcons.male,
                                    label:"All faculties",
                                    onPressed: () {
                                      kopenPage(context, DashboardScreenF());
                                    },
                                  ) ,
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
    ],
          ),
    ),
    ),
    );
  }
}
