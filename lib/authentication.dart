import 'package:engage_scheduler/auth_pages/forgotPassword.dart';
import 'package:engage_scheduler/auth_pages/signIn.dart';
import 'package:engage_scheduler/auth_pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:engage_scheduler/theme/colors/light_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// page managing sign in sign up and forgot password

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
  }

  GlobalKey<ScaffoldState> _authScaffoldKey = GlobalKey<ScaffoldState>();
  PageController authPageController =
      PageController(keepPage: true, initialPage: 1);

  int page = 1;

  // No Internet Connection SnackBar
  SnackBar networkErrorSnackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off,
          size: 15,
          color: Colors.white,
        ),
        SizedBox(
          width: 4,
        ),
        Text("No internet connection. Try again!")
      ],
    ),
  );

  // Change Page Button Preffixs
  List<String> preffix = [
    "Don't want to reset password? ",
    "Need an account? ",
    "Have an account? ",
  ];

  // Change Page Button Suffixs
  List<String> suffix = [
    "Sign In",
    "SignUp",
    "Sign In",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _authScaffoldKey,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      // Logo Template
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: LightColors.kBlue,
                            radius: 60.0,
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            "Scheduler",
                            style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,

                    // PageView To Display Auth Pages
                    child: PageView(
                      controller: authPageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        if (this.mounted) if (this.mounted)
                          setState(() {
                            page = value;
                          });
                      },
                      children: [
                        // Forgot Password Page
                        ForgotPassword(
                          authPageController: authPageController,
                          authScaffoldKey: _authScaffoldKey,
                          // networkErrorSnackBar: networkErrorSnackBar,
                        ),

                        // SignIn Page
                        SignIn(
                          authPageController: authPageController,
                          authScaffoldKey: _authScaffoldKey,
                          // networkErrorSnackBar: networkErrorSnackBar,
                        ),

                        // SignUp Page
                        SignUp(
                          authScaffoldKey: _authScaffoldKey,
                          // networkErrorSnackBar: networkErrorSnackBar,
                        ),
                      ],
                    ),
                  ),

                  // Change Page Button
                  GestureDetector(
                    onTap: () {
                      if (authPageController.page == 2) {
                        authPageController.previousPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeInOutCirc,
                        );
                      } else {
                        authPageController.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeInOutCirc,
                        );
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        text: preffix[page],
                        style: Theme.of(context).textTheme.headline5,
                        children: <TextSpan>[
                          TextSpan(
                              text: suffix[page],
                              style: Theme.of(context).textTheme.headline4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
