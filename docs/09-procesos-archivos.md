# Procesos con Archivos

En esta página se sistematizan los **procesos sobre archivos**: validaciones de calidad de datos, procesos **individuales** y **múltiples**, más **patrones de pseudocódigo** listos para reutilizar. Estilo de documentación: conciso, con ejemplos ejecutables en pseudocódigo.

---

## Calidad de datos en archivos

Antes de procesar, verificá **consistencia** y **congruencia** de los registros.

* **Consistencia**: cada campo respeta su **formato** y **dominio** (rango o conjunto permitido).

  * Ej.: `FECHA = {anio: 2000..2100, mes: 1..12, dia: 1..31}`.
* **Congruencia**: la combinación de campos es **válida entre sí**.

  * Ej.: `31/02/2024` es **incongruente** aunque cada campo, por separado, tiene números válidos.

### Tipos de validación

* **Gruesa (intra‑registro)**: entre campos del **mismo** registro (p. ej., *fecha válida del calendario*).
* **Fina (inter‑archivo)**: entre campos de **archivos distintos** (p. ej., DNI en `Comisiones` existe en `Legajos`).

#### Snippet: validación de fecha

```pseudocode
FUNCION FechaValida(f: FECHA): logico
    devolver (2000 <= f.anio <= 2100) y (1 <= f.mes <= 12) y (1 <= f.dia <= 31) y
            ((f.mes en {1,3,5,7,8,10,12} y f.dia <= 31) o
             (f.mes en {4,6,9,11}          y f.dia <= 30) o
             (f.mes = 2                    y f.dia <= 29)) // simple: admite 29 sin chequear bisiesto
FINFUNCION
```

---

## ¿Qué es un proceso?

Conjunto de **operaciones** que transforman **datos de entrada** (archivos) en **resultados** (salidas/archivos/listados). Al diseñar, definí:

1. **Entradas** (fuentes, orden, claves)
2. **Transformaciones** (reglas, acumulaciones, cortes)
3. **Salidas** (listados, padrones, archivos generados)

---

## Clasificación general

### Procesos **individuales**

Un solo **archivo de entrada** y 0 o 1 **archivo de salida**.

**Tipos frecuentes**

* **Carga/Generación** (crear archivo consistente)
* **Emisión/Listador** (salida impresa)
* **Padrón** (listador + totales **finales**)
* **Corte de control** (padrones con **totales parciales**; ver página *10‑corte‑control*)
* **Estadísticos** (contabilizar por categorías con tabla de frecuencias)


### Procesos **múltiples**


Varios archivos de entrada y/o salida.

**Tipos frecuentes**

* **Apareo (merge)** de archivos **ordenados** por la misma clave
* **Intersección/Unión/Diferencia** entre archivos ordenados
* **Maestro–Detalle** (actualizaciones)
* **Generación transformadora** (split/partition a múltiples salidas)

---

## Patrones de procesos **individuales**

### 1) Carga (generación de archivo)

```pseudocode
ACCION Carga ES
AMBIENTE
  TIPO REG = Registro
      clave: AN(13)
      fecha: FECHA
      valor: N(9)
  FinRegistro
  Nuevo: Archivo de REG ordenado por clave
  R: REG
  i: entero
PROCESO
  ABRIR /S(Nuevo)
  Para i := 1 Hasta 100 Hacer
      Esc("clave, dia, mes, anio, valor:")
      Leer(R.clave); Leer(R.fecha.dia); Leer(R.fecha.mes); Leer(R.fecha.anio); Leer(R.valor)
      Si FechaValida(R.fecha) Entonces
          ESCRIBIR(Nuevo, R)
      FinSi
  FinPara
  CERRAR(Nuevo)
FINACCION
```

### 2) Emisión / Listador

```pseudocode
ACCION Listar ES
AMBIENTE
  A: Archivo de REG
  R: REG
PROCESO
  ABRIR E/(A)
  LEER(A, R)
  Mientras NFDA(A) Hacer
     Esc(R.clave, R.fecha.dia, '/', R.fecha.mes, '/', R.fecha.anio, R.valor)
     LEER(A, R)
  FinMientras
  CERRAR(A)
FINACCION
```

### 3) Padrón (totales finales)

```pseudocode
ACCION Padron ES
AMBIENTE
  A: Archivo de REG ordenado por clave
  R: REG
  total: entero
PROCESO
  total := 0
  ABRIR E/(A)
  LEER(A, R)
  Mientras NFDA(A) Hacer
     Esc(R.clave, R.valor)
     total := total + 1
     LEER(A, R)
  FinMientras
  Esc("Total de registros:", total)
  CERRAR(A)
FINACCION
```

### 4) Estadístico con tabla de frecuencias

