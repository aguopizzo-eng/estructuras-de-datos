# 🎮 Nitro Lanes

Juego de carreras en el navegador donde la pista y los autos se gestionan internamente con una **lista enlazada**.

## ▶️ Cómo jugar

Abrí `carrera.html` en tu navegador. No requiere instalación ni servidor.

## 🕹️ Mecánica

- Controlás un auto en una pista de múltiples carriles.
- Los autos rivales se almacenan y recorren como nodos de una lista enlazada; cada frame el juego itera la lista para actualizar posiciones y detectar colisiones.
- El panel lateral muestra la lista en tiempo real: cada nodo representa un auto activo en pista con su posición y velocidad.
- Los autos que salen de pista se eliminan de la lista; los nuevos se insertan al inicio o al final según la lógica del juego.

## 🔗 Conexión con la estructura de datos

| Operación del juego | Operación en la lista |
|---|---|
| Nuevo auto entra a la pista | `insertarInicio` o `insertarFinal` |
| Auto sale o choca | `eliminarNodo` |
| Actualizar posiciones | Recorrido completo (`mostrarLista`) |
| Contar autos en pista | `contarNodos` |

La visualización lateral permite ver exactamente qué está pasando en la lista mientras el juego corre, conectando la mecánica visual con el concepto de estructura de datos.

## 📐 Estructura del código

El archivo `carrera.html` es autocontenido (HTML + CSS + JS en un único archivo):

- **Panel izquierdo:** visualización de la lista enlazada en vivo.
- **Canvas central:** pista de juego animada con `requestAnimationFrame`.
- **Lógica JS:** clase `LinkedList` con métodos `insertarInicio`, `insertarFinal`, `eliminar` y `recorrer`.
