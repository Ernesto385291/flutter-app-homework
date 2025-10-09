import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

///CLASE PARA LA CREACIÓN DE LA BD Y FUNCIONES DEL CRUD
class DatabaseHelper {
  static const _databaseName = "MyDatabase.db"; //NOMBRE DE SU BD
  static const _databaseVersion = 1; //VERSION DE LA BD

  static const table = 'my_table'; //NOMBRE DE LA TABLA
  //SUS ATRIBUTOS
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnAge = 'age';

  late Database _db; //SE CREA LA INSTANCIA DE LA BD A TRAVÉS DE SQLITE

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final String dbPath;

    // Obtención de la dirección/path para almacenar la BD
    if (kIsWeb) {
      // En web, usa un nombre simple; se almacenará en IndexedDB
      dbPath = _databaseName;
    } else {
      // En móvil/escritorio, almacena en el directorio de la app
      final documentsDirectory =
          (await getApplicationDocumentsDirectory()).path;
      dbPath = join(documentsDirectory, _databaseName);
    }

    // Crear y abrir la BD
    _db = await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY autoincrement,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
      )
    ''');
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  // Query all rows ordered by id desc
  Future<List<Map<String, dynamic>>> queryAll() async {
    return await _db.query(table, orderBy: '$columnId DESC');
  }

  // Update a row by id; expects the id in the map
  Future<int> update(Map<String, dynamic> row) async {
    final int id = row[columnId] as int;
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete a row by id
  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
