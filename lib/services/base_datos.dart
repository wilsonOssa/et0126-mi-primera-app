import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BaseDatos {
  static Database? _database;

  static Future<Database> obtenerBaseDatos() async {
    if (_database != null) {
      return _database!;
    }

    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    _database = await databaseFactory.openDatabase(
      'mi_taller.db',
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE ordenes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              placa TEXT NOT NULL,
              descripcion TEXT NOT NULL,
              fecha TEXT NOT NULL,
              estado TEXT NOT NULL
            )
          ''');
        },
      ),
    );

    return _database!;
  }
}
