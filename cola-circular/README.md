# 🔄 Cola Circular — Productor / Consumidor

Visualización interactiva del problema clásico de **Productor / Consumidor** implementado con una cola circular (también llamada buffer circular o ring buffer).

## ▶️ Cómo usar

Abrí `cola-circular.html` en tu navegador. No requiere instalación ni servidor.

## 🕹️ Controles

| Control | Acción |
|---|---|
| **Producir** | El productor escribe un valor en el siguiente slot disponible |
| **Consumir** | El consumidor lee y extrae el valor más antiguo del buffer |
| **⏵ Auto** | Modo automático: el simulador produce y consume solo, con ritmo 3:1 |
| **⏸ Pausar** | Detiene el modo automático |
| **Velocidad** | Ajusta la velocidad de animación (1× a 4×) |
| **Reset** | Reinicia el buffer al estado inicial |

---

## 🧠 Cómo funciona una cola circular

Una cola circular es un buffer de **tamaño fijo** donde los datos entran por un extremo y salen por el otro, y los punteros "dan la vuelta" al llegar al final del array usando aritmética modular.

```
Buffer de tamaño 8:

Índice:  0    1    2    3    4    5    6    7
       ┌────┬────┬────┬────┬────┬────┬────┬────┐
       │    │P01 │P02 │P03 │    │    │    │    │
       └────┴────┴────┴────┴────┴────┴────┴────┘
                 ↑              ↑
               head            tail
```

### Los tres estados posibles

| Estado | Condición | Comportamiento |
|---|---|---|
| **Normal** | `0 < count < SIZE` | Se puede producir y consumir |
| **Buffer lleno** | `count == SIZE` | El productor se bloquea |
| **Buffer vacío** | `count == 0` | El consumidor se bloquea |

### La "magia" del módulo

El puntero `tail` avanza así al producir:
```javascript
tail = (tail + 1) % SIZE;
```

Y `head` al consumir:
```javascript
head = (head + 1) % SIZE;
```

Cuando `tail` llega al índice `SIZE - 1` y avanza, vuelve al índice `0` en lugar de salir del array. El buffer es circular porque los punteros nunca salen del rango `[0, SIZE-1]`.

### Ejemplo paso a paso

```
Estado inicial:  head=0, tail=0, count=0  →  buffer vacío

Produce P01:     buf[0]='P01', tail=1, count=1
Produce P02:     buf[1]='P02', tail=2, count=2
Consume:         lee buf[0]='P01', head=1, count=1
Produce P03:     buf[2]='P03', tail=3, count=2
```

### Qué muestra la visualización

- **Grilla de slots:** cada celda del buffer, coloreada según su estado (vacío / escrito recientemente / ocupado).
- **Punteros head y tail:** se mueven en tiempo real sobre la grilla.
- **Animación de vuelo:** el valor viaja visualmente desde el productor hasta el slot, o desde el slot hasta el consumidor.
- **Log de eventos:** registro con timestamp de cada operación, mostrando qué valor se escribió/leyó y en qué slot.
- **Estadísticas:** total producido, total consumido, ocupación actual del buffer.

---

## 📐 Estructura del código

El archivo `cola-circular.html` es autocontenido (HTML + CSS + JS):

- **`buf`:** array de tamaño `SIZE` (8) que representa el buffer.
- **`head`:** índice del próximo elemento a consumir.
- **`tail`:** índice donde se escribirá el próximo elemento producido.
- **`count`:** cantidad de elementos actualmente en el buffer.
- **`produce()`:** escribe en `buf[tail]`, avanza `tail` con módulo, incrementa `count`.
- **`consume()`:** lee `buf[head]`, limpia el slot, avanza `head` con módulo, decrementa `count`.
- **`scheduleAuto()`:** loop de modo automático con `setTimeout` recursivo.

---

## 🔗 Aplicaciones reales de la cola circular

- Buffers de audio y video (streaming, reproductores).
- Comunicación entre procesos o hilos (FIFO thread-safe).
- Logging circular donde los registros más viejos se sobreescriben.
- Controladores de dispositivos (teclado, red) en sistemas operativos.
- Sistemas embebidos con memoria limitada.
