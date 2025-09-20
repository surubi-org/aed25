# Archivos

Esta página presenta el **modelo de archivos** aplicado a algoritmos: definición, organización física/lógica, modos de acceso y el **conjunto de sentencias de pseudocódigo** para abrir, leer, escribir y cerrar archivos. Se incluyen patrones de uso listos para reutilizar.


---

## Qué es un archivo

Un **archivo** es un conjunto **homogéneo de registros** relacionados entre sí y organizados para un propósito específico.

* Un **registro** está compuesto por **campos** (simples o compuestos).
* Los **archivos** se almacenan en **memoria externa** (disco, pendrive). Su **procesamiento** ocurre en **memoria interna**.


> Relación jerárquica: **Archivo → Registros → Campos**.

---

## Organización de archivos (física/lógica)

### Secuencial

Registros almacenados **consecutivamente**. Para acceder al registro *n*, es necesario pasar por los *n−1* anteriores.

### Relativa (directa)

El **orden físico** no coincide necesariamente con el **orden lógico**; el acceso se realiza por **posición** (relativa) o por una **función de direccionamiento**.

### Indexada

Existen **dos áreas**:


* **Área de datos (primaria)**: registros organizados secuencialmente por **clave**.
* **Área de índices**: estructura auxiliar (tabla de índices) que permite **localizar** rápidamente por **clave**.

---

## Modos de acceso

* **Secuencial**: lectura en orden (desde el primero hasta el último).
* **Directo**: salta a una posición/clave específica.
* **Mixto**: combinación (p. ej., ubicar por clave y luego leer secuencialmente a partir de allí).

---

## Tipos de datos de apoyo (útil en definiciones)

* **Tipo conjunto (enumerado)**

  ```pseudocode
  Vocal = ('a','e','i','o','u')
  Estado = ('Libre','Ocupado')
  ```
* **Tipo rango**

  ```pseudocode
  Mes  = 1..12
  Edad = 0..110
  ```

Estos tipos facilitan **validar dominios** al definir **campos** de un **registro**.


---

## Sentencias de gestión de archivos (pseudocódigo)

> Convención: `Arch` es un **archivo**; `Reg` es una **variable registro** del **formato** del archivo.

* **Abrir archivo**

  ```pseudocode
  ABRIR E/(Arch)   // modo Entrada (solo lectura)
  ABRIR /S(Arch)   // modo Salida  (solo escritura)

  ```

* **Leer y detectar fin**

  ```pseudocode
  LEER(Arch, Reg)      // trae el siguiente registro a 'Reg'
  FDA(Arch)            // Fin De Archivo: verdadero si se llegó al final
  NFDA(Arch)           // No Fin De Archivo: equivalente a NOT FDA(Arch)
  ```

* **Escribir y cerrar**

  ```pseudocode
  ESCRIBIR(Arch, Reg)  // agrega/graba 'Reg' en el archivo (modo Salida)
  CERRAR(Arch)
  ```

> Nota: algunos modelos didácticos usan **`FDA`**; otros proveen **`NFDA`**. Elegí uno y sé consistente (o definí `NFDA(Arch) := NO FDA(Arch)`).

---


## Definiciones en el *Ambiente*

```pseudocode
// 1) Formato del registro
aRegistro = Registro
  url: AN(120)
  fecha_pico: Registro
      anio: 2000..2100
      mes: 1..12
      dia: 1..31
    FinRegistro
  reproducciones: N(9)
FinRegistro

// 2) Variables
datos: Archivo de aRegistro ordenado por url      // ejemplo
ing:  aRegistro
```

---

## Patrones de uso (snippets reutilizables)

### 1) Emisión (listado simple)

Recorre un archivo **de entrada** y emite sus campos.

```pseudocode
ACCION Listar ES
AMBIENTE
  Arch: Archivo de aRegistro
  Reg:  aRegistro
PROCESO
  ABRIR E/(Arch)
  LEER(Arch, Reg)
  Mientras NFDA(Arch) Hacer
     Esc(Reg.url, ' ', Reg.fecha_pico.dia, '/', Reg.fecha_pico.mes, '/', Reg.fecha_pico.anio,
         ' ', Reg.reproducciones)
     LEER(Arch, Reg)
  FinMientras
  CERRAR(Arch)
FINACCION
```

### 2) Carga/Generación (crear archivo consistente)

Crea un archivo nuevo y graba registros ingresados por teclado.

```pseudocode
ACCION Cargar ES
AMBIENTE
  Nuevo: Archivo de aRegistro ordenado por url
  Reg:   aRegistro
  cont:  entero
PROCESO
  ABRIR /S(Nuevo)
  cont := 1
  Mientras cont <= 100 Hacer
     Esc('Ingrese url, fecha pico (d m a) y reproducciones:')
     Leer(Reg.url)
     Leer(Reg.fecha_pico.dia)
     Leer(Reg.fecha_pico.mes)
     Leer(Reg.fecha_pico.anio)
     Leer(Reg.reproducciones)
     ESCRIBIR(Nuevo, Reg)
     cont := cont + 1
  FinMientras
  CERRAR(Nuevo)
FINACCION
```

### 3) Filtro (generación a partir de entrada)

Lee un archivo de **entrada** y escribe en **salida** según una condición.

```pseudocode
ACCION FiltrarPorFecha ES
AMBIENTE
  In:  Archivo de aRegistro
  Out: Archivo de aRegistro
  R:   aRegistro
PROCESO
  ABRIR E/(In)
  ABRIR /S(Out)
  LEER(In, R)
  Mientras NFDA(In) Hacer
     Si (R.fecha_pico.mes = 5) y (R.fecha_pico.dia = 1) Entonces
        ESCRIBIR(Out, R)
     FinSi
     LEER(In, R)
  FinMientras
  CERRAR(In)
  CERRAR(Out)

FINACCION
```

### 4) Transformación a múltiples salidas

Desvía los registros a dos archivos distintos.

```pseudocode
ACCION Particionar ES
AMBIENTE
  In:    Archivo de aRegistro
  Top:   Archivo de aRegistro
  Resto: Archivo de aRegistro
  R: aRegistro
PROCESO
  ABRIR E/(In)
  ABRIR /S(Top)
  ABRIR /S(Resto)
  LEER(In, R)
  Mientras NFDA(In) Hacer
     Si R.reproducciones >= 100000 Entonces
        ESCRIBIR(Top, R)
     Contrario
        ESCRIBIR(Resto, R)
     FinSi
     LEER(In, R)
  FinMientras
  CERRAR(In)
  CERRAR(Top)
  CERRAR(Resto)
FINACCION
```

---

## Buenas prácticas

* **Definí claramente** el **formato** de registro y los **dominios** (rangos/enums) de cada campo.

* Generá archivos **consistentes** (campos en rango, tipos correctos, claves únicas si aplica).
* En emisión/listados, **separá** *lectura*, *tratamiento* y *salida* para mayor claridad.
* Cerrá siempre archivos con `CERRAR` para liberar recursos y **persistir** cambios.
* Elegí el **modo de organización** acorde: *secuencial* (recorridos completos), *relativa* (acceso por posición), *indexada* (búsqueda por clave).

---


## Resumen

* Un **archivo** agrupa **registros** homogéneos y reside en **memoria externa**.
* La **organización** define cómo se guardan (secuencial/relativa/indexada) y el **acceso** cómo se leen (secuencial/directo/mixto).
* Con `ABRIR`, `LEER`/`ESCRIBIR`, `FDA`/`NFDA` y `CERRAR` podés implementar **emisión**, **carga**, **filtros** y **transformaciones**.

