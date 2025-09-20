# Subsecuencias

En esta página se presentan los fundamentos de **subsecuencias** dentro de **secuencias de datos elementales**, su clasificación (*enlazadas* y *jerárquicas*), criterios de inicio/fin y patrones de tratamiento con pseudocódigo.


---

## Ideas clave

* Una **secuencia** es un conjunto homogéneo y ordenado de elementos.
* Una **subsecuencia** es un **conjunto de elementos consecutivos** dentro de una secuencia principal, definido por **reglas de inicio y fin**.
* Las subsecuencias **heredan** las propiedades de la secuencia de la que forman parte (orden, fin, homogeneidad del tipo de dato, etc.).

---

## Definiciones frecuentes

### Subsecuencia *PALABRA*

Subconjunto de elementos **consecutivos** de una **secuencia de caracteres** que:

* **empieza** en un carácter **distinto de espacio** (`' '`), y
* **termina** en un **espacio** o en una **marca** definida por el problema (p. ej., final de palabra, fin de secuencia, etc.).


### Subsecuencia *ORACIÓN*

Subconjunto de elementos **consecutivos** de una **secuencia de caracteres** que:

* **empieza** en un carácter **distinto de espacio** (`' '`), y
* **termina** en un delimitador **final de oración** (p. ej., `'.'`) u otra marca especificada.

> **Palabra con contenido**: cadena de **caracteres no blancos** que finaliza en `'.'` o en **blanco**.
>
> **Palabra vacía**: cadena de **blancos consecutivos** que finaliza en un carácter **no blanco**.

---

## Tipos de relación entre subsecuencias

### 1) Subsecuencias *enlazadas*

* Las subsecuencias **se encadenan** una detrás de otra.
* Al **terminar** una subsecuencia, **comienza** la siguiente.
* Ejemplo clásico: secuencia de caracteres que almacena **códigos de 4 dígitos** en serie (`1 3 2 5  4 8 9 0  ...`). Cada bloque de 4 conforma **una subsecuencia**.

### 2) Subsecuencias *jerárquicas*

* Las subsecuencias se **incluyen** unas en otras por **niveles**.
* No hay continuidad obligatoria entre subsecuencias del mismo nivel.
* Ejemplo clásico: **Texto → Párrafos → Oraciones → Palabras**.

---


## Patrones de tratamiento

A continuación se muestran **esquemas de recorrido** reutilizables. Se asume el conjunto de acciones para secuencias: `ARR`, `AVZ`, `CREAR`, `ESCRIBIR`, `CERRAR`.

> **Convención**: `S` es una **secuencia de caracteres** y `c` una variable **carácter**.

### A. Palabras en texto (pre-test sobre blancos)

Ignora **palabras vacías** (múltiples espacios). Cuenta **palabras con contenido**.


```pseudocode

ACCION ContarPalabras ES
AMBIENTE

  S: Secuencia de caracter
  c: caracter
  en_palabra: logico
  total: entero
PROCESO
  ARR(S)
  AVZ(S, c)
  en_palabra := F
  total := 0
  Mientras c <> '#' Hacer           // '#' = fin de secuencia (ejemplo de marca)
    Si c <> ' ' y no en_palabra Entonces
      en_palabra := V               // inicia palabra con contenido
      total := total + 1
    FinSi
    Si c = ' ' y en_palabra Entonces
      en_palabra := F               // cerró la palabra al ver blanco
    FinSi
    AVZ(S, c)
  FinMientras
  ESC("Palabras con contenido:", total)
FINACCION
```

### B. Longitud máxima de palabra

Registra la longitud de la **palabra más larga**.

```pseudocode
ACCION LongitudMaxPalabra ES
AMBIENTE
  S: Secuencia de caracter
  c: caracter
  en_palabra: logico
  long_act, long_max: entero
PROCESO
  ARR(S)
  AVZ(S, c)
  en_palabra := F
  long_act := 0
  long_max := 0
  Mientras c <> '#' Hacer
    Si c <> ' ' Entonces
      Si no en_palabra Entonces
        en_palabra := V
        long_act := 0
      FinSi
      long_act := long_act + 1
    Contrario
      Si en_palabra Entonces
        en_palabra := F
        Si long_act > long_max Entonces
          long_max := long_act
        FinSi
      FinSi
    FinSi
    AVZ(S, c)
  FinMientras
  // cierre si terminó sin blanco final
  Si en_palabra y long_act > long_max Entonces
     long_max := long_act
  FinSi
  ESC("Longitud máxima:", long_max)
FINACCION
```

### C. Oraciones en texto (delimitador '.')

Cuenta cuántas **oraciones** hay en el texto.

```pseudocode
ACCION ContarOraciones ES
AMBIENTE
  S: Secuencia de caracter
  c: caracter
  en_contenido: logico
  oraciones: entero
PROCESO
  ARR(S)
  AVZ(S, c)
  en_contenido := F
  oraciones := 0

  Mientras c <> '#' Hacer
    Si c <> ' ' y c <> '.' Entonces
      en_contenido := V
    FinSi
    Si c = '.' y en_contenido Entonces
      oraciones := oraciones + 1    // cierre de oración con contenido
      en_contenido := F
    FinSi
    AVZ(S, c)
  FinMientras
  ESC("Cantidad de oraciones:", oraciones)
FINACCION
```

