# Registros

En esta página se introducen los **registros** como tipo de dato estructurado: su motivación, definición, componentes, clasificación de campos (contenido/continente), **campos clave** (primaria/foránea/secundaria), sintaxis en pseudocódigo y ejemplos prácticos. El foco está en el **almacenamiento en memoria interna** y el tratamiento como **unidad lógica**.


---

## Visión general


Un **registro** es un **tipo de dato estructurado y estático** compuesto por **campos** que pueden ser de **diferentes tipos** (heterogéneo). Se utiliza para representar **entidades** del mundo real (por ejemplo, *estudiante*, *producto*, *medicamento*).

**Ideas clave**

* Estructura **heterogénea**: cada campo puede ser entero, real, carácter/alfanumérico, lógico u otro **registro**.
* **Memoria interna**: los registros viven en RAM mientras el algoritmo los procesa.
* **Unidad de tratamiento**: aunque tenga varios campos, el registro se considera **una sola entidad**; se accede a sus partes con el **selector de campo**.

---

## Anatomía de un registro

Un **campo** se define por:

* **Nombre** (identificador único dentro del registro)
* **Tipo** (entero, real, alfanumérico, lógico, u otra estructura)
* **Tamaño** (si aplica, p. ej., AN(30), N(8), etc.)

### Selector de campo

Se utiliza para especificar a qué campo se accede dentro del registro. En pseudocódigo lo representaremos con el **punto** (`.`): `reg.campo`.

---

## Tipos de campos

* **Campos contenido**: almacenan un **único dato simple** (p. ej., `edad: entero`).
* **Campos continente**: están **compuestos** por otros campos (p. ej., `fecha` con `día/mes/año`; `telefono` con `característica/número`).

> Un **campo continente** puede anidarse: `persona.domicilio.ciudad`.

---

## Campos clave

Un **campo clave** identifica un registro **de manera única** dentro de un conjunto.

### Por formato

* **Clave simple**: formada por **un solo** campo contenido (p. ej., `dni`).
* **Clave compleja**: formada por **varios** campos (usualmente continentales) p. ej., `fecha_vacunación = (día, mes, año)`.

### Por función

* **Clave primaria**: identifica **únicamente** el registro (no se repite).
* **Clave foránea**: referencia la **clave primaria** de otro conjunto de registros (relación entre entidades).
* **Clave secundaria**: alternativa de acceso/ordenación que **no** garantiza unicidad.

---

## Sintaxis (pseudocódigo)

### Definición de tipo registro y variables

```pseudocode
// Definición del tipo
ESTUDIANTE = Registro
  dni: N(8)
  apellido: AN(30)
  nombre: AN(30)
  carrera: {ISI, IEM, IQ, LAR}    // ejemplo de tipo enumerado
  ingreso: N(4)                    // año de ingreso
FinRegistro

// Variable de tipo registro
alumno: ESTUDIANTE
```

### Acceso a campos (selector)

```pseudocode
alumno.dni := 45236555
alumno.apellido := "PEREZ"
alumno.nombre := "JUAN"
alumno.carrera := ISI
alumno.ingreso := 2023
```

### Campos continente (anidación)

```pseudocode
FECHA = Registro
  dia: 1..31
  mes: 1..12
  anio: 1900..2100
FinRegistro

VACUNA = Registro
  codigo: AN(13)
  abreviatura: AN(4)
  fecha_aplicacion: FECHA        // campo continente
FinRegistro

v: VACUNA
v.fecha_aplicacion.dia := 23
v.fecha_aplicacion.mes := 4
v.fecha_aplicacion.anio := 2021
```

---

## Patrones de uso


### 1) Carga de un registro (entrada de datos)

```pseudocode
ACCION CargarEstudiante ES
AMBIENTE
  est: ESTUDIANTE
PROCESO
  Esc("DNI:")          ; Leer(est.dni)
  Esc("Apellido:")     ; Leer(est.apellido)
  Esc("Nombre:")       ; Leer(est.nombre)
  Esc("Carrera:")      ; Leer(est.carrera)
  Esc("Año ingreso:")  ; Leer(est.ingreso)
  // A partir de aquí, 'est' está completo y listo para ser usado
FINACCION
```

### 2) Emisión (salida formateada)

```pseudocode

SUBACCION ImprimirEstudiante(e: ESTUDIANTE) ES
  Esc("[", e.dni, "] ", e.apellido, ", ", e.nombre, " - ", e.carrera, " (", e.ingreso, ")")
FINSUBACCION
```

### 3) Actualización de campos

```pseudocode
SUBACCION ActualizarIngreso(e: ESTUDIANTE; nuevo: N(4)) ES
  e.ingreso := nuevo
FINSUBACCION
```

### 4) Comparación por clave primaria

```pseudocode
FUNCION MismaPersona(a, b: ESTUDIANTE): logico
  devolver (a.dni = b.dni)
FINFUNCION
```

> En colecciones (listas, tablas, archivos), usá la **clave primaria** para búsquedas y detección de duplicados.

---

## Buenas prácticas

* **Definí primero el tipo** de registro en el *Ambiente* y luego declarás variables de ese tipo.
* Mantené **nombres claros** de campos y respetá **dominios** (rangos/enums) para validar consistencia.
* Considerá **clave primaria** desde el diseño: ¿qué campo(s) identifican sin ambigüedad?
* Tratá el registro como **unidad**: encapsulá emisiones, cargas y validaciones en subacciones.
* Para campos **continentales**, preferí tipos explícitos (como `FECHA`) en vez de tres enteros sueltos.

---

## Errores frecuentes

* **Omitir asignación de subcampos** en campos continentales (p. ej., setear `fecha` sin `día/mes/año`).
* **Duplicados** por ausencia de verificación de **clave primaria**.
* **Inconsistencias** de dominio (p. ej., `mes = 16`) por no validar rangos.

---

## Resumen

* Un **registro** modela una entidad con **varios campos** (posiblemente anidados).
* Se accede a los campos con un **selector** (`reg.campo`).
* Los **campos clave** son esenciales para identificación (primaria), relaciones (foránea) y acceso (secundaria).
* Diseñar tipos claros y validar dominios mejora la **consistencia** y facilita su posterior uso en **archivos** y **procesos**.

