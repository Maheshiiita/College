import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/CheckBoxModel.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/ChipListChoice.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/brand.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/category.dart';

class AdminCourseRegistration extends StatefulWidget {
  AdminCourseRegistration({Key key}) : super(key: key);

  _AdminCourseRegistration createState() => _AdminCourseRegistration();
}


enum Page { dashboard, manage }
enum Start { True, False }
bool pressAttention = true;
bool pressAttention2 = true;


class _AdminCourseRegistration extends State<AdminCourseRegistration>
    with SingleTickerProviderStateMixin {

  Page _selectedPage = Page.dashboard;
  Start _selected = Start.False;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController instructorController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();

  }

  updates (bool x) async {
    await DatabaseManager().updateR(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            Text( 'BTech ', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            FlatButton(onPressed:  () {
              setState(() => pressAttention = !pressAttention);
              setState(() => _selected =Start.True);
              updates(true);
            } ,

                color: pressAttention ? Colors.grey : Colors.blue,
                child: Row(
                  children: [
                    Icon(Icons.bookmark_outlined,  size: 30.0,
                      color: Colors.green,),
                    Text('Start',  style: TextStyle(fontSize: 20.0, color: Colors.green)),
                  ],
                )
            ),
            FlatButton(onPressed:  () {
              setState(() => pressAttention2 = !pressAttention2);
              setState(() => _selected =Start.False);
              updates(false);
            } ,
                color: pressAttention2 ? Colors.grey : Colors.blue,
                child: Row(
                  children: [
                    Icon(Icons.bookmark_outlined,  size: 30.0,
                      color: Colors.red,),
                    Text('End',  style: TextStyle(fontSize: 20.0, color: Colors.red)),
                  ],
                )
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[

                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Subject"),
              onTap: () {
                _ProductAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Subject list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add Branch"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Branch list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add Course"),
              onTap: () {
                _brandAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("Course list"),
              onTap: () {},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value){
            if(value.isEmpty){
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(
              hintText: "add branch"
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if(categoryController.text != null){
            _categoryService.createCategory(categoryController.text);
          }
          Toast.show('branch created', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          Navigator.pop(context);
        }, child: Text('ADD')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value){
            if(value.isEmpty){
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(
              hintText: "add course"
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if(brandController.text != null){
            _brandService.createBrand(brandController.text);
          }
          Toast.show('course added', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          Navigator.pop(context);
        }, child: Text('ADD')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
  void _ProductAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: brandController,
              validator: (value){
                if(value.isEmpty){
                  return 'category cannot be empty';
                }
              },
              decoration: InputDecoration(
                  hintText: "add Subject"
              ),
            ),
            TextFormField(
              controller:idController,
              validator: (value){
                if(value.isEmpty){
                  return 'category cannot be empty';
                }
              },
              decoration: InputDecoration(
                  hintText: "ID"
              ),
            ),
            TextFormField(
              controller: instructorController,
              validator: (value){
                if(value.isEmpty){
                  return 'category cannot be empty';
                }
              },
              decoration: InputDecoration(
                  hintText: "Instructor"
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if(brandController.text != null){
            _brandService.createBrand(brandController.text);
          }
          Toast.show('Subject added', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          Navigator.pop(context);
        }, child: Text('ADD')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }


}