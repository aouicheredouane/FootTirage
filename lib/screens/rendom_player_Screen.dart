import 'dart:math';

import 'package:flutter/material.dart';
import 'package:footapp/Screens/teamScreen.dart';
import 'package:footapp/models/player.dart';
import 'package:footapp/provider/Teams.dart';
import 'package:footapp/provider/selectPlayer.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

class RendomPlayerScreen extends StatefulWidget {
  @override
  RendomPlayerState createState() => RendomPlayerState();
}

class RendomPlayerState extends State<RendomPlayerScreen> {
  TextEditingController _playerA = TextEditingController();
  TextEditingController _playerB = TextEditingController();
  ButtonState stateOnlyText = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Consumer<SelectPlayerProvider>(builder: (context, player, child) {
        return Form(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Nombre des joueur",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "${natureNbr(player.count)}",
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 200.0,
                    ),
                    Text(
                      "Equipe A",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.person),
                      ),
                      controller: _playerA,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Equipe B",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.person),
                      ),
                      controller: _playerB,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    ProgressButton.icon(
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                            text: "Start",
                            icon: Icon(Icons.send, color: Colors.white),
                            color: Theme.of(context).primaryColor,
                          ),
                          ButtonState.loading: IconedButton(
                              color: Theme.of(context).primaryColor),
                          ButtonState.fail: IconedButton(
                              text: "Finish",
                              icon: Icon(Icons.cancel, color: Colors.white),
                              color: Colors.green.shade700),
                          ButtonState.success: IconedButton(
                              text: "Suivant",
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Theme.of(context).primaryColor),
                        },
                        state: stateOnlyText,
                        onPressed: () {
                          if (player.count != 0) {
                            setState(() {
                              stateOnlyText = ButtonState.loading;
                            });
                            _addToTeamA(player);
                            if (player.count != 0) {
                              _addToTeamB(player);
                            } else {
                              setState(() {
                                stateOnlyText = ButtonState.fail;
                              });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TeamScreen()),
                                ModalRoute.withName('/'),
                              );
                            }
                          } else {
                            setState(() {
                              stateOnlyText = ButtonState.fail;
                            });

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TeamScreen()),
                              ModalRoute.withName('/'),
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  _addToTeamA(SelectPlayerProvider p) {
    Random random = new Random();
    int rang = random.nextInt(p.count);
    print(rang);
    Player a = p.show(rang);
    Provider.of<SelectTeamProvider>(context, listen: false).addTeamA(a);

    p.deleteAt(rang);
    setState(() {
      _playerA.text = a.name;
      //stateOnlyText = ButtonState.success;
    });
  }

  _addToTeamB(SelectPlayerProvider p) {
    Random random = new Random();
    int rang = random.nextInt(p.count);
    print(rang);
    Player a = p.show(rang);
    Provider.of<SelectTeamProvider>(context, listen: false).addTeamB(a);
    p.deleteAt(rang);
    setState(() {
      _playerB.text = a.name;
      stateOnlyText = ButtonState.success;
    });
  }

  String natureNbr(int p) {
    var mod = p % 2;
    if (mod == 0) {
      return p.toString();
    } else {
      var sub = p - 1;
      return "$sub-1";
    }
  }

  selectRemplacant(int p) {
    Random random = new Random();
    int rang = random.nextInt(p);
    print("range $rang");

    Provider.of<SelectPlayerProvider>(context, listen: false).deleteAt(rang);
  }
}
