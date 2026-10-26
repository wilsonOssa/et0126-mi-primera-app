import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mi_primera_app/models/orden_servicio.dart';
import 'package:mi_primera_app/screens/home_screen.dart';
import 'package:mi_primera_app/services/orden_servicio_dao.dart';

class DaoPrueba extends OrdenServicioDao {
  final List<OrdenServicio> _ordenes = [];
  int _siguienteId = 1;

  @override
  Future<List<OrdenServicio>> consultarTodas() async {
    return List<OrdenServicio>.from(_ordenes.reversed);
  }

  @override
  Future<int> insertar(OrdenServicio orden) async {
    final id = _siguienteId++;

    _ordenes.add(
      OrdenServicio(
        id: id,
        placa: orden.placa,
        descripcion: orden.descripcion,
        fecha: orden.fecha,
        estado: orden.estado,
      ),
    );

    return id;
  }

  @override
  Future<int> actualizar(OrdenServicio orden) async {
    final indice = _ordenes.indexWhere(
      (elemento) => elemento.id == orden.id,
    );

    if (indice == -1) {
      return 0;
    }

    _ordenes[indice] = OrdenServicio(
      id: orden.id,
      placa: orden.placa,
      descripcion: orden.descripcion,
      fecha: orden.fecha,
      estado: orden.estado,
    );

    return 1;
  }
}

void main() {
  testWidgets(
    'Muestra la pantalla principal de Mi Taller',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(dao: DaoPrueba()),
        ),
      );

      // Permite que termine la carga inicial de las órdenes.
      await tester.pumpAndSettle();

      expect(find.text('Mi Taller'), findsOneWidget);
      expect(
        find.text('Gestión de órdenes de servicio'),
        findsOneWidget,
      );
      expect(find.text('Nueva orden'), findsOneWidget);
      expect(find.text('Registrar orden'), findsOneWidget);
      expect(find.text('Vehículos únicos: 0'), findsOneWidget);
    },
  );

  testWidgets(
    'Permite registrar una orden de servicio',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(dao: DaoPrueba()),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'ABC123',
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Cambio de aceite',
      );

      await tester.ensureVisible(find.text('Registrar orden'));
      await tester.tap(find.text('Registrar orden'));
      await tester.pumpAndSettle();

      expect(find.text('Órdenes registradas: 1'), findsOneWidget);
      expect(find.text('Vehículos únicos: 1'), findsOneWidget);
      expect(find.text('ABC123'), findsOneWidget);
      expect(
        find.textContaining('Cambio de aceite'),
        findsOneWidget,
      );
      expect(
        find.textContaining('Estado: Pendiente'),
        findsOneWidget,
      );
    },
  );
}
