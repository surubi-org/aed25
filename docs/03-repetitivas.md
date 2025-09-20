# Estructuras Repetitivas

Este documento explica las **estructuras repetitivas** (o ciclos), junto con los recursos básicos necesarios: **contadores, acumuladores y banderas**. Se incluyen ejemplos de pseudocódigo siguiendo el estilo de documentación técnica inspirada en MDN.


---

## Recursos Fundamentales

### Contadores

Son variables que llevan la cuenta de cuántas veces ocurre un evento. Se incrementan o decrementan en valores constantes.


```pseudocode
contador := contador + 1
```

**Ejemplo:** Sensor de aforo que incrementa cada vez que entra una persona.

---

### Acumuladores

Son variables que suman cantidades variables (no constantes). Sirven para almacenar totales.

```pseudocode
acumula := acumula + valor
```

**Ejemplo:** Robot que acumula kilos de basura espacial recolectados.

---

### Banderas

Son variables lógicas (booleanas) que indican si ocurrió o no un evento.

```pseudocode
bandera := V   // verdadero
bandera := F   // falso
```

**Ejemplo:** Encender o apagar luces según el horario configurado (7PM a 6AM).

---

## Concepto de Iteración

La **iteración** es la repetición de un conjunto de acciones bajo ciertas condiciones. Cada vuelta del ciclo se denomina **bucle**【16†source】.


---

## Clasificación de Ciclos

1. **Definidos**: sabemos de antemano cuántas veces se repite.

   * Ejemplo: ejecutar una acción 10 veces.
2. **Indefinidos**: no sabemos la cantidad exacta de repeticiones.

   * Ejemplo: pedir números hasta que se ingrese un valor negativo.

Los ciclos también se clasifican en **Pre-Test** y **Post-Test** según el momento en que se evalúa la condición【16†source】.

---

## Ciclo Pre-Test

La condición se evalúa **antes** de ejecutar el bloque. Puede repetirse 0 o más veces.

```pseudocode
total := 0
Esc("Ingrese primer número")
Leer(num)

Mientras num >= 0 Hacer
   total := total + num
   Esc("Ingrese otro número")
   Leer(num)
FinMientras

Esc("La suma total es", total)
```

**Ejemplo real:** sumar los números ingresados en un juego hasta que el usuario escriba un valor negativo.

---

## Ciclo Post-Test

La condición se evalúa **después** de ejecutar el bloque. Garantiza al menos una ejecución.

```pseudocode
clavecorrecta := 123
Repetir
   Esc("Introduce la clave")
   Leer(intento)
Hasta que intento = clavecorrecta
```

**Ejemplo real:** pedir una contraseña hasta que coincida con la correcta.

---

## Ciclo Definido por Contador

Se utiliza cuando se conoce de antemano la cantidad de repeticiones. Generalmente implementado con **PARA**.

```pseudocode
Para i := 1 Hasta 5 Hacer
   Esc("Iteración número", i)
FinPara
```

**Ejemplo real:** mostrar un mensaje 5 veces.

---

## Resumen

* **Contadores, acumuladores y banderas** son recursos básicos para construir algoritmos repetitivos.
* **Pre-Test**: condición antes del bloque (0 o más repeticiones).

* **Post-Test**: condición después del bloque (1 o más repeticiones).
* **Definidos por contador**: número de repeticiones conocidas de antemano.

Estas estructuras son esenciales para automatizar procesos donde la repetición es necesaria.

