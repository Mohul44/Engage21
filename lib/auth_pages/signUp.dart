// ignore_for_file: deprecated_member_use

import 'package:auth_demo/authService.dart';
import 'package:auth_demo/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({
    Key key,
    @required this.authScaffoldKey,
    // @required this.networkErrorSnackBar,
  }) : super(key: key);

  GlobalKey<ScaffoldState> authScaffoldKey;
  // final SnackBar networkErrorSnackBar;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();
  final TextEditingController nameTextField = TextEditingController();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  int _value = 1;
  // Run Action When Loading
  bool loading = false;
  // Map For Displaying Erorr Messages
  Map<String, String> errorMessage = {
    "email": "email",
    "password": "password",
    "network": "network",
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _signUpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameTextField,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.name,
              autofocus: true,
              cursorColor: Theme.of(context).accentColor,
              obscureText: false,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(labelText: "Name"),
              validator: (name) {
                if (name.isEmpty) {
                  return "Please enter name";
                }
                return null;
              },
            ),

            TextFormField(
              controller: emailTextField,
              autocorrect: false,
              autofocus: true,
              enableSuggestions: false,
              keyboardType: TextInputType.text,
              cursorColor: Theme.of(context).accentColor,
              obscureText: false,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(labelText: "Email"),
              validator: (email) {
                if (email.isEmpty) {
                  return "Please enter an email adress";
                } else if (errorMessage["email"].isNotEmpty) {
                  return errorMessage["email"];
                }
                return null;
              },
            ),

            TextFormField(
              controller: passwordTextField,
              autocorrect: false,
              autofocus: true,
              enableSuggestions: false,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Theme.of(context).accentColor,
              obscureText: true,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(labelText: "Password"),
              validator: (password) {
                if (password.isEmpty) {
                  return "Please enter a password";
                } else if (errorMessage["password"].isNotEmpty) {
                  return errorMessage["password"];
                }
                return null;
              },
            ),

            TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              autofocus: true,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Theme.of(context).accentColor,
              obscureText: true,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(labelText: "Rewrite Password"),
              validator: (rewritePassword) {
                if (rewritePassword.isEmpty) {
                  return "Please rewrite your password";
                } else if (passwordTextField.text != rewritePassword) {
                  return "Password does not match";
                }
                return null;
              },
            ),
            DropdownButton(
              dropdownColor: LightColors.kBlue,
              value: _value,
              style: new TextStyle(
                color: LightColors.kLavender,
              ),
              items: [
                DropdownMenuItem(
                  child: Text("Student"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Teacher"),
                  value: 2,
                ),
              ],
              onChanged: (int value) {
                setState(() {
                  _value = value;
                });
              },
              hint: Text(
                "Select Role",
                style: TextStyle(color: LightColors.kLavender),
              ),
            ),

            // Sign Up Button
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: loading
                      ? Container(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).scaffoldBackgroundColor),
                          ),
                        )
                      : Text("Sign Up"),
                  onPressed: () async {
                    if (this.mounted)
                      setState(() {
                        errorMessage["email"] = "";
                        errorMessage["network"] = "";
                        errorMessage["password"] = "";
                      });

                    // 1. Check Form Validation
                    // 2. Set State "loading" = true
                    // 3. Call "signUp" Future inside AuthService()
                    // 4. Catch NetworkError - Show SnackBar
                    // 5. Set State "errorMessage" = value
                    // 6. Check Form Validation Again
                    // 7. If Valid => Home
                    if (_signUpFormKey.currentState.validate()) {
                      if (this.mounted)
                        setState(() {
                          loading = true;
                        });
                      print(
                          "heree 0 ${emailTextField.text} ${passwordTextField.text} ${nameTextField.text}");
                      await AuthService()
                          .signUp(emailTextField.text, passwordTextField.text,
                              nameTextField.text, _value)
                          .then((value) {
                        print(
                            "heree 1 ${emailTextField.text} ${passwordTextField.text} ${nameTextField.text}");
                        // if (value["network"].isNotEmpty) {
                        //   widget.authScaffoldKey.currentState
                        //       .showSnackBar(widget.networkErrorSnackBar);
                        //   if (this.mounted)
                        //     setState(() {
                        //       loading = false;
                        //     });
                        // }
                        if (this.mounted)
                          setState(() {
                            print("here2");
                            errorMessage = value;
                            loading = false;
                          });
                      });
                      _signUpFormKey.currentState.validate();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
