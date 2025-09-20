# Corte de Control

El **corte de control** es un proceso *individual* sobre archivos que permite **emitir información jerárquica** con **totales parciales** por niveles de clave y **total general**. Es una especialización de los padrones (listados) donde, además de recorrer, **agrupamos** y **acumulamos** por campos.

> ⚠️ No todos los problemas se resuelven con corte de control. Se aplica cuando necesitás **agregar** (contar, sumar, min/max, etc.) por **grupos** definidos por **claves**.

---

## Requisitos indispensables

1. **Clave compleja** que identifique la jerarquía de agrupación (uno o más campos).
2. **Archivo ordenado** por los **campos de corte** (en el orden jerárquico que se va a informar).

   * Si el informe es por **Ciudad → Raza**, el archivo debe estar **ordenado por Ciudad y Raza**.
   * Si es por **Mes → Tipo** (p. ej., satélites por mes y por tipo), debe estar **ordenado por Mes y Tipo**.

Si los datos **no están ordenados**, primero hay que **ordenarlos** o usar otro enfoque.

---

## Anatomía del algoritmo

* **Resguardo de claves**: variables que guardan la clave **actual** (p. ej., `res_ciu`, `res_raza`).
* **Totalizadores por nivel**: `tot_raza`, `tot_ciu`, `tot_gral`, etc.

* **Lectura anticipada**: leer el **primer registro** para inicializar resguardos y entrar al bucle.
* **Verificación de corte**: antes de tratar un registro, comparar sus claves con los resguardos.
* **Cortes por niveles**: al cambiar un nivel **superior**, primero cerrar (emitir y reiniciar) los **niveles inferiores**.
* **Cierre final**: al terminar el recorrido, **forzar los cortes pendientes** y emitir **total general**.

---

## Patrón base (1 nivel de corte)

```pseudocode
ACCION Corte1 ES
AMBIENTE
  REG = Registro
    clave: ...   // campo de agrupación
    valor: ...   // campo a acumular/contar

  FinRegistro
  A: Archivo de REG ordenado por clave
  R: REG
  res_clave: ...
  tot_nivel, tot_gral: entero

SUBACCION VER_CORTE ES
  Si R.clave <> res_clave Entonces
     CORTE_NIVEL
  FinSi
FINSUBACCION

SUBACCION CORTE_NIVEL ES
  Esc("Total para ", res_clave, ": ", tot_nivel)
  tot_gral := tot_gral + tot_nivel
  tot_nivel := 0
  res_clave := R.clave
FINSUBACCION

SUBACCION TRATAR_REGISTRO ES
  // ejemplo: contar 1 por registro
  tot_nivel := tot_nivel + 1
FINSUBACCION

PROCESO
  tot_nivel := 0; tot_gral := 0
  ABRIR E/(A)
  LEER(A, R)
  Si NFDA(A) Entonces
     res_clave := R.clave        // resguardo inicial
     Mientras NFDA(A) Hacer
        VER_CORTE                // corta si cambió la clave
        TRATAR_REGISTRO

        LEER(A, R)
     FinMientras
     CORTE_NIVEL                 // cierre del último grupo
     Esc("Total general: ", tot_gral)
  FinSi
  CERRAR(A)
FINACCION
```

> **Idea**: *ver corte → tratar → leer*. El orden ayuda a detectar el cambio **antes** de acumular en el grupo equivocado.

---


## Patrón de 2 niveles (Nivel 2 → Nivel 1)

Ejemplo clásico: **Ciudad (nivel 2) → Raza (nivel 1)**.
Contar mascotas con **peso > 5 kg** por **Raza** y **Ciudad**, y total general.

