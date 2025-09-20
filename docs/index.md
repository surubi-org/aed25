# Introducción a los Algoritmos

Este documento presenta los conceptos fundamentales sobre **algoritmos**, sus características, elementos principales y la clasificación de datos. La estructura y estilo sigue el enfoque de documentación técnica de la [MDN Web Docs](https://developer.mozilla.org/).

---

## ¿Qué es un Algoritmo?

Un **algoritmo** es una secuencia finita de instrucciones, reglas o pasos que describen de modo preciso las operaciones que una computadora debe realizar para ejecutar una tarea en un tiempo finito【24†source】.

**Ejemplos de algoritmos en la vida real:**

* Determinar en qué horario se realizan más publicaciones en enero.
* Calcular cuántas personas están en espera en determinado horario.
* Generar un ranking de los 5 países con más consultas【24†source】.

---

## Características de un Algoritmo

Un buen algoritmo debe ser:

* **Preciso**: cada paso debe estar claramente definido.

* **Correcto**: debe resolver el problema planteado.
* **Definido**: el mismo conjunto de datos de entrada debe producir siempre la misma salida.
* **Finito**: debe terminar en algún momento【24†source】.

---

## Elementos de un Algoritmo

Los algoritmos están compuestos por tres elementos principales【24†source】:

1. **Datos**

   * Información de entrada o salida.
   * Se clasifican en distintos tipos.

2. **Acciones**


   * Operaciones que transforman los datos.

3. **Operadores**

   * Elementos que permiten construir expresiones o condiciones.

---


## Tipos de Datos

Los **datos** representan información utilizada por los algoritmos. Se dividen en:

### Simples

* **Numéricos**: representan cantidades o valores (ej: edad, salario).
* **Alfanuméricos**: representan texto (ej: nombre, apellido). No se pueden operar matemáticamente.
* **Lógicos (booleanos)**: sólo pueden tomar dos valores (Verdadero/Falso). Ejemplo: estado de un semáforo【24†source】.

### Estructurados

* Conjuntos de datos simples agrupados.
* Se verán más adelante (registros, secuencias, archivos).

---

## Variables y Constantes


### Variables

Representan una dirección de memoria que **puede cambiar durante la ejecución** del algoritmo.

```pseudocode
// Ejemplo de variables
stock := 50
cantidad_estudiantes := 32
```

### Constantes

Representan una dirección de memoria cuyo contenido **no cambia durante la ejecución**.

```pseudocode
// Ejemplo de constantes
IVA := 0.21
PI := 3.14159
```

---

## Acciones

Una **acción** es un acontecimiento que ocurre en un tiempo finito y produce un cambio de estado【24†source】.

### Tipos de acciones

* **Asignación**: asignar un valor a una variable.
* **Condicionales**: tomar decisiones según una condición.
* **Repetitivas**: ejecutar un bloque varias veces.
* **Con nombre**: agrupaciones de instrucciones (subacciones, funciones, procedimientos).

---

## Asignación

La **asignación** reemplaza el valor anterior de una variable por un nuevo valor. Es una acción destructiva, ya que se pierde el valor previo【24†source】.

### Ejemplo: Asignación Pura

```pseudocode
// Ejemplo de semáforo
semaforo := "Rojo"
semaforo := "Verde"
semaforo := "Amarillo"
```

### Ejemplo: Asignación de Expresión Algebraica

```pseudocode
descuento := importe / 2
```

### Ejemplo: Asignación de Función

```pseudocode
examen := REDOND(puntaje)
```

### Ejemplo: Contadores y Acumuladores

```pseudocode
billetes := billetes + 1   // contador
dinero := dinero + billete // acumulador
```

