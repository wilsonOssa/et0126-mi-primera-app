import 'package:flutter/material.dart';

class GraficoOrdenes extends StatelessWidget {
  final int pendientes;
  final int enReparacion;
  final int terminadas;

  const GraficoOrdenes({
    super.key,
    required this.pendientes,
    required this.enReparacion,
    required this.terminadas,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: CustomPaint(
        painter: GraficoOrdenesPainter(
          pendientes: pendientes,
          enReparacion: enReparacion,
          terminadas: terminadas,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class GraficoOrdenesPainter extends CustomPainter {
  final int pendientes;
  final int enReparacion;
  final int terminadas;
  final Color color;

  GraficoOrdenesPainter({
    required this.pendientes,
    required this.enReparacion,
    required this.terminadas,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final valores = [pendientes, enReparacion, terminadas];
    final etiquetas = ['Pendientes', 'En reparación', 'Terminadas'];

    final maximo = valores.reduce((a, b) => a > b ? a : b);
    final escala = maximo == 0 ? 1.0 : maximo.toDouble();

    final pincel = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final texto = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final anchoBarra = size.width / 3 * 0.45;
    final espacio = size.width / 3;

    for (int i = 0; i < valores.length; i++) {
      final alto = valores[i] / escala * 65.0;
      final x = espacio * i + (espacio - anchoBarra) / 2;
      final y = 85.0 - alto;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, anchoBarra, alto),
          const Radius.circular(6),
        ),
        pincel,
      );

      texto.text = TextSpan(
        text: '${valores[i]}',
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      texto.layout();
      texto.paint(
        canvas,
        Offset(x + (anchoBarra - texto.width) / 2, y - 18),
      );

      texto.text = TextSpan(
        text: etiquetas[i],
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 10,
        ),
      );
      texto.layout(maxWidth: espacio);
      texto.paint(
        canvas,
        Offset(espacio * i + (espacio - texto.width) / 2, 95),
      );
    }
  }

  @override
  bool shouldRepaint(covariant GraficoOrdenesPainter oldDelegate) {
    return pendientes != oldDelegate.pendientes ||
        enReparacion != oldDelegate.enReparacion ||
        terminadas != oldDelegate.terminadas ||
        color != oldDelegate.color;
  }
}