```pseudocode
ACCION Corte2 ES
AMBIENTE
  Mascota = Registro
    Clave = Registro
      Ciudad: AN(30)
      Raza:   AN(20)
      Nombre: AN(30)
    FinRegistro
    Color: AN(10)
    Peso:  N(4,2)
  FinRegistro
  A: Archivo de Mascota ordenado por Clave.Ciudad, Clave.Raza
  M: Mascota

  res_ciu: AN(30)
  res_raza: AN(20)

  tot_raza, tot_ciu, tot_gral: entero

SUBACCION VER_CORTE ES
  Si M.Clave.Ciudad <> res_ciu Entonces
     CORTE_CIUDAD
  Sino Si M.Clave.Raza <> res_raza Entonces
     CORTE_RAZA
  FinSi
FINSUBACCION

SUBACCION CORTE_RAZA ES
  Esc("Total en ciudad ", res_ciu, " de raza ", res_raza, ": ", tot_raza)
  tot_ciu := tot_ciu + tot_raza
  tot_raza := 0
  res_raza := M.Clave.Raza
FINSUBACCION

SUBACCION CORTE_CIUDAD ES
  CORTE_RAZA                         // primero cerrar nivel inferior
  Esc("Total en ciudad ", res_ciu, ": ", tot_ciu)
  tot_gral := tot_gral + tot_ciu
  tot_ciu := 0
  res_ciu := M.Clave.Ciudad
FINSUBACCION

SUBACCION TRATAR_REGISTRO ES
  Si M.Peso > 5 Entonces
     tot_raza := tot_raza + 1
  FinSi
FINSUBACCION

PROCESO
  tot_raza := 0; tot_ciu := 0; tot_gral := 0
  ABRIR E/(A)
  LEER(A, M)
  Si NFDA(A) Entonces
     res_ciu := M.Clave.Ciudad
     res_raza := M.Clave.Raza
     Mientras NFDA(A) Hacer
        VER_CORTE
        TRATAR_REGISTRO
        LEER(A, M)
     FinMientras
     CORTE_CIUDAD                    // cierre del último bloque (propaga corte de raza)

     Esc("Total general (>5 kg): ", tot_gral)
  FinSi
  CERRAR(A)
FINACCION
```

> **Regla de oro**: cuando cambia un nivel **superior**, hay que **cerrar primero** todos los niveles **inferiores**.

---


## Patrón de 3+ niveles (escalable)

La idea se generaliza: `VER_CORTE` compara desde el **nivel más alto** al **más bajo**; cada `CORTE_k` **llama** al corte del nivel **inmediato inferior** antes de emitir y reiniciar su totalizador.

```pseudocode
// Esqueleto para N niveles (L3 > L2 > L1)
// Si cambia L3 → CORTE_L3 (que llama a CORTE_L2 → que llama a CORTE_L1)
// Si cambia L2 → CORTE_L2 (que llama a CORTE_L1)
// Si cambia L1 → CORTE_L1
```

> En informes complejos, conviene **modularizar** cortes por nivel y mantener **nombres claros** (`res_l1`, `tot_l1`, etc.).

---

## Variantes de tratamiento

* **Conteos** (registros, casos que cumplen una condición)
* **Sumas** (acumular un campo numérico)
* **Min/Max** (acompañados de la clave del mejor/peor)
* **Promedios** (sumas + conteos por nivel)
* **Porcentajes** (necesitan conocer `tot_nivel` y `tot_superior`)

> El bloque `TRATAR_REGISTRO` cambia según la métrica.


---

## Casos de aplicación y no aplicación


* ✔️ **Aplicación**: “Emitir totales de satélites **por mes y por tipo**” → ordenar por **Mes, Tipo**.
* ❌ **No aplicación** (tal cual): “Totales de satélites **en diciembre** (sin agrupar)” → alcanza con **filtro + padrón**.


---

## Errores frecuentes

* **Archivo mal ordenado** respecto de las claves de corte.
* **Olvidar el cierre final** de cortes → se pierde el último grupo.
* **Inicializaciones incorrectas** de resguardos/totalizadores.
* **Orden de verificación** erróneo: cortar inferior antes que superior.
* **Tratar antes de `VER_CORTE`** → contamina el grupo anterior.

---


## Checklist rápido

* [ ] ¿Definiste **clave(s)** y **orden** del archivo?
* [ ] ¿Hiciste **lectura anticipada** y resguardaste claves?
* [ ] ¿Invocás `VER_CORTE` **antes** de `TRATAR_REGISTRO`?
* [ ] ¿Los **cortes** se emiten de **abajo hacia arriba** (L1→L2→...)?
* [ ] ¿Forzás el **cierre final** al terminar?

---


## Resumen

El **corte de control** estructura informes jerárquicos por **grupos**: requiere **clave compleja** y **archivo ordenado**. Su patrón esencial es: **leer → ver corte → tratar → leer**, con **cortes en cascada** desde el nivel inferior al superior y un **cierre final** que emite totales pendientes y el **total general**.

