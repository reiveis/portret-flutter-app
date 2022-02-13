import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'main.dart' as home;
import 'package:intl/intl.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
              title: Text(home.Portrt.projectList.elementAt(home.Portrt.projectCount -1  - home.Portrt.project).projectName),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.remove_circle),
              onPressed:() {
                setState(() {           // Adds and returns to Home
                  home.Portrt.projectList.elementAt(home.Portrt.projectCount -1 - home.Portrt.project).unlink();
                  home.Portrt.projectCount--;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => home.Portrt()),
                  );
                }
                );
              },
            ),
            body: ListView(
              children: <Widget>[
                Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text("commissioned by ${home.Portrt.projectList.elementAt(home.Portrt.projectCount -1  - home.Portrt.project).projectCommissioner}"),
                            subtitle: Text(home.Portrt.projectList.elementAt(home.Portrt.projectCount -1 - home.Portrt.project).projectDesc),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text("Due on ${DateFormat('yyyy-MM-dd').format(home.Portrt.projectList.elementAt(home.Portrt.projectCount -1 - home.Portrt.project).dueDate)}"),
                              const SizedBox(width: 8, height: 8),
                            ],
                          ),
                        ]
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