---

## Subsecuencias enlazadas (bloques de tamaño fijo)

### D. Contar dígitos '0' en códigos de 4 caracteres

Suponga `S` contiene **códigos de 4 caracteres** consecutivos; por cada bloque (subsecuencia) contar los ceros y acumular total general.

```pseudocode
ACCION CerosEnCodigos4 ES
AMBIENTE
  S: Secuencia de caracter
  c: caracter
  i, ceros_cod, ceros_total: entero
PROCESO
  ARR(S)

  ceros_total := 0
  Repetir
    ceros_cod := 0
    Para i := 1 Hasta 4 Hacer
      AVZ(S, c)
      Si c = '#' Entonces         // marca: fin de secuencia
         // fin abrupto: salir de la rutina
         ESC("Total ceros:", ceros_total)
         regresar
      FinSi
      Si c = '0' Entonces
         ceros_cod := ceros_cod + 1
      FinSi
    FinPara
    // tratar el bloque completo
    ESC("Ceros en código:", ceros_cod)
    ceros_total := ceros_total + ceros_cod
  Hasta que falso                   // continúa hasta ver '#'
FINACCION
```

> Si preferís un fin **controlado**, reemplazá la condición de corte por lectura anticipada del primer carácter del bloque y verificá `'#'` antes de entrar al `Para`.

---

## Subsecuencias jerárquicas (anidadas)

### E. Texto → Oraciones → Palabras: promedio de longitud de palabra por oración


Calcula, por cada **oración**, el **promedio** de longitudes de sus **palabras con contenido**; al final emite el **promedio global**.

```pseudocode
ACCION PromedioLongitudesPorOracion ES
AMBIENTE
  S: Secuencia de caracter
  c: caracter
  // nivel palabra
  en_pal: logico
  long_pal: entero
  // nivel oración
  suma_long, cant_pal, cant_orac: entero
  prom_orac, prom_global: real
PROCESO

  ARR(S)
  AVZ(S, c)
  // inicializaciones
  en_pal := F
  long_pal := 0
  suma_long := 0
  cant_pal := 0
  cant_orac := 0
  Mientras c <> '#' Hacer                      // recorre texto completo
    // nivel palabra
    Si c <> ' ' y c <> '.' Entonces
      Si no en_pal Entonces
        en_pal := V
        long_pal := 0
      FinSi
      long_pal := long_pal + 1
    Contrario
      // cerró palabra por espacio o punto
      Si en_pal Entonces
        en_pal := F
        cant_pal := cant_pal + 1
        suma_long := suma_long + long_pal
      FinSi
      // si es punto, cierra oración
      Si c = '.' Entonces
        cant_orac := cant_orac + 1
        Si cant_pal > 0 Entonces

          prom_orac := suma_long / cant_pal
          ESC("Promedio en oración ", cant_orac, ": ", prom_orac)
        Contrario
          ESC("Oración ", cant_orac, " sin palabras" )
        FinSi
        // reset para nueva oración
        suma_long := 0
        cant_pal := 0
      FinSi
    FinSi
    AVZ(S, c)
  FinMientras
  // cierre por fin sin punto final
  Si en_pal Entonces
    cant_pal := cant_pal + 1
    suma_long := suma_long + long_pal
  FinSi
  Si cant_pal > 0 Entonces
    cant_orac := cant_orac + 1
    prom_orac := suma_long / cant_pal
    ESC("Promedio en oración ", cant_orac, ": ", prom_orac)

  FinSi
  // promedio global (si se requiere)
  // (podría promediar los promedios por oración o sobre todas las palabras del texto)
FINACCION
```

---


## Buenas prácticas y chequeos

* **Definí claramente** los delimitadores de **inicio** y **fin** (espacio, punto, marca `'#'`, tamaño fijo, etc.).
* **Normalizá casos de borde**: múltiples espacios, texto que **no termina** en delimitador, secuencias vacías.
* En encadenadas de tamaño fijo, **validá longitud** (evitá bloques incompletos).
* Mantené **estado mínimo**: banderas `en_palabra` / `en_contenido`, contadores y acumuladores.
* Documentá la **política de conteo**: ¿se cuentan palabras vacías? ¿quién cierra la última palabra si no hay blanco final?

---

## Resumen

* Las subsecuencias modelan **segmentos consecutivos** dentro de una secuencia.
* **Enlazadas**: bloques consecutivos (p. ej., códigos de 4). **Jerárquicas**: niveles (texto→oración→palabra).
* Los **patrones** propuestos cubren conteo de palabras, longitudes, oraciones y tratamiento por bloques.
* El éxito del algoritmo depende de **definir bien los delimitadores** y **normalizar casos de borde**.

