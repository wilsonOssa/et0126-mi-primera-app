class OrdenServicio {
  final int? id;
  final String placa;
  final String descripcion;
  final DateTime fecha;
  String estado;

  OrdenServicio({
    this.id,
    required this.placa,
    required this.descripcion,
    required this.fecha,
    this.estado = 'Pendiente',
  });

  // Convierte la orden en un mapa para guardarla en SQLite.
  Map<String, Object?> toMap() {
    return {
      'placa': placa,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'estado': estado,
    };
  }

  // Convierte un registro de SQLite en una orden.
  factory OrdenServicio.fromMap(Map<String, Object?> mapa) {
    return OrdenServicio(
      id: mapa['id'] as int,
      placa: mapa['placa'] as String,
      descripcion: mapa['descripcion'] as String,
      fecha: DateTime.parse(mapa['fecha'] as String),
      estado: mapa['estado'] as String,
    );
  }

  // Cambia el estado de la orden de servicio.
  void cambiarEstado() {
    if (estado == 'Pendiente') {
      estado = 'En reparación';
    } else if (estado == 'En reparación') {
      estado = 'Terminada';
    } else {
      estado = 'Pendiente';
    }
  }

  // Genera un resumen de la orden.
  String obtenerResumen() {
    return '$placa - $estado';
  }
}
