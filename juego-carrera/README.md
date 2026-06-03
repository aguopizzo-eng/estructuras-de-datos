# 🎮 NITRO LANES

Juego de carreras 2D de vista cenital (top-down) desarrollado en un único archivo HTML. El jugador controla un auto amarillo que avanza por una carretera de tres carriles, esquivando y destruyendo autos enemigos. El objetivo es sobrevivir el mayor tiempo posible, acumular puntos y alcanzar niveles cada vez más difíciles.

El juego incluye un panel lateral que visualiza una **lista enlazada implementada en Java**, usada como leaderboard dinámico en tiempo real.

**Tecnología:** HTML5 + CSS3 + JavaScript (Canvas API) · Sin dependencias externas · Desarrollado con asistencia de Claude (Anthropic) · 2025

---

## ▶️ Cómo ejecutar

No requiere instalación ni servidor. Dos opciones:

- **Doble clic** sobre `carrera.html` → se abre en el navegador.
- **VS Code:** click derecho sobre el archivo → *Open with Live Server*.

**Compatibilidad:** Chrome 90+, Firefox 88+, Edge 90+, Safari 14+

---

## 🕹️ Controles

| Tecla | Acción |
|---|---|
| `←` / `→` o `A` / `D` | Cambiar de carril |
| `Z` o `↑` | Disparar |
| `Espacio` | Turbo |

---

## 📐 Ficha Técnica

| Campo | Valor |
|---|---|
| Archivo | `carrera.html` (archivo único) |
| Resolución del juego | 400 × 620 px (canvas central) |
| Resolución total | 880 × 620 px (con paneles) |
| Fuentes externas | Google Fonts: Russo One, VT323, IBM Plex Mono |
| FPS objetivo | 60 FPS (`requestAnimationFrame`) |

---

## 🖥️ Estructura de pantalla

La interfaz está dividida en tres paneles:

- **Panel izquierdo (280px):** Lista enlazada Java — muestra el código fuente del nodo, la visualización dinámica de la lista ordenada por puntaje y el contador de operaciones.
- **Panel central (400px):** Canvas del juego — renderiza la carretera, autos, balas, partículas y overlays de inicio/fin.
- **Panel derecho (200px):** HUD — score, best, barra de HP, velocidad, turbo, nivel y kill feed.

---

## ⚙️ Mecánicas

### Carriles y movimiento
La carretera tiene 3 carriles. El jugador se mueve instantáneamente con una transición suave animada por interpolación. Los enemigos spawnan en el extremo superior y avanzan hacia abajo.

### Dificultad progresiva
El nivel sube cada 7 segundos, comenzando en nivel 2. Cada nivel aumenta la velocidad base y reduce el intervalo entre oleadas. A partir del nivel 4 aparecen oleadas de 2 autos simultáneos; a partir del nivel 7, de 3.

### Camino siempre libre
`getBlockedLanes()` analiza en tiempo real qué carriles tienen enemigos dentro de los 200px sobre el jugador. El generador de oleadas nunca spawnea autos en todos los carriles simultáneamente, garantizando siempre al menos una salida viable.

### Movimiento de enemigos
Cada auto enemigo puede cambiar de carril **exactamente una vez**. No puede hacerlo si el jugador está a menos de 130px de distancia vertical, y el cambio se cancela si bloquearía el último carril libre.

### Sistema de balas
- **Jugador:** cooldown de 14 frames (muy corto, se puede mantener presionado).
- **Enemigos:** cooldown fijo de 90 frames (~1.5 segundos), independiente de la velocidad del juego. Se activa a partir del nivel 2.

### HP y daño
El jugador tiene 5 HP (representados como píldoras). Pierde 1 HP al recibir una bala enemiga. Un impacto directo de auto termina la partida de inmediato.

### Turbo
Multiplica la velocidad por 2.2. Se activa con Espacio cuando la barra está al menos al 20%. Se recarga automáticamente cuando no está en uso.

