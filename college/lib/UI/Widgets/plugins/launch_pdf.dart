import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/pages/Dashboard/AcademicCalendar/AcademicCalendar.dart';
import 'package:ourESchool/UI/pages/Dashboard/AcademicCalendar/pdfScreen.dart';
import 'package:path_provider/path_provider.dart';
import '../plugins/mobilestorage.dart';

class LaunchFile {
  static void launchPDF(
      BuildContext context, String title, String pdfPath, String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFScreen(title, pdfPath, pdfUrl),
      ),
    );
  }

  static Future<dynamic> loadFromFirebase(
      BuildContext context, String url) async {
    print("mmmmmmmmmmmmmmmmmmmmmmmmmm");
    print(FireStorageService.loadFromStorage(context, file));
    return FireStorageService.loadFromStorage(context, file);
  }

  static Future<dynamic> createFileFromPdfUrl(dynamic url) async {
    final filename =
        'flutterSlides.pdf'; //I did it on purpose to avoid strange naming conflicts
    print(filename);
    var request = await HttpClient().getUrl(Uri.parse(url));
    // print(request);
    var response = await request.close();
    // print(response);
    var bytes = await consolidateHttpClientResponseBytes(response);
    // print(bytes);
    String dir = (await getApplicationDocumentsDirectory()).path;
    // print(dir);
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}