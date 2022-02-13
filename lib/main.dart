/*
 *    Ammar Danish
 */

//import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:path_provider/path_provider.dart';
import 'projectcreate.dart' as projcrt;
import 'projectviewfull.dart' as projview;

void main(){
  runApp(Portrt());
}
//Test Variables
class ProjectNodes extends LinkedListEntry<ProjectNodes>{
  final int projectID;
  final String projectName;
  final String projectCommissioner;
  final String projectDesc;
  final DateTime dueDate;

  ProjectNodes(this.projectID, this.projectName, this.projectCommissioner, this.dueDate, this.projectDesc);
}

//Home Route
class Portrt extends StatefulWidget {
  const Portrt({Key? key}) : super(key: key);

  @override
  State<Portrt> createState() => PtState();

  static int projectCount = 0;
  static final projectList = LinkedList<ProjectNodes>();
  static int project = 0;
}

class PtState extends State<Portrt>{

  viewWhenDue(int i) {
    if (Portrt.projectList.elementAt(Portrt.projectCount-1-i).dueDate.toLocal().difference(DateTime.now()).inDays != 0){
      return "Due in ${Portrt.projectList.elementAt(Portrt.projectCount-1-i).dueDate.toLocal().difference(DateTime.now()).inDays} days";
    } else {
      return "Due Today";
    }
  }

  pushToScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => projcrt.CreateProject()),
    );
  }

  toProject(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => projview.ProjectPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
          builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text("Current Projects"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed:() => pushToScreen(context),
        ),
        body: (Portrt.projectCount<=0) ? const Center(child: Text("No projects found. \nAdd a Project", style: TextStyle(height: 1.4, fontWeight: FontWeight.bold, fontSize: 20))) : ListView(    //Project List
          children: List.generate(Portrt.projectCount, (i) =>
              Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.album),
                          title: GestureDetector(
                            onTap: () {
                              Portrt.project = i;
                              toProject(context);
                            },
                            child: Text(Portrt.projectList.elementAt(Portrt.projectCount-1-i).projectName),
                          ),
                          subtitle: Text(Portrt.projectList.elementAt(Portrt.projectCount-1-i).projectCommissioner),

                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(viewWhenDue(i)),
                            const SizedBox(width: 8, height: 8),
                            TextButton(
                              child: const Text('REMOVE'),
                              onPressed: () {
                                Portrt.projectList.elementAt(Portrt.projectCount -1 - i).unlink();
                                Portrt.projectCount--;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Portrt()),
                                );
                              },
                            ),
                            const SizedBox(width: 8, height: 8),
                          ],
                        ),
                        ]
                      ),
              ),
          )

        ),
      ),
      )
    );
  }
}
