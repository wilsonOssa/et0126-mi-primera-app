// taller_fundamentos_dart.dart
// Taller de Fundamentos de Dart - Programación de dispositivos móviles
// Nota: El código está organizado por partes para ejecutarlo completo en DartPad.

void main() {
  // -- Parte 1 --
  print('\n========== PARTE 1: VARIABLES Y TIPOS ==========');

  String nombreEstudiante = 'Daniel Pérez';
  int edad = 20;
  double promedio = 4.2;
  bool matriculaActiva = true;
  String programa = 'Tecnología en Desarrollo de Software';
  int semestre = 3;

  print('Ficha digital del estudiante');
  print('Nombre: $nombreEstudiante');
  print('Edad: $edad años');
  print('Programa: $programa');
  print('Semestre: $semestre');
  print('Promedio: ${promedio.toStringAsFixed(2)}');
  print('Matrícula activa: ${matriculaActiva ? 'Sí' : 'No'}');

  // Si la edad fuera String, por ejemplo '20', sería más difícil hacer
  // operaciones matemáticas directamente. Habría que convertirla a int
  // antes de calcular, comparar o incrementar la edad.

  // -- Parte 2 --
  print('\n========== PARTE 2: NULL SAFETY ==========');

  String? apodo = null;
  // String? significa que la variable puede contener un String o null.
  // El apodo es nullable porque no todos los estudiantes lo tienen registrado.
  // En cambio, nombre, edad, promedio, programa y semestre son datos necesarios
  // para esta ficha y por eso no necesitan ser nullable.

  mostrarApodo(apodo);

  // Prueba del operador !:
  // mostrarApodoConError(null);
  //
  // Si se ejecuta esa función, el operador ! fuerza el valor null y se produce
  // un error durante la ejecución: "Null check operator used on a null value".
  // El error no aparece por escribir !, sino cuando se ejecuta con un valor null.

  // -- Parte 3 --
  print('\n========== PARTE 3: FUNCIONES ==========');

  double notaMateria = 3.7;
  print(
    '¿La nota $notaMateria aprueba?: '
    '${aprobarMateria(notaMateria) ? 'Sí' : 'No'}',
  );

  List<double> notasSemestre = [4.0, 3.5, 4.2, 2.8, 3.9];
  double? promedioSemestre = calcularPromedio(notasSemestre);

  if (promedioSemestre != null) {
    print(
      'Promedio del semestre: ${promedioSemestre.toStringAsFixed(2)}',
    );
  }

  // Caso límite: lista vacía.
  double? promedioVacio = calcularPromedio([]);
  print(
    'Promedio de una lista vacía: '
    '${promedioVacio ?? 'No se puede calcular'}',
  );

  // Una lista vacía no tiene promedio. Por eso la función devuelve double?
  // y retorna null cuando no hay notas, en lugar de inventar un resultado.

  // -- Parte 4 --
  print('\n========== PARTE 4: COLECCIONES ==========');

  // LIST: permite repetidos y conserva el orden.
  List<String> asistentes = [
    'Ana',
    'Carlos',
    'Luisa',
    'Ana',
  ];
  print('Asistentes: $asistentes');

  // SET: no permite elementos repetidos.
  Set<String> lenguajesConocidos = {
    'Dart',
    'Java',
    'Python',
  };

  // Intentamos agregar Dart dos veces. El Set conserva una sola aparición.
  lenguajesConocidos.add('Dart');
  lenguajesConocidos.add('Dart');

  print('Lenguajes conocidos (Set): $lenguajesConocidos');

  // MAP: relaciona una clave con un valor. Es útil para buscar una nota
  // rápidamente usando el nombre del estudiante.
  Map<String, double> notasPorEstudiante = {
    'Ana': 4.5,
    'Carlos': 3.2,
    'Luisa': 4.8,
  };
  print('Nota de Carlos: ${notasPorEstudiante['Carlos']}');

  // Si usáramos List para los lenguajes, 'Dart' sí podría aparecer dos veces:
  List<String> lenguajesConList = ['Dart', 'Java', 'Python', 'Dart'];
  print('Ejemplo con List y repetido: $lenguajesConList');

  // -- Parte 5 --
  print('\n========== PARTE 5: CONTROL DE FLUJO ==========');

  // Problema A: clasificar el rendimiento de todos los estudiantes.
  // Criterio usado:
  // menor de 3.0 = reprobado
  // de 3.0 a 4.4 = aprobado
  // 4.5 o más = sobresaliente
  List<double> notasCurso = [2.5, 3.0, 4.1, 4.8, 3.7, 4.5, 2.9];

  int reprobados = 0;
  int aprobados = 0;
  int sobresalientes = 0;

  for (double nota in notasCurso) {
    if (nota < 3.0) {
      reprobados++;
    } else if (nota < 4.5) {
      aprobados++;
    } else {
      sobresalientes++;
    }
  }

  print('Reprobados: $reprobados');
  print('Aprobados: $aprobados');
  print('Sobresalientes: $sobresalientes');

  // Problema B: máximo 3 intentos para ingresar la contraseña.
  // Como existe una condición que debe repetirse hasta que se cumpla
  // correctamente o se agoten los intentos, while resulta apropiado.
  const String passwordCorrecta = 'Dart123';
  List<String> intentos = ['Dart12', '123456', 'Dart123'];

  int intentoActual = 0;
  bool accesoConcedido = false;
  const int maxIntentos = 3;

  while (intentoActual < maxIntentos && !accesoConcedido) {
    String intento = intentos[intentoActual];
    intentoActual++;

    if (intento == passwordCorrecta) {
      accesoConcedido = true;
    }
  }

  if (accesoConcedido) {
    print('Acceso concedido en el intento $intentoActual.');
  } else {
    print('Acceso bloqueado. Se agotaron los $maxIntentos intentos.');
  }

  // El problema A usa for porque se necesita recorrer todo el listado de notas.
  // El problema B usa while porque se repite una acción mientras exista una
  // condición: todavía quedan intentos y la contraseña no es correcta.

  // -- Parte 6 --
  print('\n========== PARTE 6: CLASES Y POO ==========');

  Estudiante estudiante1 = Estudiante(
    nombre: 'Laura',
    semestre: 3,
    materiasInscritas: 5,
    notas: [4.0, 3.5, 4.2, 3.8, 4.5],
  );

  Estudiante estudiante2 = Estudiante(
    nombre: 'Miguel',
    semestre: 2,
    materiasInscritas: 5,
    notas: [3.2, 2.8, 3.5],
  );

  print(estudiante1.resumen());
  print('¿Está al día con sus notas?: ${estudiante1.estaAlDiaConNotas()}');

  print(estudiante2.resumen());
  print('¿Está al día con sus notas?: ${estudiante2.estaAlDiaConNotas()}');

  // También podemos agregar una nota después de crear el objeto.
  estudiante2.agregarNota(4.0);
  estudiante2.agregarNota(3.6);
  print(
    '${estudiante2.nombre} agregó notas. '
    '¿Está al día?: ${estudiante2.estaAlDiaConNotas()}',
  );

  // La clase reúne datos y comportamientos relacionados en una sola entidad.
  // Esto evita depender de varias listas sincronizadas por posición.
  // Si se usaran tres listas separadas, un cambio de posición podría hacer
  // que el nombre, semestre y promedio dejen de corresponder al mismo estudiante.

  // -- RETO INTEGRADOR: SISTEMA DE GESTIÓN DE TAREAS --
  print('\n========== RETO INTEGRADOR: TAREAS ==========');

  List<Tarea> tareas = [
    Tarea(titulo: 'Estudiar Dart', prioridad: Prioridad.alta),
    Tarea(titulo: 'Entregar taller', prioridad: Prioridad.alta),
    Tarea(titulo: 'Leer documentación', prioridad: Prioridad.media),
    Tarea(titulo: 'Practicar funciones', prioridad: Prioridad.media),
    Tarea(titulo: 'Organizar apuntes', prioridad: Prioridad.baja),
  ];

  // Una tarea puede marcarse como completada después de haber sido creada.
  tareas[0].marcarCompletada();
  tareas[2].marcarCompletada();

  print('\nListado de tareas:');
  for (Tarea tarea in tareas) {
    print(tarea.mostrar());
  }

  print('\nTareas pendientes: ${contarPendientes(tareas)}');

  // Bonus: contar tareas por prioridad.
  Map<Prioridad, int> cantidadPorPrioridad = contarPorPrioridad(tareas);
  print('Tareas de prioridad alta: ${cantidadPorPrioridad[Prioridad.alta]}');
  print('Tareas de prioridad media: ${cantidadPorPrioridad[Prioridad.media]}');
  print('Tareas de prioridad baja: ${cantidadPorPrioridad[Prioridad.baja]}');

  // El diseño puede ampliarse fácilmente con una fecha límite opcional.
  // Por ejemplo, se podría agregar DateTime? fechaLimite al constructor de Tarea.
}

