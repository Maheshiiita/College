import 'package:flutter/foundation.dart';
import 'package:ourESchool/imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';

class AuthenticationServices extends Services {

  bool isUserLoggedIn = false;
  UserType userType = UserType.STUDENT;
  StreamController<User> fireBaseUserStream = StreamController<User>();
  StreamController<bool> isUserLoggedInStream = StreamController<bool>();
  StreamController<UserType> userTypeStream = StreamController<UserType>();

  ProfileServices _profileServices = locator<ProfileServices>();

  AuthenticationServices() : super()
  {
    isLoggedIn().then((onValue) => isUserLoggedIn = onValue);
    _userType().then((onValue) => userType = onValue);
  }

  Future<bool> isLoggedIn() async {
    await getFirebaseUser();
    fireBaseUserStream.add(firebaseUser);
    String name = firebaseUser != null ? firebaseUser.email.toString() : 'Null';
    print('User Email :' + name);
    isUserLoggedIn = firebaseUser == null ? false : true;
    isUserLoggedInStream.add(isUserLoggedIn);
    if (isUserLoggedIn) _profileServices.getLoggedInUserProfileData();
    print(isUserLoggedIn.toString() + 'here');
    return isUserLoggedIn;
  }

  Future<UserType> _userType() async {
    userType = await sharedPreferencesHelper.getUserType();
    userTypeStream.add(userType);
    return userType;
  }




  Future checkDetails({
    @required String name,
    @required String rollNo,
    @required String semester,
    @required String course,
    @required String branch,
    @required String batch,
    @required String schoolCode,
    @required String email,
    @required String password,
    @required UserType userType,
  }) async {
    await sharedPreferencesHelper.clearAllData();
    //Check if the School code is present and return "School not Present" if not
    //Then check if the user credentials are in the database or not
    //if not then return "Student Not Found" else return "Logging in"

    //Api Call to check details
    bool isSchoolPresent = false;
    bool isUserAvailable = false;
    String loginType = userType == UserType.STUDENT
        ? "Student"
        : userType == UserType.TEACHER
            ? "Admin-Faculty"
            : "Admin-Faculty";

    DocumentReference _schoolLoginRef =
        schoolRef.collection(schoolCode.toUpperCase().trim()).doc('Login');

    await _schoolLoginRef.get().then((onValue) {
      isSchoolPresent = onValue.exists;
      print("Inside Then :" + onValue.data.toString());
    });

    if (!isSchoolPresent) {
      print('College Not Found');
      return ReturnType.SCHOOLCODEERROR;
    } else {
      print('College Found');
    }

    CollectionReference _userRef = _schoolLoginRef.collection(loginType);

    await _userRef
        .where("email", isEqualTo: email)
        .snapshots()
        .first
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        isUserAvailable = documentSnapshot.exists;
        print("User Data : " + documentSnapshot.data.toString());
        if (userType == UserType.STUDENT) {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            parentIds:
                documentSnapshot['parentId'] as Map<dynamic, dynamic> ?? null,
          );

        } else {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            isATeacher: documentSnapshot["isATeacher"] as bool,
             childIds:
                 documentSnapshot["childId"] as Map<dynamic, dynamic> ?? null,
          );
        }
      });
    });

    if (!isUserAvailable) {
      print('User Not Found');
      return ReturnType.EMAILERROR;
    } else {
      print('User Found');
      userDataLogin.setData();
    }

    sharedPreferencesHelper.setLoggedInUserId(userDataLogin.id);

    if (userType == UserType.STUDENT) {
      this.userType = userType;
      userTypeStream.add(userType);
      sharedPreferencesHelper.setUserType(UserType.STUDENT);
    } else {
      if (userDataLogin.isATeacher) {
        this.userType = UserType.TEACHER;
        userTypeStream.add(this.userType);
        sharedPreferencesHelper.setUserType(this.userType);
      } else {
        this.userType = UserType.PARENT;
        userTypeStream.add(this.userType);
        sharedPreferencesHelper.setUserType(this.userType);
      }
    }

    print("Childs :" + userDataLogin.childIds.toString());
    print("Email :" + userDataLogin.email);
    print("Id :" + userDataLogin.id);
   // print("isATeacher :" + userDataLogin.isATeacher.toString());

    return ReturnType.SUCCESS;
  }

  Future emailPasswordRegister( String name, String rollNo,  String semester, String course, String branch, String batch, String email, String password, UserType userType,
      String schoolCode) async {
    // await sharedPreferencesHelper.clearAllData();
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = userCredential.user;
      authErrors = AuthErrors.SUCCESS;
      sharedPreferencesHelper.setSchoolCode(schoolCode);
      print("User Regestered using Email and Password");
      await DatabaseManager().createUserData(userType.toString(),name,rollNo,semester,course,branch,batch,firebaseUser.uid);
      // sharedPreferencesHelper.setUserType(userType);
      isUserLoggedIn = true;
      isUserLoggedInStream.add(isUserLoggedIn);
      fireBaseUserStream.add(firebaseUser);
      return authErrors;
    } catch (e) {
      return catchException(e);
    }
  }

  Future<AuthErrors> emailPasswordSignIn(String email, String password,
      UserType userType, String schoolCode) async {
    // await sharedPreferencesHelper.clearAllData();
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = userCredential.user;
      authErrors = AuthErrors.SUCCESS;
      sharedPreferencesHelper.setSchoolCode(schoolCode);
      print("User Loggedin using Email and Password");
      // sharedPreferencesHelper.setUserType(userType);
      isUserLoggedIn = true;
      fireBaseUserStream.sink.add(firebaseUser);
      isUserLoggedInStream.add(isUserLoggedIn);
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }


  logoutMethod() async {
    await auth.signOut();
    isUserLoggedIn = false;
    isUserLoggedInStream.add(false);
    fireBaseUserStream.add(null);
    userTypeStream.add(UserType.UNKNOWN);
    await sharedPreferencesHelper.clearAllData();
    print("User Logged out");
  }

  Future<AuthErrors> passwordReset(String email) async {
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.sendPasswordResetEmail(email: email);
      authErrors = AuthErrors.SUCCESS;
      print("Password Reset Link Send");
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  AuthErrors catchException(Exception e) {
    AuthErrors errorType = AuthErrors.UNKNOWN;
    if (e is PlatformException) {
      if (Platform.isIOS) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = AuthErrors.NetworkError;
            break;
          case 'Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later':
            errorType = AuthErrors.TOOMANYATTEMPTS;
            break;
          // ...
          default:
            print('Case iOS ${e.message} is not yet implemented');
        }
      } else if (Platform.isAndroid) {
        switch (e.code) {
          case 'Error 17011':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'Error 17009':
          case 'ERROR_WRONG_PASSWORD':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case Android ${e.message} ${e.code} is not yet implemented');
        }
      }
    }

    print('The error is $errorType');
    return errorType;
  }
}
