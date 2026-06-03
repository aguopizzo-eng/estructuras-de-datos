# 🗂️ Estructuras de Datos

Colección de implementaciones y visualizaciones de estructuras de datos clásicas, desarrolladas con fines educativos. El repositorio está organizado en tres secciones independientes.

---

## 📁 Contenido

### 🎮 [Juego — Nitro Lanes](./juego-carrera/)
Un juego de carreras interactivo en el navegador que usa una **lista enlazada** como estructura de datos subyacente para gestionar los autos en pista. Combina lógica de estructuras de datos con una interfaz visual animada.

### 🔗 [Listas Enlazadas](./listas-enlazadas/)
Implementación del mismo algoritmo de lista enlazada simple en **cuatro lenguajes de programación**:
- C
- Java
- Pascal
- COBOL

Incluye análisis comparativo de similitudes y diferencias entre lenguajes: gestión de memoria, paradigmas, sintaxis y manejo de punteros.

### 🔄 [Cola Circular](./cola-circular/)
Visualización interactiva del problema clásico **Productor / Consumidor** usando una cola circular (buffer de tamaño fijo). Muestra en tiempo real cómo los punteros `frente` y `final` se mueven en el buffer, las condiciones de cola llena y vacía, y el flujo de datos entre productor y consumidor.

---

## 🛠️ Tecnologías

| Sección | Tecnologías |
|---|---|
| Juego Nitro Lanes | HTML, CSS, JavaScript |
| Listas Enlazadas | C, Java, Pascal, COBOL |
| Cola Circular | HTML, CSS, JavaScript |

---

## 🚀 Cómo usar

**Juego y Cola Circular:** abrir el archivo `.html` directamente en cualquier navegador moderno, no requiere servidor ni instalación.

**Listas Enlazadas:**
```bash
# C
gcc lista_enlazada.c -o lista && ./lista

# Java
javac ListaEnlazada.java && java ListaEnlazada

# Pascal (Free Pascal)
fpc lista_enlazada.pas && ./lista_enlazada

# COBOL (GnuCOBOL)
cobc -x lista_enlazada.cbl -o lista_cobol && ./lista_cobol
```
