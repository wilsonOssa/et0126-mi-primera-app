# Mi Taller â€” GestiÃ³n de Ã³rdenes de servicio

**Asignatura:** ProgramaciÃ³n de Dispositivos MÃ³viles
**InstituciÃ³n:** IU Pascual Bravo
**TecnologÃ­as:** Flutter y Dart
**Base de datos:** SQLite
**Modalidad:** Proyecto individual

## 1. DescripciÃ³n de la aplicaciÃ³n

Mi Taller es una aplicaciÃ³n desarrollada con Flutter que busca facilitar el registro y seguimiento de las Ã³rdenes de servicio de pequeÃ±os talleres automotrices.

Permite registrar la placa de un vehÃ­culo, describir la reparaciÃ³n que necesita, consultar las Ã³rdenes guardadas y actualizar su estado. TambiÃ©n presenta un resumen grÃ¡fico de las Ã³rdenes para facilitar el seguimiento de los trabajos.

## 2. Usuario, problema y soluciÃ³n

**Usuario:** propietarios y trabajadores de pequeÃ±os talleres automotrices.

**Problema:** cuando la informaciÃ³n de las reparaciones se lleva de forma manual, puede ser difÃ­cil consultar las Ã³rdenes, conocer su estado y mantener organizado el trabajo del taller.

**SoluciÃ³n:** Mi Taller reÃºne las Ã³rdenes de servicio en una aplicaciÃ³n, permite consultar sus datos y muestra un resumen de los estados de las reparaciones.

## 3. Funcionalidades principales

1. **Registrar Ã³rdenes de servicio:** ingresar la placa del vehÃ­culo y la descripciÃ³n de la reparaciÃ³n, con validaciÃ³n de los campos obligatorios.
2. **Consultar y actualizar Ã³rdenes:** visualizar las Ã³rdenes registradas y cambiar su estado entre Pendiente, En reparaciÃ³n y Terminada.
3. **Consultar un resumen grÃ¡fico:** visualizar la cantidad de Ã³rdenes por estado mediante un grÃ¡fico desarrollado con Canvas.

La aplicaciÃ³n tambiÃ©n muestra la cantidad total de Ã³rdenes y el nÃºmero de placas diferentes registradas.

## 4. Recorrido del usuario

1. El usuario abre Mi Taller.
2. Ingresa la placa del vehÃ­culo y la descripciÃ³n de la reparaciÃ³n.
3. Pulsa el botÃ³n Â«Registrar ordenÂ».
4. La aplicaciÃ³n valida los datos y guarda la orden.
5. La orden aparece en la lista.
6. El usuario actualiza el estado de la reparaciÃ³n cuando sea necesario.
7. El resumen grÃ¡fico refleja la cantidad de Ã³rdenes de cada estado.

## 5. Datos y almacenamiento

Cada orden de servicio contiene:

- Identificador.
- Placa del vehÃ­culo.
- DescripciÃ³n de la reparaciÃ³n.
- Fecha de registro.
- Estado de la orden.

La aplicaciÃ³n utiliza SQLite para almacenar los registros localmente. El acceso a los datos se organiza mediante una clase DAO (Data Access Object).

La persistencia debe verificarse en la plataforma de ejecuciÃ³n utilizada, comprobando que los registros permanezcan despuÃ©s de cerrar y volver a abrir la aplicaciÃ³n.

## 6. Estructura del proyecto

```text
lib/
â”œâ”€â”€ main.dart
â”œâ”€â”€ models/
â”‚   â””â”€â”€ orden_servicio.dart
â”œâ”€â”€ screens/
â”‚   â””â”€â”€ home_screen.dart
â”œâ”€â”€ services/
â”‚   â”œâ”€â”€ base_datos.dart
â”‚   â””â”€â”€ orden_servicio_dao.dart
â””â”€â”€ widgets/
    â””â”€â”€ grafico_ordenes.dart

test/
â””â”€â”€ widget_test.dart
```

**DescripciÃ³n de los archivos principales:**

- `main.dart`: inicia la aplicaciÃ³n.
- `models/orden_servicio.dart`: representa los datos de una orden de servicio.
- `screens/home_screen.dart`: contiene la pantalla principal, el formulario, la lista y el resumen de las Ã³rdenes.
- `services/base_datos.dart`: configura el almacenamiento local.
- `services/orden_servicio_dao.dart`: realiza las operaciones de acceso a las Ã³rdenes.
- `widgets/grafico_ordenes.dart`: dibuja el resumen grÃ¡fico de los estados.
- `test/widget_test.dart`: contiene las pruebas automatizadas de la interfaz y del registro de Ã³rdenes.

## 7. Conceptos de Dart aplicados

