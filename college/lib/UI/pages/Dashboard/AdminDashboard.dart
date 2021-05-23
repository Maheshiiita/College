import 'package:ourESchool/UI/pages/AllFaculties/AllFaculties.dart';
import 'package:ourESchool/UI/pages/AllStudents/AllStudents.dart';
import 'package:ourESchool/UI/pages/Dashboard/Attendance/MarkAttendance.dart';
import 'package:ourESchool/UI/pages/Dashboard/CommitteeFormation/AdminViewCommittee.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/AdminCoursesRegistration.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/DirectorViewCourseRegistration.dart';
import 'package:ourESchool/UI/pages/Dashboard/Subjects/Subjects.dart';
import 'package:ourESchool/UI/pages/Dashboard/TimeTable/TeachersTimeTable.dart';
import 'package:ourESchool/UI/pages/Students/TotalStudents.dart';
import 'package:ourESchool/core/helpers/FirebaseAnalytics.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/imports.dart';

class AdminDashboard extends StatefulWidget with AnalyticsScreen {
  static const id = 'AdminDashboard';
  AdminDashboard({Key key}) : super(key: key) {
    // setCurrentScreen();
  }
  static String pageName = 'DirectorDashboard';

  _AdminDashboardState createState() => _AdminDashboardState();

  @override
  String get screenName => 'AdminDashboard';
}

class _AdminDashboardState extends State<AdminDashboard> {


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
                      label:  "All Students",
                      icon: FontAwesomeIcons.child,
                      onPressed: () {
                        kopenPage(context, DashboardScreen());
                      },
                    ),
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.deepOrangeAccent,
                            label: "All faculties",
                            onPressed: () {
                              kopenPage(context, DashboardScreenF());
                            },
                            icon: Icons.perm_contact_calendar,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RowReusableCardButton(
                            tileColor: null,
                            icon: Icons.access_time,
                            label: string.timetable,
                            onPressed: () {
                              kopenPage(context, TeachersTimeTable());
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
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.blueGrey,
                            icon: CustomIcons.traveler_with_a_suitcase,
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
                            label: 'Regis. Students',
                            onPressed: () {
                              kopenPage(context, DirectorStart());
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
                      height: 100,
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
                                label: "Committees",
                                onPressed: () {
                                  kopenPage(context, AdminViewCommittee());
                                },
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    ColumnReusableCardButton(
                      height: 50,
                      tileColor: Colors.grey,
                      label: "Student 1-1",
                      onPressed: () {
                        kopenPage(context, ChildrensPage());
                      },
                      icon: FontAwesomeIcons.child,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    ColumnReusableCardButton(
                      height: 50,
                      tileColor: Colors.grey,
                      label: "Student marks",
                      onPressed: () {
                        kopenPage(context, StudentScreen());
                      },
                      icon: FontAwesomeIcons.child,
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
