import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Widgets/plugins/launch_pdf.dart';
// import 'package:flutter_widgets/screen_args.dart';
// import '../router.dart' as router;

final Color cyan = Colors.cyan;
final Color blue = Colors.blue;

String file = "AcademicCalendar/AcademicCalendar.pdf";
String fileName = "Flutter Slides";

class LoadFirbaseStoragePdf extends StatefulWidget {
  final String recipeName;
  final String pageName;
  final String codeFilePath;
  final String codeGithubPath;

  const LoadFirbaseStoragePdf(
      {this.recipeName, this.pageName, this.codeFilePath, this.codeGithubPath});

  @override
  _LoadFirbaseStoragePdfState createState() => _LoadFirbaseStoragePdfState();
}

class _LoadFirbaseStoragePdfState extends State<LoadFirbaseStoragePdf> {
  static String pathPDF = "";
  static String pdfUrl = "";

  @override
  void initState() {
    super.initState();

    //Fetch file from FirebaseStorage first
    LaunchFile.loadFromFirebase(context, file)
    //Creating PDF file at disk for ios and android & assigning pdf url for web
        .then((url) => LaunchFile.createFileFromPdfUrl(url).then(
          (f) => setState(
            () {
          if (f is File) {
            pathPDF = f.path;
            print("mil gayaaaaaaaa");
            print(url);
            print(pathPDF);   ///////
          } else if (url is Uri) {
            pdfUrl = url.toString();
          }
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Academic Calendar',
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        }),
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: InkWell(
                            // child:
                            // Image.asset('assets/images/flutter_slides.jpg'),
                            onTap: () => LaunchFile.launchPDF(
                                context, "Academic Calendar", pathPDF, pdfUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                openPDFButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget openPDFButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cyan, blue],
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  LaunchFile.launchPDF(
                      context, "Academic Calendar", pathPDF, pdfUrl);
                });
              },
              child: Text(
                "Open PDF",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}