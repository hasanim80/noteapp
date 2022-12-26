import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/components/valid.dart';
import '../../components/customtextformshow.dart';
import '../../constant/linkapi.dart';

class EditNotes extends StatefulWidget {
  final notes;

  const EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>(); // for validator
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkEditNotes, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString()
      });
      isLoading = false;
      setState(() {});

      if (response['status'] == "suuccess") {
        ///////suuccess/////
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  // the default values of controller
  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
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
            "The note cannot be empty.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("Ok"),
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 209, 211, 212),
              ),
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
        title:  const Text("Edit This Note",style:  TextStyle(color: Colors.black),),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formstate,
              child: ListView(children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 550,
                  width: double.infinity,
                  //color: Colors.purple,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(1),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Column(
                    children: [
                      CustomTextFormShow(
                        fontWeight: FontWeight.bold,
                          fontSize: 20,
                          hint: "title",
                          maxLines: 1,
                          mycontroller: title,
                          valid: (val) {}),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormShow(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          hint: "content",
                          maxLines: 20,
                          mycontroller: content,
                          valid: (val) {})
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: MaterialButton(
                    onPressed: () async {
                      if (title.text != "" || content.text != "") {
                        await editNotes();
                        title.text = "";
                        content.text = "";
                        Navigator.of(context).pushReplacementNamed("home");
                      } else {
                        _showDialog();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.black,
                    color: Colors.white30,
                  ),
                )
              ]),
            ),
    );
  }
}
