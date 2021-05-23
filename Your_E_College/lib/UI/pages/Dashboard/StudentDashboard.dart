import 'package:ourESchool/UI/pages/AllStudents/AllStudents.dart';
import 'package:ourESchool/UI/pages/Dashboard/AcademicCalendar/AcademicCalendar.dart';
import 'package:ourESchool/UI/pages/Dashboard/CommitteeFormation/StudentViewCommittee.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/CRPage.dart';
import 'package:ourESchool/UI/pages/Dashboard/Result/ViewResultPage.dart';
import 'package:ourESchool/UI/pages/Dashboard/TimeTable/StudentsTimeTable.dart';
import 'package:ourESchool/UI/pages/Students/Students.dart';
import 'package:ourESchool/imports.dart';

class StudentDashboard extends StatefulWidget with AnalyticsScreen {
  static const id = 'StudentDashboard';
  StudentDashboard({Key key}) : super(key: key) {
    // setCurrentScreen();
  }
  static String pageName = string.dashboard;

  _StudentDashboardState createState() => _StudentDashboardState();

  @override
  String get screenName => 'Students Dashboard';
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RowReusableCardButton(
                              tileColor: Colors.deepPurple,
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
                                kopenPage(context,StudentsTimeTable());
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ColumnReusableCardButton(
                        height: 70,
                        tileColor: Colors.deepPurple,
                        label: string.announcement,
                        icon: CustomIcons.megaphone,
                        onPressed: () {
                          kopenPage(context, AnnouncementPage());
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 80,
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
                              tileColor: Colors.indigoAccent,
                              icon: Icons.assessment,
                              label: string.results,
                              onPressed: () {
                                kopenPage(context, ViewResultPage());
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RowReusableCardButton(
                              tileColor: Colors.lightGreen,
                              label: string.assignment,
                              onPressed: () {
                                kopenPage(context, AssignmentsPage());
                              },
                              icon: Icons.assignment,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RowReusableCardButton(
                              tileColor: Colors.lime,
                              icon: Icons.attach_money,
                              label: string.fees,
                              onPressed: () {
                                kopenPage(context, FeesPage());
                              },
                            ),
                          ],
                        ),
                      ),
                      ColumnReusableCardButton(
                          height: 70,
                          tileColor: Colors.grey,
                          label: string.transportation,
                          onPressed: () {
                            kopenPage(context, TransportationPage());
                          },
                          icon: FontAwesomeIcons.bus),
                      SizedBox(
                        height: 80,
                        child: ListView(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RowReusableCardButton(
                                  tileColor: Colors.pink,
                                  icon: Icons.assistant_photo,
                                  label: "Puzzles",
                                  onPressed: () {
                                    kopenPage(context, TopicSelectPage());
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                RowReusableCardButton(
                                  tileColor: Colors.tealAccent,
                                  icon: FontAwesomeIcons.book,
                                  label: string.e_book,
                                  onPressed: () {
                                    kopenPage(context, EBookSelect());
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
                                  tileColor: Colors.deepPurple,
                                  icon: FontAwesomeIcons.female,
                                  label: string.parenting_guide,
                                  onPressed: () {
                                    kopenPage(context, ParentingGuidePage());
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RowReusableCardButton(
                                  tileColor: Colors.blueAccent,
                                  icon: FontAwesomeIcons.facebookMessenger,
                                  label: "Committees",
                                  onPressed: () {
                                    kopenPage(context, StudentViewCommittee());
                                  },
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
                          icon: FontAwesomeIcons.calendar),
                      SizedBox(
                        height: 3,
                      ),
                        ColumnReusableCardButton(
                         height: 60,
                          tileColor: Colors.teal,
                         label: "Course Registration",
                         onPressed: () {
                            kopenPage(context, CRPage());
                         },
                icon: FontAwesomeIcons.book),
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
