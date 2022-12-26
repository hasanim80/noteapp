import 'package:flutter/material.dart';
import 'package:noteapp/app/notes/edit.dart';
import 'package:noteapp/components/cardnote.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
//import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    return response;
  }

  bool wantDelete = false;

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
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
              onPressed: () {
                wantDelete = false;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              style: IconButton.styleFrom(),
              onPressed: () {
                showDialogExit();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add_box),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(
                          child: Text(
                        "There are no notes here , Please add a notes to be shown",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                              onDelete: () async {
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
                                        "Are you sure you want to delete this note?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        TextButton(
                                          child: const Text("Cancel"),
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.green),
                                          onPressed: () {
                                            wantDelete = false;
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Yes"),
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.red),
                                          onPressed: () async {
                                            var response = await postRequest(
                                                linkDeleteNotes, {
                                              "id": snapshot.data['data'][i]
                                                      ['notes_id']
                                                  .toString()
                                            });
                                            if (response['status'] ==
                                                "success") {
                                              Navigator.of(context)
                                                  .pushReplacementNamed("home");
                                            }
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                                //showDialogDelete();
                              },
                              ontap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNotes(
                                        notes: snapshot.data['data'][i])));
                              },
                              title:
                                  "${snapshot.data['data'][i]['notes_title']}",
                              // Here Just pass the string because Text wd cannot assign to string
                              content:
                                  "${snapshot.data['data'][i]['notes_content']}");
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading ..."),
                    );
                  }
                  return const Center(
                    child: Text("Loading ..."),
                  );
                })
          ],
        ),
      ),
    );
  }
}
