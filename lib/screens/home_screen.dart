import 'package:flutter/material.dart';
import '../widgets/grafico_ordenes.dart';

import '../models/orden_servicio.dart';
import '../services/orden_servicio_dao.dart';

class HomeScreen extends StatefulWidget {
  final OrdenServicioDao? dao;

  const HomeScreen({
    super.key,
    this.dao,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _placaController = TextEditingController();
  final _descripcionController = TextEditingController();

  late final OrdenServicioDao _dao;

  final List<OrdenServicio> _ordenes = [];

  Set<String> get _placasUnicas {
    return _ordenes.map((orden) => orden.placa).toSet();
  }

  bool _cargando = true;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();

    _dao = widget.dao ?? OrdenServicioDao();

    _cargarOrdenes();
  }

  @override
  void dispose() {
    _placaController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _cargarOrdenes() async {
    try {
      final ordenesGuardadas = await _dao.consultarTodas();

      if (!mounted) return;

      setState(() {
        _ordenes
          ..clear()
          ..addAll(ordenesGuardadas);

        _cargando = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _cargando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudieron cargar las órdenes: $error',
          ),
        ),
      );
    }
  }

  Future<void> _registrarOrden() async {
    if (_guardando) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _guardando = true;
    });

    final nuevaOrden = OrdenServicio(
      placa: _placaController.text.trim().toUpperCase(),
      descripcion: _descripcionController.text.trim(),
      fecha: DateTime.now(),
    );

    try {
      await _dao.insertar(nuevaOrden);

      final ordenesGuardadas = await _dao.consultarTodas();

      if (!mounted) return;

      setState(() {
        _ordenes
          ..clear()
          ..addAll(ordenesGuardadas);

        _guardando = false;
      });

      _placaController.clear();
      _descripcionController.clear();
      _formKey.currentState!.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Orden registrada correctamente'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _guardando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo guardar la orden: $error',
          ),
        ),
      );
    }
  }

  Future<void> _cambiarEstado(OrdenServicio orden) async {
    final estadoAnterior = orden.estado;

    orden.cambiarEstado();

    try {
      await _dao.actualizar(orden);

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Estado actualizado: ${orden.estado}',
          ),
        ),
      );
    } catch (error) {
      orden.estado = estadoAnterior;

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo actualizar el estado: $error',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendientes =
        _ordenes.where((orden) => orden.estado == 'Pendiente').length;

    final enReparacion =
        _ordenes.where((orden) => orden.estado == 'En reparación').length;

    final terminadas =
        _ordenes.where((orden) => orden.estado == 'Terminada').length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Taller'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Gestión de órdenes de servicio',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Registra los vehículos y consulta el avance '
              'de sus reparaciones.',
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Nueva orden',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _placaController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'Placa del vehículo',
                          hintText: 'Ejemplo: ABC123',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.directions_car,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa la placa del vehículo';
                          }

                          if (value.trim().length < 5) {
                            return 'La placa es demasiado corta';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descripcionController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Descripción de la reparación',
                          hintText: 'Ejemplo: cambio de aceite',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.build),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Describe la reparación';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _guardando ? null : _registrarOrden,
                        icon: const Icon(Icons.add),
                        label: Text(
                          _guardando ? 'Guardando...' : 'Registrar orden',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Órdenes registradas: ${_ordenes.length}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text('Vehículos únicos: ${_placasUnicas.length}'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resumen de órdenes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GraficoOrdenes(
                      pendientes: pendientes,
                      enReparacion: enReparacion,
                      terminadas: terminadas,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_cargando)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_ordenes.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Todavía no hay órdenes registradas',
                      ),
                      Text(
                        'Completa el formulario para comenzar.',
                      ),
                    ],
                  ),
                ),
              )
            else
              for (final orden in _ordenes)
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.car_repair),
                    ),
                    title: Text(orden.placa),
                    subtitle: Text(
                      '${orden.descripcion}\n'
                      'Estado: ${orden.estado}\n'
                      '${orden.obtenerResumen()}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: 'Cambiar estado',
                      icon: const Icon(Icons.sync),
                      onPressed: () => _cambiarEstado(orden),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