### Lista enlazada — Leaderboard
Al destruir un auto enemigo se genera un nombre aleatorio y se inserta un nodo en la lista con el puntaje actual. La inserción es **O(n) ordenada** de mayor a menor puntaje. La lista se limita a los 8 mejores registros y se reinicia con cada partida.

---

## 🏆 Sistema de puntaje

| Evento | Puntos |
|---|---|
| Auto que pasa sin ser destruido | +1 |
| Auto destruido (1 HP) | +3 + nivel |
| Auto destruido (2 HP) | +6 + nivel |
| Auto destruido (3 HP) | +9 + nivel |

---

## 💡 Consejos

- Quedarse en el carril del medio al inicio da más opciones de escape.
- Cambiar de carril al ver un auto enemigo en el mismo carril reduce el riesgo de recibir balas.
- El turbo es más útil para esquivar oleadas densas en niveles altos.
- Disparar constantemente es casi gratuito: el cooldown de 14 frames es muy corto.
- Los autos con barra de HP (nivel 3+) necesitan 2 o 3 disparos; apuntalos antes de que se acerquen.

---

## 🔗 Conexión con la estructura de datos

| Operación del juego | Operación en la lista |
|---|---|
| Nuevo enemigo destruido | Inserción ordenada O(n) |
| Lista supera 8 nodos | Eliminación del último nodo |
| Reiniciar partida | Liberar lista completa |
| Panel lateral | Recorrido completo para renderizar |

La lista es conceptualmente Java (el código fuente mostrado en el panel es Java válido), pero su ejecución es JavaScript para integrarse con el juego. Los nodos se visualizan con animaciones CSS y muestran punteros hexadecimales simulados para reforzar el concepto de estructura de datos.

---

## 🛠️ Decisiones técnicas

**Canvas 2D vs DOM:** el área de juego usa Canvas 2D API para control total del renderizado frame a frame. Los paneles laterales usan DOM/CSS para aprovechar el flujo de layout y las animaciones nativas.

**Archivo único:** todo el juego vive en un solo `.html` (HTML + CSS + JS inline), lo que facilita la distribución y la ejecución sin servidor.

**Cooldowns desacoplados de la velocidad:** el `shootCd` enemigo es fijo en 90 frames absolutos. En versiones anteriores el ritmo de disparo se aceleraba con el nivel porque el cooldown dependía de `speed`; desacoplarlos hace el juego consistente y más justo.

---

## 🔄 Proceso de construcción — Iteraciones

El juego fue construido de forma iterativa mediante prompts en lenguaje natural, sin diseño técnico previo. Cada iteración surgió de evaluar el resultado anterior.

| Iteración | Prompt | Cambios |
|---|---|---|
| 1 | *"proponés un juego para un reto de clase en 5 minutos"* | Juego inicial: Atrapa el Emoji. Timer de 30 seg y puntaje. |
| 2 | *"Haz un juego simple de autos con HTML y CSS"* | Primer juego de autos: 3 carriles, enemigos, turbo, puntaje. |
| 3 | *"Reestructura completamente: 3D, dificultad, lista programada en Java"* | Rediseño con perspectiva 3D, balas, HP y panel con lista Java. |
| 4 | *"Que no sea 3D, hacerlo 2D limpio; lista Java visible"* | Nuevo juego 2D top-down. Panel con código Java y visualización de lista con sorted insert. |
| 5 | *"Bajale la dificultad, autos se mueven solo una vez de carril"* | Reducción de oleadas. Flag `hasMoved`. Zona de seguridad de 130px. |
| 6 | *"Nivel 1 = nivel 2, camino siempre posible, disparo constante"* | Arranque en nivel 2. `getBlockedLanes()`. `shootCd` fijo en 90 frames. |
| 7 | *"Especificación, manual de usuario y proceso de construcción"* | Generación de este documento. |