```pseudocode
ACCION EstadisticoPorMes ES
AMBIENTE
  A: Archivo de REG
  R: REG
  freq: arreglo[1..12] de entero
  m: entero
PROCESO
  Para m := 1 Hasta 12 Hacer freq[m] := 0 FinPara
  ABRIR E/(A); LEER(A, R)
  Mientras NFDA(A) Hacer
      freq[R.fecha.mes] := freq[R.fecha.mes] + 1
      LEER(A, R)
  FinMientras; CERRAR(A)
  Para m := 1 Hasta 12 Hacer Esc("Mes", m, ":", freq[m]) FinPara
FINACCION
```

> **Corte de control** se desarrolla con detalle en *10‑corte‑control.md* (totales por **niveles de clave**).

---


## Patrones de procesos **múltiples**

### 5) Apareo (merge) de dos archivos ordenados por la misma clave

Combina `A` y `B` (ambos **ordenados**) en `C`.

```pseudocode

ACCION Apareo ES
AMBIENTE
  A, B, C: Archivo de REG // todos ordenados por 'clave'
  RA, RB: REG
PROCESO
  ABRIR E/(A); ABRIR E/(B); ABRIR /S(C)
  LEER(A, RA); LEER(B, RB)
  Mientras NFDA(A) y NFDA(B) Hacer
    Si RA.clave < RB.clave Entonces
        ESCRIBIR(C, RA); LEER(A, RA)
    Sino Si RB.clave < RA.clave Entonces
        ESCRIBIR(C, RB); LEER(B, RB)
    Sino // claves iguales → decidir política (p.ej., preferir A)
        ESCRIBIR(C, RA); LEER(A, RA); LEER(B, RB)
    FinSi
  FinMientras
  // arrastre
  Mientras NFDA(A) Hacer ESCRIBIR(C, RA); LEER(A, RA) FinMientras
  Mientras NFDA(B) Hacer ESCRIBIR(C, RB); LEER(B, RB) FinMientras
  CERRAR(A); CERRAR(B); CERRAR(C)
FINACCION
```

### 6) Intersección (claves comunes) de dos archivos ordenados

```pseudocode
ACCION Interseccion ES
AMBIENTE
  A, B, C: Archivo de REG // C = comunes
  RA, RB: REG
PROCESO
  ABRIR E/(A); ABRIR E/(B); ABRIR /S(C)
  LEER(A, RA); LEER(B, RB)
  Mientras NFDA(A) y NFDA(B) Hacer
     Si RA.clave = RB.clave Entonces
        ESCRIBIR(C, RA)
        LEER(A, RA); LEER(B, RB)
     Sino Si RA.clave < RB.clave Entonces
        LEER(A, RA)
     Sino
        LEER(B, RB)
     FinSi
  FinMientras
  CERRAR(A); CERRAR(B); CERRAR(C)
FINACCION
```

### 7) Maestro–Detalle (actualización)

Actualiza `Maestro` con movimientos de `Detalle` (ambos **ordenados por clave**).

```pseudocode
ACCION MaestroDetalle ES
AMBIENTE
  Maestro: Archivo de REG
  Detalle: Archivo de RegistroMov // {clave, delta}
  Salida:  Archivo de REG
  RM: REG; RD: RegistroMov
PROCESO
  ABRIR E/(Maestro); ABRIR E/(Detalle); ABRIR /S(Salida)

  LEER(Maestro, RM); LEER(Detalle, RD)
  Mientras NFDA(Maestro) Hacer
     Mientras NFDA(Detalle) y RD.clave < RM.clave Hacer LEER(Detalle, RD) FinMientras
     Mientras NFDA(Detalle) y RD.clave = RM.clave Hacer
         RM.valor := RM.valor + RD.delta

         LEER(Detalle, RD)
     FinMientras
     ESCRIBIR(Salida, RM)
     LEER(Maestro, RM)
  FinMientras
  CERRAR(Maestro); CERRAR(Detalle); CERRAR(Salida)
FINACCION
```

> Variantes: **Unión** (todos los de A y B), **Diferencia** (de A no presentes en B), **Join** por clave compuesta.

---

## Buenas prácticas

* **Precondiciones**: exigí **orden** por clave y definí **política** para claves duplicadas.
* **Lectura anticipada** + bucles con `NFDA` evitan leer **fuera de rango**.
* **Separá responsabilidades**: leer → tratar → emitir.
* Para estadísticas, elegí estructuras internas (vectores/tablas) con dominios **acotados**.
* Documentá **invariantes** (p. ej., “A y B están ordenados por `clave`”).

---

## Resumen

* Distinguí **procesos individuales** (carga, emisión, padrón, estadístico, corte de control) y **múltiples** (apareo, intersección, maestro–detalle).
* Asegurá **consistencia** y **congruencia** antes de procesar.
* Los **patrones** de esta página cubren los casos más comunes y son base para diseños más complejos (balanceos, consolidaciones, joins).

