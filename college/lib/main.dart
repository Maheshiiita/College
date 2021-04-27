import 'package:flutter/foundation.dart';
import 'imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  timeDilation = 2;
  await Firebase.initializeApp();
  if (kIsWeb) await FirebaseFirestore.instance.enablePersistence();

  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

    );
  }
}

class OurSchoolApp extends StatelessWidget {
  const OurSchoolApp({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AMSD',
      theme: theme,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Home.id: (context) => Home(),

      }
      home: getHome(context),
    );
  }

  Widget getHome(BuildContext context) {

  }
}
