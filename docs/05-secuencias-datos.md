# Secuencias de Datos Elementales

Esta página introduce el concepto de **secuencias de datos elementales**, sus características, clasificación y el **pseudocódigo estándar** para su tratamiento (acciones predefinidas `ARR`, `AVZ`, `CREAR`, `ESCRIBIR`, `CERRAR`).

---


## ¿Qué es una Secuencia de Datos Elementales?

Es un **conjunto de datos relacionados** que se almacena en **memoria externa** (disco, pendrive, etc.). La secuencia presenta orden y posee un **primer** y **último** elemento; además, debe estar definido un **indicador de fin de secuencia**.

---

## Características clave

* **Primer elemento**: desde él se accede al resto por sucesión.
* **Relación de sucesión**: cada elemento (salvo el último) precede a otro; cada elemento (salvo el primero) sucede a otro.
* **Último elemento**: toda secuencia tiene un final bien definido.

* **Fin de secuencia (FDS)**: puede ser una **marca** (sentinela) o una **cantidad conocida** de elementos.

**Ejemplos de FDS**


* Numérica con marca: `... 1990 1994 1992 2000 1998 -1` (termina en `-1`).
* Caracteres con marca: `A C 2 5 6 X E A F 3 2 5 B B %` (termina en `%`).
* Definida por cantidad: "primeros 4 promedios del año".

---

## Clasificaciones principales

### Por contenido


* **Numéricas** (enteros, reales)
* **De caracteres** (códigos, patentes, etc.)
* **De registros** (se verá en temas posteriores)

### Por cantidad de elementos

* **Definidas**: se conoce la cantidad (p. ej., 10 elementos).
* **Indefinidas**: no se conoce la cantidad; se usa marca o condición de fin.

### Por pureza

* **Puras**: todos los elementos pertenecen a la misma especie y el **último** se trata igual que los demás. Suelen manejarse con **post-test**.
* **Impuras**: incluyen un **elemento extraño** (marca) que no se procesa; se manejan con **pre-test**.

---

## Pseudocódigo: Acciones predefinidas

> Estas acciones aseguran el **acceso secuencial** correcto a los elementos.

* `ARR(nombre_secuencia)` → **Arrancar** el tratamiento de una secuencia existente.
* `AVZ(nombre_secuencia, var)` → **Avanzar** y recuperar el **siguiente elemento** en `var`.
* `CREAR(nombre_secuencia_salida)` → Inicializa una **nueva secuencia vacía** (solo para salida).
* `ESCRIBIR(nombre_secuencia_salida, var)` → Agrega `var` a la **secuencia de salida** creada.
* `CERRAR(nombre_secuencia)` → **Finaliza** el tratamiento de la secuencia (libera recursos / asegura persistencia).


### Declaración típica en el Ambiente


```pseudocode
ACCION Secu ES
AMBIENTE
   sec: Secuencia de [tipo_dato]
   sal: Secuencia de [tipo_dato]
   v:   [tipo_dato]
PROCESO
   // ...
FINACCION
```

---

## Esquemas de recorrido (patrones)

### Esquema Nº1 — Pre-test (impura con marca)

Cuenta elementos **antes** de tratar el FDS.


```pseudocode

ACCION esquema_1 ES
AMBIENTE
  S: secuencia de caracter
  v: caracter
  cont: entero
PROCESO
  ARR(S)
  cont := 0
  AVZ(S, v)
  Mientras v <> '#' Hacer
     cont := cont + 1
     AVZ(S, v)
  FinMientras
  ESC("Elementos en la secuencia = ", cont)
FINACCION

```

### Esquema Nº2 — Post-test (pura definida por marca final)

Procesa **incluyendo** el último elemento válido y **termina** al ver la marca.


```pseudocode
ACCION esquema_2 ES
AMBIENTE
  S: secuencia de entero
  v, cont: entero
PROCESO
  ARR(S)
  cont := 0
  Repetir
     AVZ(S, v)
     cont := cont + 1
  Hasta que v = 999
  ESCRIBIR(cont)
FINACCION
```

### Esquema Nº3 — Definida por cantidad (contador `PARA`)

Lee exactamente **N** elementos.

```pseudocode
ACCION esquema_3 ES
AMBIENTE
  S: secuencia de entero
  v, i: entero
PROCESO
  ARR(S)
  Para i := 1 Hasta 10 Hacer
     AVZ(S, v)
     ESC(v)
  FinPara
FINACCION
```

---

## Ejemplos prácticos de tratamiento

### Copiar de una secuencia a otra (indefinida impura)

```pseudocode
ACCION CopiarSecuencia ES
AMBIENTE
  ent: Secuencia de caracter
  sal: Secuencia de caracter
  x: caracter
PROCESO
  ARR(ent)
  CREAR(sal)
  AVZ(ent, x)
  Mientras x <> '%' Hacer
     ESCRIBIR(sal, x)
     AVZ(ent, x)
  FinMientras
  CERRAR(sal)
FINACCION
```

### Contar mayores que un umbral (definida por cantidad)

```pseudocode
ACCION ContarMayores ES
AMBIENTE

  ent: Secuencia de entero
  i, v, umbral, cuenta: entero
PROCESO
  ARR(ent)
  cuenta := 0
  umbral := 100
  Para i := 1 Hasta 20 Hacer
     AVZ(ent, v)
     Si v > umbral Entonces
        cuenta := cuenta + 1
     FinSi
  FinPara
  ESC("Mayores a ", umbral, ": ", cuenta)
FINACCION
```

---

## Buenas prácticas

* Elegí **pre-test** si trabajás con **marca** (impura) y el elemento de fin **no** debe procesarse.
* Elegí **post-test** en secuencias **puras** para asegurar al menos una lectura y tratar por igual el último.
* Declarar una variable de **trabajo** (buffer) para `AVZ` del **mismo tipo** que la secuencia.
* Recordá **cerrar** secuencias de salida (`CERRAR`) para garantizar persistencia.

---

## Resumen

* Las secuencias se recorren de forma **secuencial** con `ARR` y `AVZ`.
* El **fin de secuencia** es imprescindible (marca o cantidad).
* Usá el **esquema** que corresponda: *pre-test* (impura), *post-test* (pura) o *definida* (contador).
* `CREAR/ESCRIBIR/CERRAR` habilitan la **generación** de nuevas secuencias de salida.

