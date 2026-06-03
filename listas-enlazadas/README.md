# 🔗 Listas Enlazadas — Implementación en 4 lenguajes

El mismo algoritmo de lista enlazada simple implementado en C, Java, Pascal y COBOL. Todos resuelven las mismas 6 operaciones con menú interactivo en consola.

## 📋 Operaciones implementadas

1. Insertar al inicio
2. Insertar al final
3. Mostrar lista
4. Buscar elemento
5. Eliminar nodo
6. Contar nodos

---

## ⚙️ Cómo ejecutar

```bash
# C
gcc lista_enlazada.c -o lista && ./lista

# Java
javac ListaEnlazada.java && java ListaEnlazada

# Pascal (requiere Free Pascal Compiler)
fpc lista_enlazada.pas && ./lista_enlazada

# COBOL (requiere GnuCOBOL)
cobc -x lista_enlazada.cbl -o lista_cobol && ./lista_cobol
```

---

## 🧠 Cómo funciona una lista enlazada

Una lista enlazada es una secuencia de **nodos** donde cada nodo guarda un dato y una referencia (puntero o índice) al nodo siguiente. A diferencia de un array, los nodos no están en posiciones contiguas de memoria; están conectados entre sí mediante esas referencias.

```
cabeza
  │
  ▼
┌──────────┐    ┌──────────┐    ┌──────────┐
│ dato: 10 │───▶│ dato: 20 │───▶│ dato: 30 │───▶ NULL
└──────────┘    └──────────┘    └──────────┘
```

### Insertar al inicio — O(1)
Se crea un nuevo nodo, su `siguiente` apunta a la cabeza actual, y la cabeza pasa a ser el nuevo nodo. No hay que recorrer nada.

### Insertar al final — O(n)
Hay que recorrer toda la lista hasta llegar al último nodo (aquel cuyo `siguiente` es `NULL`/`nil`/`0`) y enlazarlo con el nuevo.

### Eliminar un nodo — O(n)
Se recorre la lista buscando el nodo. Cuando se encuentra, se conecta el nodo anterior directamente con el siguiente, "saltando" el nodo a eliminar. Luego se libera la memoria.

### Buscar — O(n)
Recorrido lineal comparando cada `dato` con el valor buscado. En el peor caso se recorre toda la lista.

---

## 🔍 Comparativa entre lenguajes

### Definición del nodo

| Lenguaje | Cómo define el nodo |
|---|---|
| **C** | `struct` con un puntero `Nodo*` a sí mismo |
| **Java** | Clase interna `static class Nodo` con referencia de objeto |
| **Pascal** | `record` con un puntero `PNodo = ^Nodo` |
| **COBOL** | Tabla fija de 100 entradas en `WORKING-STORAGE`; los "punteros" son índices numéricos |

### Gestión de memoria

| Lenguaje | Cómo maneja la memoria |
|---|---|
| **C** | Manual: `malloc` para crear, `free` para liberar. Si no se libera hay memory leak. |
| **Java** | Automática: el Garbage Collector libera nodos cuando no hay referencias. |
| **Pascal** | Manual: `New()` para crear, `Dispose()` para liberar. Similar a C. |
| **COBOL** | No hay heap dinámico. Simula los nodos con una tabla estática de 100 posiciones y un flag `WS-LIBRE` para marcar slots disponibles. |

### Punteros y referencias

- **C** usa punteros explícitos (`*`, `&`, `->`) con control total y riesgo de errores.
- **Java** usa referencias de objeto; la sintaxis es `.` y la gestión es automática.
- **Pascal** usa el operador `^` para desreferenciar y `^.` para acceder a campos, similar a C pero con sintaxis propia.
- **COBOL** no tiene punteros: el "siguiente" es un número entero que es el índice en la tabla. `WS-SIGUIENTE(idx)` equivale a `nodo->siguiente`.

### Paradigma

| Lenguaje | Paradigma en este código |
|---|---|
| **C** | Procedural. Funciones sueltas que reciben `Nodo**` para modificar la cabeza. |
| **Java** | Orientado a objetos. La lista es una clase con métodos de instancia. |
| **Pascal** | Procedural. Procedimientos y funciones que reciben `var` (paso por referencia). |
| **COBOL** | Procedural por párrafos (`PERFORM`). Toda la "memoria" es global en `WORKING-STORAGE`. |

### Validación de entrada

Todos los lenguajes incluyen validación de entrada para asegurar que el usuario ingrese un número entero:
- **C:** `fgets` + `sscanf` en un loop.
- **Java:** `Scanner.nextLine()` + `Integer.parseInt()` con `try/catch`.
- **Pascal:** `Readln` + `Val()` verificando el código de error.
- **COBOL:** `ACCEPT` + `FUNCTION NUMVAL()`.

---

## ✅ Similitudes entre los cuatro lenguajes

- El **algoritmo es idéntico**: misma lógica de recorrido, inserción y eliminación.
- Todos usan un **nodo con dos campos**: dato y referencia al siguiente.
- Todos manejan el **caso de lista vacía** antes de operar.
- El recorrido siempre termina cuando la referencia al siguiente es `NULL` / `nil` / `0`.
- Todos presentan el **mismo menú** con las 6 operaciones.

## ❌ Diferencias clave

- Solo COBOL carece de memoria dinámica real; simula la lista con una tabla estática.
- Solo Java tiene recolección de basura automática.
- C y Pascal requieren liberar memoria manualmente al salir.
- Java encapsula la lista en una clase; los demás usan variables globales o parámetros.
- COBOL almacena toda la estructura en variables globales de `WORKING-STORAGE`; no hay funciones con parámetros.
