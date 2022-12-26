import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

import '../../components/valid.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;
  bool obs = false;

  void showDialogExit() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Warning!",
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            "Are you sure you want to exit this app?",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("Cancel"),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.grey),
              onPressed: () {
                exit(0);
              },
            )
          ],
        );
      },
    );
  }

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });

      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            btnOkOnPress: () {},
            title: "Attention",
            body: const Text(
              "The Email or Password is incorrect",
              style: TextStyle(color: Color.fromARGB(255, 245, 3, 3)),
            )).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: const Text(
            'Hasan`s Notes',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                showDialogExit();
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Image.asset(
                            "images/feather11.png",
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFormSign(
                            maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              valid: (val) {
                                return validInput(val!, 11, 40);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    email.clear();
                                  },
                                  icon: const Icon(Icons.close)),
                              icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.email)),
                              mycontroller: email,
                              //height: 70,
                              hint: "Email"),
                          CustomTextFormSign(
                            maxLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !obs,
                              icon2: IconButton(
                                  onPressed: () {
                                    password.clear();
                                  },
                                  icon: const Icon(Icons.close)),
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obs = !obs;
                                    });
                                  },
                                  icon: Icon(obs == true
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              valid: (val) {
                                return validInput(val!, 5, 15);
                              },
                              mycontroller: password,
                              //height: 40,
                              hint: "Password"),
                          MaterialButton(
                            color: Colors.white30,
                            textColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            onPressed: () async {
                              await login();
                            },
                            child: const Text("Login"),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            child: const Text(
                              "Don't have an account ? Click for signup",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                          ),
                          const SizedBox(
                            height: 200,
                          ),
                          _wavy(),
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }

  Widget _wavy() {
    return DefaultTextStyle(
      style: const TextStyle(
        //backgroundColor: Colors.grey,
        color: Colors.grey,
        fontSize: 20.0,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText("HASAN ALHAYEK",
              speed: const Duration(milliseconds: 200)),
          WavyAnimatedText('Karamanoğlu Mehmetbey University',
              speed: const Duration(milliseconds: 200)),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }
}
