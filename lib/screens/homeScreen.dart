import 'package:flutter/material.dart';
import 'package:footapp/database/dbHelper.dart';
import 'package:footapp/models/player.dart';
import 'package:footapp/provider/loading.dart';
import 'package:footapp/provider/selectPlayer.dart';
import 'package:footapp/screens/rendom_player_Screen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _name = TextEditingController();
  var list = <DropdownMenuItem>[];
  var selectedItem;
  bool allSelected = false;
  DbHelper dbHelper;
  Player p;
  List<bool> listBool;
  List<Player> playersAct = [];
  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done_all_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RendomPlayerScreen()),
            ),
             
          )
        ],
      ),
      body: FutureBuilder(
          future: dbHelper.allPlayers(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      p = Player.fromMap(snapshot.data[i]);
                      listBool = List.filled(snapshot.data.length, false);

                      return ItemWedget(p, i);
                    });
              } else {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Il y a aucun joueur ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPlayerDialog(),
        tooltip: 'Dialog',
        child: Icon(Icons.add),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ItemWedget(Player p, int i) {
    return Consumer<LoadingControl>(builder: (context, load, child) {
      return ListTile(
        onTap: () {
          listBool[i] = !listBool[i];
          if (listBool[i]) {
            Provider.of<SelectPlayerProvider>(context, listen: false).add(p);
          } else {
            Provider.of<SelectPlayerProvider>(context, listen: false).delete(p);
          }

          load.add_loading();
        },
        title: Text('${p.name}'),
        subtitle: Text(p.poste),
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            listBool[i] = value;
            if (listBool[i]) {
              Provider.of<SelectPlayerProvider>(context, listen: false).add(p);
            } else {
              Provider.of<SelectPlayerProvider>(context, listen: false)
                  .delete(p);
            }

            load.add_loading();
          },
          value: listBool[i],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            _deletePlayer(p.id);
          },
        ),
      );
    });
  }

  _addPlayerDialog() {
    _loadPosts();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.white,
              content: Container(
                height: 220.0,
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        'Ajouter un nouveau joueur',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.person_add),
                          hintText: "Nom et Prenom",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        keyboardType: TextInputType.text,
                        controller: _name,
                      ),
                    )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        hint: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.sports_soccer,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Post",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ]),
                        value: selectedItem,
                        items: list,
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              child: Text(
                                'Annuler',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                list.clear();
                                _name.clear();
                                Navigator.of(context).pop();
                              }),
                          TextButton(
                              child: Text(
                                'Confirmer',
                                style: TextStyle(color: Colors.green),
                              ),
                              onPressed: () {
                                _addPlayer();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _loadPosts() {
    List l = ["gardient de but", "défenseur", "milieu de terrain", "attaquant"];
    l.forEach((element) {
      setState(() {
        list.add(DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.sports_soccer),
              SizedBox(width: 10),
              Text(
                element,
              ),
            ],
          ),
          value: element,
        ));
      });
    });
  }

  _addPlayer() async {
    Player p = Player(
        {'name': _name.text, 'poste': selectedItem.toString(), 'team': "c"});
    int id = await dbHelper.createPlayers(p);
    print(id);
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => MyHomePage(),
            transitionDuration: Duration(seconds: 1)));
  }

  _deletePlayer(int id) async {
    int idR = await dbHelper.deletePlayers(id);
    print("del $idR");
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => MyHomePage(),
            transitionDuration: Duration(seconds: 1)));
  }
}
