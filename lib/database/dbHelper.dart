import 'package:footapp/models/player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal(); // recherche
  factory DbHelper() => _instance; //recherch
  DbHelper.internal();
  static Database _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'footDB.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      //create all tables
      db.execute(
          "create table players(id integer primary key autoincrement, name varchar(50), poste varchar(30), team varchar(2))");
    });
    return _db;
  }

  Future<int> createPlayers(Player player) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses')
    return db.insert('players', player.toMap());
  }

  Future<List> allPlayers() async {
    Database db = await createDatabase();
    //db.rawQuery("select * from courses")
    return db.query('players',
        columns: ['id', 'name', 'poste'], orderBy: 'id ASC'); //
  }

  Future<int> deletePlayers(int id) async {
    Database db = await createDatabase();
    return db.delete('players', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePlayerTeam(int id, Player player) async {
    Database db = await createDatabase();
    return db.update('players', player.toMap(),
        where: 'id = ?', whereArgs: [player.id]);
  }
}
