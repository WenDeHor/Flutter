import 'package:flutter/material.dart';
import 'package:flutter_demo/fetch_data/project.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(BuildContext context) => MainScreen(),
      '/second':(BuildContext context) => SecondScreen()
    },
    onGenerateRoute: (routeSettings){
      var path = routeSettings.name.split('/');

      if (path[1] == "second") {
        return new MaterialPageRoute(
          builder: (context) => new SecondScreen(id:path[2]),
          settings: routeSettings,
        );
      }
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawerMain extends StatefulWidget {
  DrawerMain({Key key, this.selected}) : super(key: key);

  final String selected;

  @override
  DrawerMainState createState() {
    return DrawerMainState();
  }
}

class DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            child: Text(
              'Flutter demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            selected: widget.selected == 'about',
            leading: Icon(Icons.info),
            title: Text('Про нас'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            selected: widget.selected == 'projects',
            leading: Icon(Icons.list),
            title: Text('Проекти'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectsPage()),
              );
            },
          ),
        ]));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Про нас'),
      ),
      drawer: DrawerMain(selected: "about"),
      body: Center(
        child: Text(
          'Ми робимо додаток на Flutter.',
        ),
      ),
    );
  }
}

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> list = List();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  Future _fetchData() async {
    final response = await http.get(
        "https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0");
    if (response.statusCode == 200) {
      setState(() {
        list = (json.decode(response.body) as List)
            .map((data) => new Project.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Проекти'),
      ),
      drawer: DrawerMain(selected: "projects"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _fetchData,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    RaisedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
                      Image.network(
                        list[index].imageUrl,
                        fit: BoxFit.fitHeight,
                        width: 600.0,
                        height: 240.0,
                      );
                    }
                      Text(
                      list[index].alt_description,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      list[index].name,
                      style: TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class SecondScreen extends State<ProjectsPage> {  List<Project> list2 = List();

  final response = await http.get(
  "https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0");
  if (response.statusCode == 200) {
  setState(() {
  list2 = (json.decode(response.body) as List)
      .map((data) => new Project_second.fromJson(data))
      .toList();
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold( children: <Widget>[ Image.network( list2[index].url_full,),],);
  }
}





//list[index].imageUrl,

