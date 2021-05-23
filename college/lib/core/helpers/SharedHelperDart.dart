import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final String committee1 = "c1";
  final String  committee2= "c2";
  final String committee3 = 'c3';


  //Method to save User model in json format
  Future<bool> setCommitee1DataModel(String c1) async {
    final SharedPreferences preferences1 = await SharedPreferences.getInstance();
    bool res = await preferences1.setString(committee1, c1);
    print(c1);
    return res;
  }

  //Method to retrive User model in json format
  Future<String> getCommitee1DataModel() async {
    final SharedPreferences preferences1 = await SharedPreferences
        .getInstance();
    String res = preferences1.getString(committee1) ?? 'N.A';
    print('Retrived ' + res.toString());
    return res;
  }

    Future<bool> setCommitee2DataModel(String c2) async {
      final SharedPreferences preferences2 = await SharedPreferences.getInstance();
      bool res = await preferences2.setString(committee2, c2);
      print(c2);
      return res;
    }

    //Method to retrive User model in json format
    Future<String> getCommitee2DataModel() async {
      final SharedPreferences preferences2 = await SharedPreferences.getInstance();
      String res = preferences2.getString(committee2) ?? 'N.A';
      print('Retrived ' + res.toString());
      return res;
  }

  Future<bool> setCommitee3DataModel(String c3) async {
    final SharedPreferences preferences3 = await SharedPreferences.getInstance();
    bool res = await preferences3.setString(committee3, c3);
    print(c3);
    return res;
  }

  //Method to retrive User model in json format
  Future<String> getCommitee3DataModel() async {
    final SharedPreferences preferences3 = await SharedPreferences.getInstance();
    String res = preferences3.getString(committee3) ?? 'N.A';
    print('Retrived ' + res.toString());
    return res;
  }

}
