<div align="center">

# 🗡️ Salto al Límite

**Un plataformero 2D hecho con Godot 4 como proyecto de aprendizaje.**

![Godot](https://img.shields.io/badge/Godot-4.7-478CBF?logo=godotengine&logoColor=white)
![GDScript](https://img.shields.io/badge/GDScript-tipado-355570)
![Renderer](https://img.shields.io/badge/Renderer-GL%20Compatibility-5C5C5C)
![Estado](https://img.shields.io/badge/Estado-en%20desarrollo-F5A623)

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

El proyecto está en la fase **M1 · Jugador plataformero**. Ya funciona:

- 🏃 Movimiento horizontal con `Input.get_axis`.
- ⬆️ Gravedad y salto, que solo se puede hacer desde el suelo.
- 🪂 Salto variable: un toque corto da un salto bajo y mantener la tecla da uno alto.
- 🎞️ Animaciones `idle`, `run`, `jump` y `fall`, con el sprite mirando hacia donde corre.
- 🧪 Un cuarto de pruebas (`scenes/test_room.tscn`) con escalones, un hueco y una pared.

Siguen la cámara, las plataformas one-way, el nivel, las monedas, los slimes, la meta y el audio. El roadmap completo está en [`docs/DEVELOPMENT_PLAN.md`](docs/DEVELOPMENT_PLAN.md).

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
4. Abre `scenes/test_room.tscn` y pulsa **F6** para probar la escena actual.

## 🗂️ Estructura del proyecto

```
leap-to-the-limit/
├── assets/     # Sprites, sonidos, música y fuentes (CC0)
├── scenes/     # Player y cuarto de pruebas (por ahora)
├── scripts/    # Un script GDScript tipado por escena
├── ui/         # Recursos de interfaz
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
