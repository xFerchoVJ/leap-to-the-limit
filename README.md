<div align="center">

# 🗡️ Salto al Límite

**Un plataformero 2D hecho con Godot 4 como proyecto de aprendizaje.**

![Godot](https://img.shields.io/badge/Godot-4.7-478CBF?logo=godotengine&logoColor=white)
![GDScript](https://img.shields.io/badge/GDScript-tipado-355570)
![Renderer](https://img.shields.io/badge/Renderer-GL%20Compatibility-5C5C5C)
![Estado](https://img.shields.io/badge/Estado-MVP%20terminado-4CAF50)

</div>

---

## 🎮 ¿De qué trata?

Un caballero corre, salta entre plataformas, esquiva slimes, recoge monedas y llega a la meta.

> **Correr → saltar entre plataformas → recoger monedas → esquivar slimes → llegar a la meta (o perder y reiniciar).**

*Salto al Límite* es un nombre provisional.

## 🎓 Un proyecto para aprender

Es mi segundo proyecto en Godot, después de [Coin Collector](https://github.com/xFerchoVJ/coin-collector-godot). Vengo del desarrollo web (Rails) y quiero profundizar en lo que cambia al pasar de un juego top-down a un plataformero: gravedad, saltos, *game feel*, plataformas y enemigos con patrulla.

Lo construyo en tareas pequeñas y ordenadas, con la guía de un mentor técnico (Claude Code) que me da pistas progresivas en vez de la solución. El código de gameplay lo escribo yo. El seguimiento de lo que voy aprendiendo está en [`docs/LEARNING_PROGRESS.md`](docs/LEARNING_PROGRESS.md).

## 🚧 Estado actual

El **MVP está terminado**: el juego se puede jugar de principio a fin, desde el menú hasta la pantalla de victoria. Incluye:

- 🏃 Jugador con movimiento horizontal, gravedad, salto variable y animaciones `idle`, `run`, `jump` y `fall`.
- 🎥 `Camera2D` con suavizado y límites del nivel.
- 🧱 Un nivel (`level_01`) de 80×12 tiles con plataformas one-way y dos plataformas móviles (`AnimatableBody2D` con `Tween`, recorrido configurable desde el inspector).
- 🪙 Monedas animadas con HUD de puntaje en fuente pixel.
- 🟢 Slimes que patrullan con `RayCast2D` y no se caen de los bordes.
- 💀 Muerte al tocar un slime o caer al vacío, con pausa y reinicio del nivel.
- 🏁 Meta que registra la victoria una sola vez y abre la pantalla de victoria (reiniciar o volver al menú).
- 🏠 Menú principal con Jugar y Salir.
- 🔊 Efectos de sonido (salto, moneda y golpe) y música de fondo en bucle.

Quedó fuera del MVP, por decisión: vidas, checkpoints, varios niveles, pisar enemigos y autoload. El roadmap y la definición de terminado están en [`docs/DEVELOPMENT_PLAN.md`](docs/DEVELOPMENT_PLAN.md).

## 🕹️ Controles

| Acción | Tecla |
|---|---|
| Izquierda | `A` o `←` |
| Derecha | `D` o `→` |
| Saltar | `Espacio` |

## 🚀 Cómo ejecutarlo

1. Instala [Godot 4.7](https://godotengine.org/download) (versión estándar, no .NET).
2. Clona el repositorio:
   ```bash
   git clone git@github.com:xFerchoVJ/leap-to-the-limit.git
   ```
3. Abre Godot, pulsa **Importar** y selecciona el archivo `project.godot`.
4. Pulsa **F5** para ejecutar el juego desde el menú principal. Con **F6** puedes probar la escena que tengas abierta, por ejemplo `scenes/level_01.tscn` o el cuarto de pruebas `scenes/test_room.tscn`.

## 🗂️ Estructura del proyecto

```
leap-to-the-limit/
├── assets/     # Sprites, sonidos, música y fuentes (CC0)
├── scenes/     # Menú, nivel, jugador, slime, moneda, meta, plataforma móvil, HUD y pantallas
├── scripts/    # Un script GDScript tipado por escena
├── ui/         # Reservada para recursos de interfaz (vacía por ahora)
├── docs/       # Plan de desarrollo, backlog y progreso de aprendizaje
└── project.godot
```

## 📚 Documentación

- [`docs/DEVELOPMENT_PLAN.md`](docs/DEVELOPMENT_PLAN.md): roadmap y definición de terminado del MVP.
- [`docs/TASK_BACKLOG.md`](docs/TASK_BACKLOG.md): las tareas con sus checklists, pistas y criterios de aceptación.
- [`docs/LEARNING_PROGRESS.md`](docs/LEARNING_PROGRESS.md): qué aprendí, qué implementé y qué dificultades tuve en cada tarea.

## 🧰 Tecnologías

- **Motor:** Godot 4.7, renderer GL Compatibility.
- **Lenguaje:** GDScript tipado, siguiendo las convenciones de Godot 4.
- **Resolución:** viewport de 320×180 escalado ×4 a 1280×720, con filtro Nearest para pixel art.

## 🎨 Créditos

Los assets son de dominio público (CC0). Sprites de [analogStudios_](https://analogstudios.itch.io/) y [RottingPixels](https://rottingpixels.itch.io/), y sonidos, música y paquete reorganizado de Brackeys y colaboradores. La fuente es Pixel Operator. Detalle completo en [`assets/LICENSE & CREDITS.txt`](<assets/LICENSE & CREDITS.txt>).