// -- Funciones de la Parte 2 --

void mostrarApodo(String? apodo) {
  if (apodo != null) {
    print('Apodo: $apodo');
  } else {
    print('Apodo: No tiene un apodo registrado.');
  }
}

// Esta función existe solo para la prueba solicitada en el enunciado.
// No se llama en la ejecución normal porque produciría un error intencional.
void mostrarApodoConError(String? apodo) {
  print(apodo!.toUpperCase());
}

// -- Funciones de la Parte 3 --

bool aprobarMateria(double nota) => nota >= 3.0;

double? calcularPromedio(List<double> notas) {
  if (notas.isEmpty) {
    return null;
  }

  double suma = 0;
  for (double nota in notas) {
    suma += nota;
  }

  return suma / notas.length;
}

// -- Clase de la Parte 6 --

class Estudiante {
  String nombre;
  int semestre;
  int materiasInscritas;
  List<double> notas;

  Estudiante({
    required this.nombre,
    required this.semestre,
    required this.materiasInscritas,
    required this.notas,
  });

  bool estaAlDiaConNotas() => notas.length >= materiasInscritas;

  void agregarNota(double nota) {
    notas.add(nota);
  }

  String resumen() {
    return '$nombre - Semestre $semestre - '
        'Notas registradas: ${notas.length}/$materiasInscritas';
  }
}

