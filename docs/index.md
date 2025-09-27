# Introducción

Supongo que el mundo de los algorítmos es grande y maravilloso... lo que también es grande y maravillosa es la fiaca que da estudiar. Con esto te debe quedar en claro que no soy el mejor estudiante, pero bueno, lo importante es que me quiero poner al día y esta página será clave en el susodicho proceso. Quedo con la idea de vomitar toda la teoría básica en este archivo, para que podamos luego avanzar en los temas.

---

## Definición de Algoritmo

Es una secuencia finita de instrucciones, reglas o pasos que describen de modo preciso las operaciones que una computadora debe realizar para ejecutar una tarea en un tiempo finito.

### Características

Un buen algoritmo debe ser:

* **Preciso**: cada paso debe estar claramente definido.
* **Correcto**: debe resolver el problema planteado.
* **Definido**: el mismo conjunto de datos de entrada debe producir siempre la misma salida.
* **Finito**: debe terminar en algún momento.
* **independiente**: de la máquina que lo ejecuta.

### Elementos

Los algoritmos están compuestos por tres elementos principales:

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
* **Lógicos (booleanos)**: sólo pueden tomar dos valores (Verdadero/Falso). Ejemplo: estado de un semáforo.

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

Una **acción** es un acontecimiento que ocurre en un tiempo finito y produce un cambio de estado.

### Tipos de acciones

* **Asignación**: asignar un valor a una variable.
* **Condicionales**: tomar decisiones según una condición.
* **Repetitivas**: ejecutar un bloque varias veces.
* **Con nombre**: agrupaciones de instrucciones (subacciones, funciones, procedimientos).

---

## Asignación

La **asignación** reemplaza el valor anterior de una variable por un nuevo valor. Es una acción destructiva, ya que se pierde el valor previo.

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

