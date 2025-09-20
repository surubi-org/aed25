# Subacciones: Funciones y Procedimientos

En esta página se describen las **subacciones** y sus dos formas principales: **funciones** y **procedimientos**. Se cubren conceptos, reglas de diseño, sintaxis de pseudocódigo y ejemplos completos.

---

## Visión general

* **Subacción**: módulo que realiza una tarea específica dentro de una **acción principal**.
* Se escribe una sola vez y puede **invocarse** múltiples veces desde el algoritmo principal o desde otras subacciones.
* Mejora la legibilidad, reutilización y mantenimiento (estrategia de *divide y vencerás*).

---

## Control de ejecución

Cuando el algoritmo principal **llama** a una subacción:

1. **Se detiene** la ejecución del llamador.
2. Se ejecuta la subacción **hasta finalizar** su tarea.
3. El control **retorna** al punto siguiente a la llamada.


> Este comportamiento aplica tanto a funciones como a procedimientos.


---

## Elementos de una subacción

1. **Nombre**

   * Debe ser **representativo** del objetivo del módulo.
   * Debe ser **único** y **no** debe colisionar con **palabras reservadas** del pseudolenguaje.

2. **Parámetros**

   * Mecanismo para **pasar datos** entre el algoritmo principal y la subacción.
   * Pueden ser de **entrada** (datos que recibe) y/o **salida** (datos que devuelve por referencia o por resultado, según el modelo didáctico que uses).

### Reglas prácticas de parámetros

* **Cantidad**: el número de parámetros **formales** debe coincidir con el de **argumentos** al invocar.
* **Orden y tipos**: los parámetros en la llamada deben ser **compatibles** en tipo y **posición** con los formales.

---

## Procedimientos

Un **procedimiento** es una subacción que **no devuelve** un valor como resultado de la llamada. Puede **modificar** parámetros de salida y/o producir efectos (por ejemplo, imprimir o escribir en una estructura).

### Plantilla (pseudocódigo)

```pseudocode
SUBACCIÓN NombreProcedimiento(parámetros_formales) ES
    // Declaraciones locales (si fueran necesarias)
    // Acciones
FINSUBACCIÓN

```

### Ejemplo: Lectura de entradas

```pseudocode
SUBACCIÓN ObtenerEntradas ES
    Esc("Ingrese valor")
    Leer(valor)
FINSUBACCIÓN

ACCION Principal ES
AMBIENTE
    valor: entero
PROCESO
    ObtenerEntradas
    // ... seguir usando 'valor'
FINACCION
```

---

## Funciones

Una **función** es una subacción que **recibe** argumentos y **devuelve un único resultado**. Suele usarse dentro de expresiones o asignaciones.

### Plantilla (pseudocódigo)

```pseudocode
FUNCION NombreFuncion(parámetros_formales): TipoDevuelto

    // Declaraciones locales (si fueran necesarias)
    // Acciones
    NombreFuncion := <expresión_resultado>
FINFUNCION
```

### Ejemplo 1: Mayor de 3

```pseudocode
FUNCION MayorDe3(a,b,c: entero): entero
    Si a >= b y a >= c Entonces
        MayorDe3 := a
    Contrario
        Si b >= a y b >= c Entonces
            MayorDe3 := b
        Contrario
            MayorDe3 := c
        FinSi
    FinSi
FINFUNCION
```

### Ejemplo 2: Dos dígitos iguales (corrección de retorno)

> Dado un número de 2 cifras, determinar si es palíndromo (igual leído al derecho y al revés). Devuelve 1 si lo es, 0 si no.

```pseudocode
FUNCION DosCifrasIguales(n: entero): entero
    // Separar decenas y unidades
    dec := n DIV 10
    uni := n MOD 10
    Si dec = uni Entonces
        DosCifrasIguales := 1

    Contrario
        DosCifrasIguales := 0
    FinSi
FINFUNCION
```


---

## Parámetros de entrada y salida

### Terminología útil

* **Formales** (o ficticios): se declaran en la **definición** del módulo.
* **Actuales** (o argumentos): se suministran en la **llamada**.

### Ejemplo: Contar pares con procedimiento auxiliar

```pseudocode
SUBACCIÓN ContarPares(n: entero; pares: entero) ES
    // 'pares' actúa como salida (por referencia en el modelo didáctico)
    Si (n MOD 2 = 0) Entonces
        pares := pares + 1
    FinSi
FINSUBACCIÓN

ACCION Principal ES
AMBIENTE
    i, v, pares: entero
PROCESO
    pares := 0
    Para i := 1 Hasta 100 Hacer
        Leer(v)
        ContarPares(v, pares)
    FinPara
    Esc("Cantidad de números pares:", pares)
FINACCION
```

### Ejemplo: Uso de función dentro de un algoritmo

```pseudocode
ACCION SerieDosCifras ES
AMBIENTE
    i, v, cant: entero
PROCESO
    cant := 0
    Para i := 1 Hasta 20 Hacer

        Leer(v)
        cant := cant + DosCifrasIguales(v)
    FinPara
    Esc("Cantidad de palíndromos de 2 dígitos:", cant)
FINACCION
```

---

## Buenas prácticas

* **Nombres claros**: describen qué hace la subacción (por ejemplo, `CalcularPromedio` en lugar de `Proc1`).
* **Responsabilidad única**: cada subacción debe resolver una tarea **concreta**.
* **Evitar efectos colaterales** inesperados: documenta qué parámetros son de entrada/salida.
* **Validaciones**: comprueba supuestos (por ejemplo, dominios de entrada) al inicio del módulo.

---

## Errores frecuentes (y cómo evitarlos)

* **No asignar el valor de la función** antes de `FINFUNCION` → Asegurá siempre `NombreFuncion := ...`.
* **Desorden o cantidad incorrecta de parámetros** → Verificá orden, cantidad y tipos.
* **Nombres ambiguos o reservados** → Elegí identificadores válidos y expresivos.

---

## Resumen

* Las **subacciones** encapsulan tareas y favorecen diseño modular.
* **Procedimientos**: no devuelven valor; pueden producir efectos y modificar parámetros de salida.
* **Funciones**: devuelven **un único resultado** y son útiles dentro de expresiones.
* Gestioná correctamente **nombres** y **parámetros** (cantidad, orden, tipo) para llamadas seguras.

