import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import 'package:http/http.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  bool obs = false;

  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });

      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        if (kDebugMode) {
          print("Signing up failed");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/feather11.png",
                            width: 200,
                            height: 200,
                          ),
                          CustomTextFormSign(
                              maxLines: 1,
                            keyboardType: TextInputType.multiline,
                              obscureText: false,
                              icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person)),
                              valid: (val) {
                                return validInput(val!, 5, 25);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    username.clear();
                                  },
                                  icon: const Icon(Icons.close)),
                              mycontroller: username,
                              //height: 40,
                              hint: "username"),
                          CustomTextFormSign(
                              maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.email)),
                              valid: (val) {
                                return validInput(val!, 11, 40);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    email.clear();
                                  },
                                  icon: const Icon(Icons.close)),
                              mycontroller: email,
                              //height: 40,
                              hint: "email"),
                          CustomTextFormSign(
                            maxLines: 1,
                            obscureText: !obs,
                              keyboardType: TextInputType.visiblePassword,
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obs = !obs;
                                    });
                                  },
                                  icon: Icon( obs == true ? Icons.visibility : Icons.visibility_off)),
                              valid: (val) {
                                return validInput(val!, 5, 15);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    password.clear();
                                  },
                                  icon: const Icon(Icons.close)),
                              mycontroller: password,
                              //height: 40,
                              hint: "password"),
                          MaterialButton(
                            color: Colors.white30,
                            textColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            onPressed: () async {
                              await signUp();
                            },
                            child: const Text("SignUp"),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            child: const Text(
                              "have an account ?, Login",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("login");
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
