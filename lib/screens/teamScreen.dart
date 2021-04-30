import 'package:flutter/material.dart';
import 'package:footapp/models/player.dart';
import 'package:footapp/provider/Teams.dart';
import 'package:footapp/screens/homeScreen.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Consumer<SelectTeamProvider>(builder: (context, load, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Equipe A",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 3,
              child: Item(load.teamA, Colors.white),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Equipe B",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 3,
              child: Item(load.teamA, Colors.white),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextButton(
                child: Text(
                  'Terminer',
                ),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                    textStyle: TextStyle(
                      fontSize: 20,
                    )),
                onPressed: () {
                  load.cleanA();
                  load.cleanB();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()),
                    ModalRoute.withName('/'),
                  );
                }),
          ]),
        );
      }),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Item(List<Player> list, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(list[index].name),
          );
        },
      ),
    );
  }
}