// -- Clases y funciones del Reto Integrador --

enum Prioridad { alta, media, baja }

class Tarea {
  String titulo;
  Prioridad prioridad;
  bool completada;

  Tarea({
    required this.titulo,
    required this.prioridad,
    this.completada = false,
  });

  void marcarCompletada() {
    completada = true;
  }

  String mostrar() {
    String estado = completada ? 'COMPLETADA' : 'PENDIENTE';

    switch (prioridad) {
      case Prioridad.alta:
        return '[ALTA] $titulo - $estado';
      case Prioridad.media:
        return '[MEDIA] $titulo - $estado';
      case Prioridad.baja:
        return '[BAJA] $titulo - $estado';
    }
  }
}

int contarPendientes(List<Tarea> tareas) {
  int pendientes = 0;

  for (Tarea tarea in tareas) {
    if (!tarea.completada) {
      pendientes++;
    }
  }

  return pendientes;
}

Map<Prioridad, int> contarPorPrioridad(List<Tarea> tareas) {
  Map<Prioridad, int> resultado = {
    Prioridad.alta: 0,
    Prioridad.media: 0,
    Prioridad.baja: 0,
  };

  for (Tarea tarea in tareas) {
    resultado[tarea.prioridad] = resultado[tarea.prioridad]! + 1;
  }

  return resultado;
}