- **Tipos de datos y null safety:** uso de tipos como `String`, `int` y `DateTime`, con control de valores que pueden ser nulos.
- **Clases y objetos:** la clase `OrdenServicio` representa cada registro.
- **Funciones y mÃ©todos:** permiten organizar las operaciones de la aplicaciÃ³n.
- **List:** almacena y permite recorrer las Ã³rdenes de servicio.
- **Map:** transforma los datos de una orden para guardarlos y recuperarlos de la base de datos.
- **Set:** permite obtener las placas Ãºnicas de los vehÃ­culos registrados.
- **Condicionales `if` y `else`:** permiten validar datos y tomar decisiones segÃºn el estado de una orden.
- **Ciclo `for`:** permite recorrer las Ã³rdenes para mostrarlas en pantalla.
- **Operaciones asÃ­ncronas:** permiten realizar operaciones de almacenamiento sin bloquear innecesariamente la interfaz.

No se utiliza un ciclo `while` porque no es necesario para las funcionalidades principales de esta versiÃ³n.

## 8. GrÃ¡fico Canvas

La aplicaciÃ³n incorpora un grÃ¡fico de barras para representar la cantidad de Ã³rdenes pendientes, en reparaciÃ³n y terminadas.

El grÃ¡fico permite visualizar de forma sencilla cÃ³mo se distribuyen los trabajos del taller. Sus cantidades se calculan a partir de las Ã³rdenes registradas.

## 9. Validaciones y pruebas

Durante las pruebas manuales se verificaron las siguientes funcionalidades:

- Registro de Ã³rdenes con datos vÃ¡lidos.
- ValidaciÃ³n de los campos obligatorios.
- VisualizaciÃ³n de las Ã³rdenes registradas.
- ActualizaciÃ³n de los estados.
- VisualizaciÃ³n del resumen grÃ¡fico.
- Persistencia de los registros despuÃ©s de reiniciar la aplicaciÃ³n.

Las pruebas automatizadas de widgets verifican la pantalla principal y el registro de una orden utilizando un DAO de prueba.

En la Ãºltima ejecuciÃ³n registrada, `flutter analyze` terminÃ³ con `No issues found!` y las dos pruebas automatizadas finalizaron con `All tests passed!`.

## 10. InstalaciÃ³n y ejecuciÃ³n

### Requisitos

- Flutter SDK.
- Dart incluido con Flutter.
- Visual Studio y las herramientas de desarrollo correspondientes si se ejecuta en Windows.
- Las herramientas necesarias para la plataforma elegida.

### Pasos

1. Clonar el repositorio:

```bash
git clone https://github.com/wilsonOssa/et0126-mi-primera-app.git
```

2. Entrar en la carpeta del proyecto:

```bash
cd et0126-mi-primera-app
```

3. Instalar las dependencias:

```bash
flutter pub get
```

4. Analizar el cÃ³digo:

```bash
flutter analyze
```

5. Ejecutar las pruebas:

```bash
flutter test --reporter expanded
```

6. Ejecutar la aplicaciÃ³n:

```bash
flutter run
```

Para ejecutarla en Windows, se puede utilizar:

```bash
flutter run -d windows
```

La disponibilidad de SQLite y sus dependencias debe comprobarse para la plataforma de destino.

## 11. Evidencias

Se deben adjuntar capturas reales de la aplicaciÃ³n que muestren:

- La pantalla principal y el formulario de registro.
- La validaciÃ³n de los campos obligatorios.
- Las Ã³rdenes registradas y sus estados.
- El grÃ¡fico Canvas.
- La persistencia de los datos despuÃ©s de reiniciar la aplicaciÃ³n.

TambiÃ©n se recomienda conservar la evidencia de la ejecuciÃ³n de `flutter analyze` y de las pruebas automatizadas.

## 12. Uso de inteligencia artificial

Se utilizÃ³ ChatGPT como apoyo para comprender errores, revisar cÃ³digo, organizar la documentaciÃ³n y orientar las pruebas. El estudiante debe comprender el funcionamiento del cÃ³digo entregado y estar en capacidad de explicar las decisiones tomadas durante el desarrollo.

## 13. Repositorio

**GitHub:** https://github.com/wilsonOssa/et0126-mi-primera-app

## 14. ConclusiÃ³n

Mi Taller es una aplicaciÃ³n desarrollada como ejercicio acadÃ©mico para aplicar conceptos de Dart y Flutter. Permite registrar Ã³rdenes de servicio, consultar su informaciÃ³n, actualizar los estados de las reparaciones y visualizar un resumen grÃ¡fico. AdemÃ¡s, incorpora almacenamiento local y pruebas automatizadas para comprobar funcionalidades bÃ¡sicas.

Este proyecto representa una primera versiÃ³n de una herramienta de apoyo para pequeÃ±os talleres automotrices y una oportunidad para continuar fortaleciendo los conocimientos de desarrollo de aplicaciones mÃ³viles.

## Capturas de pantalla

### Pantalla principal
![Pantalla principal de Mi Taller](screenshots/pantalla_principal.png)

### Órdenes registradas
![Órdenes registradas](screenshots/ordenes_registradas.png)

### Gráfico de órdenes
![Gráfico de órdenes](screenshots/grafico_ordenes.png)
    