import 'dart:async';
import 'dart:io';

import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  DatabaseProvider(){
    database;
  }

  Future<Database?> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "escaperoom.db");


    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      if (kDebugMode) {
        print("Creating new copy from asset");
      }

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "escaperoom.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      if (kDebugMode) {
        print("Opening existing database");
      }
    }
    return await openDatabase(path, version: 1, onUpgrade: _onUpgrade);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      if (kDebugMode) {
        print("DB upgrade");
      }
    }
  }

  Future<List<EscapeRoom>> getAllRooms() async {
    var db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('escaperoom');
    return List.generate(maps.length, (index) {
      return EscapeRoom(id: maps[index]['id'] as int,
          name: maps[index]['name'] as String,
          region: maps[index]['region'] as String,
          sub_region: maps[index]['sub_region'] as String,
          prefer: maps[index]['prefer'] as int,
          day: maps[index]['day'] as int,
          etc: maps[index]['etc'] as String,
          top_placement: maps[index]['top_placement'] as int);
    });
  }

  Future roomUpdate(EscapeRoom room) async {
    var db = await database;
    await db!.update('escaperoom', room.toMap(), where: 'id = ?', whereArgs: [room.id]);
    if (kDebugMode) {
      print("update escaperoom");
    }
  }
}