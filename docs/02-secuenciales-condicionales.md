# Estructuras Secuenciales y Condicionales

Este documento presenta las **estructuras de control secuenciales y condicionales**, con teoría, ejemplos y pseudocódigo. El estilo sigue la estructura de documentación técnica inspirada en la MDN.

---

## Estructuras de Control

Las **estructuras de control** determinan el orden en el que se ejecutan las instrucciones de un algoritmo.


Características:


* Cada estructura tiene un único **punto de entrada** y un único **punto de salida**.
* Puede estar formada por **sentencias** o por otras estructuras de control【25†source】.

---

## Estructuras Secuenciales

La ejecución comienza con la primera instrucción del algoritmo y continúa en orden hasta la última.

Cada sentencia se ejecuta **una sola vez**【25†source】.

### Ejemplo: cálculo de porcentaje

**Problema:** Dado un importe, obtener su 10%.

```pseudocode
Accion Porcentaje Es
Ambiente

   importe: numerico
Proceso
   Esc("Ingrese importe")
   Leer(importe)
   Esc("El 10% es", 10*importe/100)
Fin Accion

```

---

## Estructuras Condicionales


Cuando es necesario **tomar decisiones** en un algoritmo, se utilizan estructuras condicionales. Se basan en la evaluación de una **expresión lógica**【25†source】.

### Tipos de condicionales

1. **Simple**: una sola acción si se cumple la condición.

2. **Alternativa (doble)**: una acción si se cumple, otra si no.
3. **Múltiple**: varias alternativas según el valor de una expresión.

---

### Condicional Simple

Ejecuta una serie de instrucciones solo si la condición es verdadera.

```pseudocode
Si condicion_se_cumple Entonces
   accion_1
   accion_2
FinSi
```

**Ejemplo:** Verificar si un número es positivo.

```pseudocode
Accion EjemploCS Es
Ambiente
   x: numerico
Proceso
   Esc("Ingrese un valor")
   Leer(x)
   Si x > 0 Entonces
      Esc("El número es positivo")
   FinSi
Fin Accion
```

---


### Condicional Alternativa

Permite ejecutar un bloque si la condición se cumple, y otro bloque si no se cumple.

```pseudocode
Si condicion Entonces
   acciones_si
Contrario
   acciones_no
FinSi
```

**Ejemplo:** Comparar dos números.

```pseudocode
Accion MayorMenor Es
Ambiente
   a, b: numerico
Proceso
   Esc("Ingrese primer número")
   Leer(a)
   Esc("Ingrese segundo número")
   Leer(b)
   Si a > b Entonces
      Esc("El primero es mayor")
   Contrario
      Esc("El segundo es mayor o igual")
   FinSi
Fin Accion
```

---


### Condicional Múltiple


Permite elegir entre varias alternativas según el valor de una variable o expresión.

```pseudocode
Segun variable Hacer
   valor1: acciones_1
   valor2: acciones_2
   Otro: acciones_defecto
FinSegun
```

**Ejemplo:** Determinar la estación del año a partir de un número de mes.

```pseudocode
Accion Estacion Es
Ambiente
   mes: entero
Proceso
   Esc("Ingrese un número de mes")
   Leer(mes)
   Segun mes Hacer
      12,1,2: Esc("Verano")
      3,4,5: Esc("Otoño")
      6,7,8: Esc("Invierno")
      9,10,11: Esc("Primavera")
      Otro: Esc("Mes inválido")
   FinSegun
Fin Accion
```

---

## Resumen

* **Secuenciales**: todas las instrucciones se ejecutan en orden.
* **Condicionales simples**: ejecutan acciones solo si la condición es verdadera.
* **Condicionales alternativas**: permiten un camino u otro.
* **Condicionales múltiples**: seleccionan entre varias opciones.

Estas estructuras son la base para controlar el flujo de cualquier algoritmo.

