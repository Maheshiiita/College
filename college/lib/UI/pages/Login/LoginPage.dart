import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:ourESchool/UI/pages/Dashboard/AdminDashboard.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/imports.dart';
import 'dart:ui' as ui;

class LoginPage extends StatefulWidget {
  static const id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String idHint = string.student_id;
  UserType loginTypeSelected = WelcomeScreen.loginType;
  bool isRegistered = false;
  String notYetRegisteringText = string.not_registered;
  ButtonType buttonType = ButtonType.LOGIN;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  // MainPageModel mainPageModel;

  loginRegisterBtnTap(LoginPageModel model, BuildContext context) async {

    if (emailController.text == null ||
        passwordController.text == null ||
        schoolNameController.text == null) {
      _scaffoldKey.currentState
          .showSnackBar(ksnackBar(context, 'Please enter details properly'));
    } else {
      if (emailController.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty ||
          schoolNameController.text.trim().isEmpty) {
        _scaffoldKey.currentState
            .showSnackBar(ksnackBar(context, 'Please enter details properly'));
      } else {

        bool response = await model.checkUserDetails(
          name: nameController.text,
          rollNo: rollNoController.text,
          semester: semesterController.text,
          course: courseController.text,
          branch: branchController.text,
          batch: batchController.text,
          email: emailController.text,
          password: passwordController.text,
          schoolCode: schoolNameController.text,
          userType: loginTypeSelected,
          buttonType: buttonType,
          confirmPassword: confirmPasswordController.text,
        );


        if (response==true) {
          if (locator<AuthenticationServices>().userType == UserType.PARENT) {
            Navigator.pushNamedAndRemoveUntil(
                context,ProfilePage.id , (r) => false);
          } else if(locator<AuthenticationServices>().userType == UserType.STUDENT){
            Navigator.pushNamedAndRemoveUntil(
                context, ProfilePage.id, (r) => false);
          }else if(locator<AuthenticationServices>().userType==UserType.TEACHER){
            Navigator.pushNamedAndRemoveUntil(
                context,ProfilePage.id, (r) => false);
          }
        } else {
          print("nn");
          _scaffoldKey.currentState
              .showSnackBar(ksnackBar(context, model.currentLoggingStatus));
        }

      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<LoginPageModel>(
      onModelReady: (model) => model,
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: TopBar(
            title: string.login,
            child: kBackBtn,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          floatingActionButton: LoginRoundedButton(
            label:
            buttonType == ButtonType.LOGIN ? string.login : string.register,
            onPressed: () async {
              if (model.state == ViewState.Idle)
                await loginRegisterBtnTap(model, context);
            },
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            onChanged: (id) {},
                            controller: schoolNameController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "College Code",
                              labelText: "College Code",
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          // CustomLoginTypeBtn(),
                          CustomRadioButton(
                            // horizontal: true,
                            buttonColor: Theme.of(context).canvasColor,
                            buttonLables: ['Student', 'Admin', 'Director'],
                            buttonValues: [UserType.STUDENT, UserType.PARENT, UserType.TEACHER],
                            radioButtonValue: (value) {
                              loginTypeSelected = value;
                              print(value);
                            },
                            selectedColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          TextField(
                            onChanged: (email) {},
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: string.email_hint,
                              labelText: string.email,
                            ),
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          TextField(
                            obscureText: true,
                            onChanged: (password) {},
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: string.password_hint,
                              labelText: string.password,
                            ),
                            controller: passwordController,
                          ),
                          isRegistered
                              ? SizedBox(
                            height: 10,
                          )
                              : Container(),
                          isRegistered
                              ? loginTypeSelected==UserType.STUDENT
                               ? Column(
                                children:[
                                  TextField(
                                    obscureText: true,
                                    onChanged: (password) {},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: string.password_hint,
                                      labelText: string.confirm_password,
                                    ),
                                    controller: confirmPasswordController,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextField(

                                    onChanged: (name){},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Yes Your Name",
                                      labelText: "Name",
                                    ),
                                    controller: nameController,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextField(

                                    onChanged: (RollNo) {},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: "College gave you one ",
                                      labelText: "Enrollment No/ ID",
                                    ),
                                    controller: rollNoController,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextField(

                                    onChanged: (semester) {},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Semester No/ N.A-If Other ",
                                      labelText: "Semester",
                                    ),
                                    controller: semesterController,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextField(
                                    onChanged: (course) {},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Btech-Mtech-PHD/N.A-Faculty",
                                      labelText: "Course",
                                    ),
                                    controller: courseController,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextField(

                                    onChanged: (branch) {},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Branch-IT-ECE",
                                      labelText: "Branch",
                                    ),
                                    controller: branchController,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextField(
                                    onChanged: (batch) {},
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Batch-2019-2018 etc",
                                      labelText: "Batch Year",
                                    ),
                                    controller: batchController,
                                  ),
                                ]
                              )
                          : loginTypeSelected==UserType.TEACHER
                          ? Column(
                              children:[
                                TextField(
                                  obscureText: true,
                                  onChanged: (password) {},
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: string.password_hint,
                                    labelText: string.confirm_password,
                                  ),
                                  controller: confirmPasswordController,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextField(

                                  onChanged: (name){},
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: "Yes Your Name",
                                    labelText: "Name",
                                  ),
                                  controller: nameController,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextField(

                                  onChanged: (RollNo) {},
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: "College gave you one ",
                                    labelText: "Enrollment No/ ID",
                                  ),
                                  controller: rollNoController,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                          )
                          : Column(
                            children:[
                              TextField(
                                obscureText: true,
                                onChanged: (password) {},
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: string.password_hint,
                                  labelText: string.confirm_password,
                                ),
                                controller: confirmPasswordController,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              TextField(

                                onChanged: (name){},
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: "Yes Your Name",
                                  labelText: "Name",
                                ),
                                controller: nameController,
                              ),
                            ],
                          )
                          : Container(),


                          SizedBox(
                            height: 10,
                          ),
                          Hero(
                            tag: 'otpForget',
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ReusableRoundedButton(
                                    child: Text(
                                      notYetRegisteringText,
                                      style: TextStyle(
                                        // color: kmainColorTeacher,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      // _scaffoldKey.currentState.showSnackBar(
                                      //     ksnackBar(context, 'message'));
                                      setState(() {
                                        if (buttonType == ButtonType.LOGIN) {
                                          buttonType = ButtonType.REGISTER;
                                        } else {
                                          buttonType = ButtonType.LOGIN;
                                        }
                                        isRegistered = !isRegistered;
                                        notYetRegisteringText = isRegistered
                                            ? string.regidtered
                                            : string.not_registered;
                                      });
                                    },
                                    height: 40,
                                  ),
                                  ReusableRoundedButton(
                                    child: Text(
                                      string.need_help,
                                      style: TextStyle(
                                        // color: kmainColorTeacher,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      //Forget Password Logic
                                      kopenPage(context, ForgotPasswordPage());
                                    },
                                    height: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              model.state == ViewState.Busy
                  ? Container(
                // color: Colors.red,
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: kBuzyPage(color: Theme.of(context).primaryColor),
                ),
              )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

/*  void createUser() async {
    dynamic result = await _auth.emailPasswordRegister(emailController.text, passwordController.text,loginTypeSelected,schoolNameController.text
      );
    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      nameController.clear();
      rollNoController.clear();
      semesterController.clear();
      courseController.clear();
      courseController.clear();
      branchController.clear();
      batchController.clear();
      Navigator.pop(context);
    }
} */
}