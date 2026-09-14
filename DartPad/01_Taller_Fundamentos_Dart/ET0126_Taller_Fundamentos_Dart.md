# ET0126 — Taller de Fundamentos de Dart

## Información

- **Asignatura:** Programación de dispositivos móviles
- **Lenguaje:** Dart
- **Entorno de prueba:** DartPad
- **Archivo principal:** `taller_fundamentos_dart.dart`

## Objetivo

Consolidar los fundamentos de Dart mediante variables y tipos, null safety, funciones, colecciones, control de flujo, clases y programación orientada a objetos, finalizando con un sistema sencillo de gestión de tareas.

## Estructura de la solución

### Parte 1 — Variables y tipos
Se creó una ficha digital de estudiante utilizando `String`, `int`, `double` y `bool`. La edad se representa como `int` porque posteriormente puede utilizarse en operaciones matemáticas o comparaciones.

### Parte 2 — Null safety
El apodo se declaró como `String?` porque puede no existir y, en ese caso, su valor puede ser `null`. Se utiliza una condición para mostrar el apodo o un mensaje alternativo.

También se dejó documentada la prueba del operador `!`. Si se fuerza un valor `null` con `!`, el problema aparece durante la ejecución cuando realmente se intenta utilizar el valor nulo.

### Parte 3 — Funciones
Se implementaron:
- `aprobarMateria(double nota)`: determina si una nota es aprobatoria.
- `calcularPromedio(List<double> notas)`: calcula el promedio y devuelve `null` cuando la lista está vacía.

Para los ejemplos se utiliza como nota mínima aprobatoria `3.0`.

### Parte 4 — Colecciones
- `List`: asistentes, porque puede contener nombres repetidos y conserva el orden.
- `Set`: lenguajes conocidos, porque no se necesitan valores repetidos.
- `Map`: relación nombre → nota, porque permite asociar una clave con un valor.

### Parte 5 — Control de flujo
**Problema A:** se utiliza `for` para recorrer todo el listado de notas y contar reprobados, aprobados y sobresalientes.

**Problema B:** se utiliza `while` para controlar los intentos de contraseña hasta que se obtenga la correcta o se alcance el límite de intentos.

Criterios usados:
- Menor de 3.0: reprobado.
- De 3.0 a menor de 4.5: aprobado.
- 4.5 o superior: sobresaliente.

### Parte 6 — Clases y POO
Se creó la clase `Estudiante`, que reúne información y comportamientos relacionados. Cada objeto puede almacenar sus propias notas y determinar si está al día.

La principal ventaja frente a tres listas separadas es que los datos y comportamientos del estudiante permanecen agrupados en una misma entidad, evitando depender de posiciones sincronizadas.

### Reto integrador — Sistema de gestión de tareas
Se creó:
- `Tarea`, con título, prioridad y estado.
- `Prioridad`, mediante un `enum` con alta, media y baja.
- `marcarCompletada()`, para cambiar el estado.
- Una `List<Tarea>` con cinco tareas.
- `contarPendientes()`, para obtener las tareas pendientes.
- `mostrar()`, para presentar cada tarea según su prioridad.
- `contarPorPrioridad()`, como bonus.

El diseño también puede ampliarse agregando `DateTime? fechaLimite` a la clase `Tarea`, ya que una fecha límite puede ser opcional.

## Pruebas realizadas

Se incluyeron casos normales y casos límite:

1. **Lista vacía de notas:** `calcularPromedio([])` devuelve `null` en lugar de intentar dividir entre cero.
2. **Apodo inexistente:** `String? apodo` permite manejar `null`.
3. **Elemento repetido en Set:** el lenguaje `Dart` se agrega dos veces al código de ejemplo, pero el `Set` conserva una sola aparición.
4. **Lista con repetidos:** la `List` de lenguajes muestra que sí permite valores duplicados.
5. **Estudiante atrasado:** se creó un estudiante con menos notas registradas que materias inscritas.
6. **Contraseña:** se prueban varios intentos hasta conseguir la contraseña correcta o agotar el máximo.

## Ejecución

1. Abrir DartPad.
2. Seleccionar Dart.
3. Copiar el contenido de `taller_fundamentos_dart.dart`.
4. Ejecutar el programa.
5. Revisar la consola y verificar que todas las partes producen resultados.
6. Para comprobar el caso del operador `!`, quitar temporalmente los `//` de la línea indicada en la Parte 2 y ejecutar. Debe producir un error de ejecución porque `apodo` contiene `null`.
7. Volver a comentar esa línea antes de guardar la versión final.

## Entrega en GitHub

El repositorio debe contener como mínimo:

```text
/
├── ET0126_Taller_Fundamentos_Dart.md
└── taller_fundamentos_dart.dart
```

Después de subir ambos archivos, compartir el enlace del repositorio o del commit en el canal de Google Chat del curso antes de la fecha indicada en el enunciado.
