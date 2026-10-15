# Plan de desarrollo — Salto al Límite

## Concepto
Un plataformero 2D de un solo nivel horizontal. El caballero corre y salta entre plataformas, esquiva slimes que patrullan, recoge monedas y llega a la meta. Si toca un slime o cae al vacío, muere y el nivel se reinicia.

- Motor: Godot 4.7, GL Compatibility, GDScript tipado.
- Arte, sonido y música: pack CC0 en `assets/` (ver `CLAUDE.md`).
- Tareas detalladas: `docs/TASK_BACKLOG.md`. Seguimiento: `docs/LEARNING_PROGRESS.md`.

## Alcance del MVP
- Movimiento horizontal, gravedad y salto con altura variable.
- Animaciones idle, run, jump y fall.
- Un nivel más largo que la pantalla, con cámara que sigue al jugador, hecho con `TileMapLayer`.
- Plataformas *one-way* (se atraviesan desde abajo) y plataformas móviles.
- Monedas con puntaje en el HUD.
- Slimes que patrullan y no se caen de los bordes.
- Muerte instantánea por slime o por caída, con reinicio tras una pequeña pausa.
- Meta del nivel y pantalla de victoria, con menú principal.
- Efectos de sonido y música de fondo.

## Core gameplay loop
Correr → saltar → recoger monedas → esquivar slimes y huecos → llegar a la meta (o morir y reintentar).

## Fases
| Fase | Objetivo | Conceptos nuevos (★) | Repaso de Coin Collector (♻) |
|---|---|---|---|
| **M0 — Preparación** | Proyecto listo para pixel art | | Ajustes de proyecto, Nearest, carpetas, layers con nombre |
| **M1 — Jugador plataformero** | Un caballero que cae, corre, salta y se anima | Gravedad con `get_gravity()` y `delta`, `is_on_floor()`, `Input.get_axis`, `is_action_just_pressed`/`just_released`, salto variable, animaciones por estado aéreo, `position_smoothing` | `CharacterBody2D`, `CollisionShape2D`, Input Map, `AnimatedSprite2D`, `TileSet`/`TileMapLayer`, `Camera2D` |
| **M2 — Nivel** | Plataformas one-way y un nivel construido | Colisión one-way, métricas de salto para diseñar el nivel | `TileMapLayer`, physics layers |
| **M3 — Monedas y HUD** | Coleccionables con puntaje | `LabelSettings` y fuentes | `Area2D`, señales, grupos, `queue_free`, `CanvasLayer`, señales personalizadas |
| **M4 — Peligros** | Slimes y condiciones de derrota | `RayCast2D`, nodo `Timer`, `await`, `Area2D` como zona de muerte | Escena de enemigo, patrulla, señales "call down, signal up" |
| **M5 — Plataformas móviles** | Plataformas que transportan al jugador | `AnimatableBody2D`, `AnimationPlayer` y pistas, `Tween` | `@export`, instanciar escenas |
| **M6 — Meta y bucle de juego** | Se puede ganar y reiniciar | | `Area2D`, señales, `Control`, contenedores, `change_scene_to_file`, `reload_current_scene` |
| **M7 — Audio y cierre** | Sonido y revisión final | `AudioStreamPlayer`/`AudioStreamPlayer2D`, loop de importación, buses de audio (básico) | |

## Dependencias entre funcionalidades
```
M0 → M1 → M2 ─────────────┐
       ├→ M3 ─────────────┤
       ├→ M4 (T13→T16) ───┼→ D03 → M6 → M7
       └→ M5 (T17→T18) ───┘
```
- Casi todo depende del jugador (M1): no hay moneda, slime ni plataforma móvil que probar sin saltar.
- El nivel principal (D02) necesita saber hasta dónde salta el jugador (C01) y las plataformas one-way (T10).
- D03 reúne lo construido en M3, M4 y M5 dentro del nivel, así que va después de todos ellos.
- Los sonidos (T21) necesitan el salto, las monedas y la muerte ya funcionando.

## Quién hace qué
| Tipo | Tareas |
|---|---|
| **A — Aprendizaje (tú)** | T01–T22 |
| **D — Contenido delegado (yo, con tu autorización cada vez)** | D01 cuarto de pruebas, D02 layout del nivel, D03 colocar objetos en el nivel |
| **C — Compartido** | C01 medir el alcance del salto, C02 revisión final |

Las tareas D solo pintan tiles o colocan instancias de escenas que tú ya creaste. No tocan scripts, Input Map, física, señales ni ajustes del proyecto.

## Calendario estimado (5–8 h por semana)
| Semana | Fases | Horas aprox. |
|---|---|---|
| 1 | M0, M1 (T01–T09) | 5–6 |
| 2 | M2, M3 (T10–T12, C01, D02) | 4–5 |
| 3 | M4, M5 (T13–T18, D03) | 5–6 |
| 4 | M6, M7 y margen (T19–T22, C02) | 4–5 |

Las tareas de aprendizaje suman unas 14 h; con depuración y revisión, entre 18 y 22 h. Si una semana se atrasa, el margen de la semana 4 lo absorbe. Si hace falta recortar, se sacan primero T22 (música) y T18.

## Definición de terminado (DoD)
- [ ] El jugador corre, salta con altura variable y se anima según su estado.
- [ ] El nivel se puede completar usando plataformas one-way y móviles.
- [ ] Las monedas se recogen y el HUD muestra el puntaje.
- [ ] Los slimes patrullan y no se caen de los bordes.
- [ ] Tocar un slime o caer al vacío mata al jugador y reinicia el nivel.
- [ ] Llegar a la meta muestra la pantalla de victoria, con opción de reiniciar o volver al menú.
- [ ] Hay menú principal, efectos de sonido y música.
- [ ] La consola de Godot no muestra errores al jugar de principio a fin desde el menú.
- [ ] El código usa GDScript tipado y `LEARNING_PROGRESS.md` está al día.
- [ ] Puedo explicar con mis palabras: la gravedad con `delta` e `is_on_floor()`, la diferencia entre one-way y `AnimatableBody2D`, y qué hace un `RayCast2D`.

## Fuera de alcance
Vidas o corazones, checkpoints, varios niveles o selector de niveles, combate o pisar enemigos, roll o dash, autoload, parallax, guardado y progreso persistente, generación procedural, multijugador, IA con persecución o pathfinding, arte propio, soporte de mando, menú de ajustes, shaders y partículas. La exportación a Windows es opcional al final.

## Ideas post-MVP
Coyote time y jump buffer, pisar slimes para eliminarlos, checkpoints, un segundo nivel con un autoload para el puntaje, parallax y vidas.
