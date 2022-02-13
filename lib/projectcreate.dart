import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'main.dart' as home;

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        newDueDate = picked;
      });
    }
  }

  toHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => home.Portrt()),
    );
  }
  final fieldNameController = TextEditingController();
  final fieldCommController = TextEditingController();
  final fieldDescController = TextEditingController();
  DateTime newDueDate = DateTime.now();
  final _newKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => home.Portrt()),
                    );
                  }
              ),
              title: const Text("Create A New Project"),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(                                      //Text input for New Project Name
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Project Name',
                      ),
                      controller: fieldNameController,
                    ),
                  ),
                  Padding(                                      //Text input field for Commissioner
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Commissioner',
                      ),
                      controller: fieldCommController,
                    ),
                  ),
                  Padding(                                      //Date due
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.calendar_today_outlined),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                          Text("Select Due Date")
                        ],
                      )
                  ),
                  Padding(                                      //Text input field for Commissioner
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: fieldDescController,
                    ),
                  ),
                ]
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.save_rounded),
              onPressed:() {
                setState(() {           // Adds and returns to Home
                  home.Portrt.projectCount++;
                  home.Portrt.projectList.add(home.ProjectNodes(home.Portrt.projectCount-1, (fieldNameController.text != '') ? fieldNameController.text : "New Project ${home.Portrt.projectCount}", (fieldCommController.text != '') ? fieldCommController.text : "Personal", newDueDate, (fieldDescController.text != '') ? fieldDescController.text : "(No description)"));
                  toHome(context);
                }
                );
              },
            ),
          )
      ),);
  }
}