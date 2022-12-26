import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/customtextformshow.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>(); // for validator
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  AddNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id")
      });
      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {
        //success//
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  // Empty note alert dialog function
  void _showDialog() {
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
            "Empty note cannot be added.",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.grey),
              child: const Text(
                "Ok",
              ),
              //color: Color.fromARGB(255, 209, 211, 212),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white24,
        title: const Text(
          "Add New Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formstate,
              child: ListView(children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: CustomTextFormSign(
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    hint: "title",
                    //height: 50,
                    mycontroller: title,
                    valid: (val) {
                      return validInput(val!, 0, 50);
                    },
                    icon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.text_fields)),
                    icon2: IconButton(
                        onPressed: () {
                          title.clear();
                        },
                        icon: const Icon(Icons.close)),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextFormShow(
                        maxLines: 15,
                        hint: "content",
                        mycontroller: content,
                        valid: (val) {})),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: MaterialButton(
                    onPressed: () async {
                      if (title.text.isEmpty && content.text.isEmpty) {
                        _showDialog();
                      }
                      else if(title.text.isNotEmpty && content.text.isNotEmpty){
                        await AddNotes();
                        title.text = "";
                        content.text = "";
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                      else if(title.text.isEmpty && content.text.isNotEmpty){
                        title.text = "No Title";
                        await AddNotes();
                        //print(content.text);
                        title.text = "";
                        content.text = "";
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                      else if(title.text.isNotEmpty && content.text.isEmpty){
                        content.text = "No Note Here";
                        await AddNotes();
                        //print(content.text);
                        title.text = "";
                        content.text = "";
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.black,
                    color: Colors.white24,
                  ),

                ),
                const SizedBox(height: 30,),
              ]),
            ),
    );
  }
}
