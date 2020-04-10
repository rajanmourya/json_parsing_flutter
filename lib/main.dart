import 'package:flutter/material.dart';
import 'package:jsonparsingflutter/Services/Services.dart';

import 'Model/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> futureUser;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureUser = Services.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parsing"),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUser,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  return listContainer(snapshot.data);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Data not available"),
                  );
                }
                break;
              }
            case ConnectionState.none:
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget listContainer(List<User> data) => ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Name: ${data[index].name}\t||\t"
                " Username: ${data[index].username}"),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text("Email: ${data[index].email}"
                  " City: ${data[index].address.city}"
                  " \nCompany: ${data[index].company.name}"),
            ),
          ),
        );
      });
}
