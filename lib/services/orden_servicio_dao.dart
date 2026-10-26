import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/orden_servicio.dart';
import 'base_datos.dart';

class OrdenServicioDao {
  Future<int> insertar(OrdenServicio orden) async {
    final db = await BaseDatos.obtenerBaseDatos();

    return await db.insert(
      'ordenes',
      orden.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OrdenServicio>> consultarTodas() async {
    final db = await BaseDatos.obtenerBaseDatos();

    final List<Map<String, Object?>> registros = await db.query(
      'ordenes',
      orderBy: 'id DESC',
    );

    return registros.map((registro) {
      return OrdenServicio.fromMap(registro);
    }).toList();
  }

  Future<int> actualizar(OrdenServicio orden) async {
    final db = await BaseDatos.obtenerBaseDatos();

    return await db.update(
      'ordenes',
      orden.toMap(),
      where: 'id = ?',
      whereArgs: [orden.id],
    );
  }
}
