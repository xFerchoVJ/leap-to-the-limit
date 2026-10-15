# Progreso de aprendizaje — Salto al Límite

**Estados:** `No iniciado` · `En progreso` · `Completado` · `Requiere repaso`

> Una tarea pasa a `Completado` solo cuando yo lo confirmo o cuando verificamos el resultado juntos. No se asume que entiendo un concepto solo porque el juego corre.

## Resumen
| ID | Tarea | Fase | Estado |
|---|---|---|---|
| T01 | Proyecto pixel art | M0 | Completado |
| T02 | Escena Player | M1 | Completado |
| T03 | TileSet 16x16 y suelo mínimo | M1 | Completado |
| D01 | Cuarto de pruebas (delegada) | M1 | Completado |
| T04 | Gravedad | M1 | Completado |
| T05 | Movimiento horizontal | M1 | Completado |
| T06 | Salto | M1 | No iniciado |
| T07 | Salto variable | M1 | No iniciado |
| T08 | Animaciones | M1 | No iniciado |
| T09 | Camera2D | M1 | No iniciado |
| T10 | Plataformas one-way | M2 | No iniciado |
| C01 | Medir el alcance del salto | M2 | No iniciado |
| D02 | Layout del nivel principal (delegada) | M2 | No iniciado |
| T11 | Moneda animada | M3 | No iniciado |
| T12 | HUD de puntaje | M3 | No iniciado |
| T13 | Escena Slime | M4 | No iniciado |
| T14 | Patrulla con RayCast2D | M4 | No iniciado |
| T15 | Muerte y reinicio con Timer | M4 | No iniciado |
| T16 | Kill zone | M4 | No iniciado |
| T17 | Plataforma móvil | M5 | No iniciado |
| T18 | Recorrido configurable | M5 | No iniciado |
| D03 | Poblar el nivel (delegada) | M5 | No iniciado |
| T19 | Meta y victoria | M6 | No iniciado |
| T20 | Pantalla de victoria y menú principal | M6 | No iniciado |
| T21 | Efectos de sonido | M7 | No iniciado |
| T22 | Música de fondo | M7 | No iniciado |
| C02 | Revisión final | M7 | No iniciado |

## Detalle por tarea
Plantilla (se copia a cada tarea cuando se empieza):

```
### Txx — Título
- **Estado:** No iniciado
- **Fechas:** inicio / fin
- **Qué aprendí:**
- **Qué implementé por mi cuenta:**
- **Trabajo delegado:** (si aplica)
- **Dificultades:**
- **Dudas pendientes o conceptos por reforzar:**
- **Verificación o evidencia:**
```

### T01 — Proyecto pixel art
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** el viewport (320x180) es la resolución lógica del juego y el window override (1280x720) es el tamaño real de la ventana; Godot escala x4. El filtro Nearest evita que los píxeles se difuminen al escalar.
- **Qué implementé por mi cuenta:** viewport y override, filtro Nearest por defecto, carpetas `scenes/`, `scripts/` y `ui/`, y los nombres de physics layers (`world`, `player`, `enemy`, `pickup`).
- **Trabajo delegado:** ninguno.
- **Dificultades:** al principio las physics layers no se guardaron en `project.godot`; se corrigieron al revisar.
- **Dudas pendientes o conceptos por reforzar:** qué hacen `stretch/mode="canvas_items"` y `aspect="expand"`, que quedaron configurados.
- **Verificación o evidencia:** `project.godot` revisado (valores y `[layer_names]`); el sprite de prueba se ve nítido al ejecutarlo.

### T02 — Escena Player
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** una escena es un árbol de nodos reutilizable; lo visual (`AnimatedSprite2D`) y lo físico (`CollisionShape2D`) son nodos separados. El sprite no participa en la física: la colisión decide dónde choca el cuerpo, y en el suelo importa el borde inferior de la forma. El origen de la escena queda en la esquina superior izquierda al ejecutarla con F6.
- **Qué implementé por mi cuenta:** `scenes/player.tscn` con raíz `Player` (`CharacterBody2D`, layer `player`, mask `world`), `AnimatedSprite2D` con `idle` (4 frames de 32x32, 8 FPS, autoplay) y `CollisionShape2D` de 12x14 en `(0, 5)`, alineada con los pies.
- **Trabajo delegado:** ninguno.
- **Dificultades:** al principio no tenía claro el ejercicio de predicción y que el jugador se vea en la esquina al ejecutar la escena sola.
- **Dudas pendientes o conceptos por reforzar:** comprobar en T04 que los pies quedan apoyados en el suelo sin flotar ni hundirse.
- **Verificación o evidencia:** `player.tscn` revisado (nodos, layer, regiones del atlas, forma y posición de la colisión). Confirmado por mí. No se revisó captura de la colisión sobre el sprite.

### T03 — TileSet 16x16 y suelo mínimo
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** el `TileSet` divide el atlas en una cuadrícula de tiles de 16x16 y cada tile tiene sus propias propiedades. Un tile sin polígono de colisión solo se dibuja: el jugador lo atraviesa. En el suelo estático basta la layer (`world`); la mask del `TileSet` puede ser 0 porque quien detecta es el jugador.
- **Qué implementé por mi cuenta:** `scenes/test_room.tscn` con `TileMapLayer`, `TileSet` sobre `world_tileset.png`, physics layer 0 en `world` (mask 0), polígonos de colisión en los bloques sólidos (columnas 0–8, filas 0–2 del atlas) y un suelo pintado.
- **Trabajo delegado:** ajustes menores autorizados por mí: renombrar la raíz a `TestRoom` y borrar los polígonos de las casillas de cuerda (columnas 9–11, filas 0–2), que quedan como decoración hasta T10.
- **Dificultades:** al principio la escena se llamó `test_scene.tscn` y la mask del `TileSet` estaba en 2; ya corregidos.
- **Dudas pendientes o conceptos por reforzar:** las cuerdas podrían ser plataformas one-way en T10; el suelo tiene varias filas con huecos, D01 lo puede ordenar.
- **Verificación o evidencia:** `test_room.tscn` revisado (27 polígonos, solo en bloques sólidos); probé con F6 y *Visible Collision Shapes* y la colisión solo cubre el suelo. No se revisó captura.

### D01 — Cuarto de pruebas (delegada)
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** si una escena está abierta en el editor y se modifica el archivo por fuera, Godot puede sobrescribirlo al guardar; hay que recargar desde disco (o cerrar sin guardar) antes de seguir.
- **Qué implementé por mi cuenta:** nada; es contenido delegado.
- **Trabajo delegado:** reescribí `tile_map_data` del `TileMapLayer` en `scenes/test_room.tscn` (71 tiles, con los tiles que ya había configurado): suelo plano, escalones de 1, 2 y 3 tiles (x 4–9), hueco de 3 tiles (x 12–14) y pared de 5 tiles de alto (x 18–19). No se tocaron el `TileSet`, `player.tscn`, scripts ni `project.godot`. La primera escritura se perdió porque el editor guardó encima y hubo que reaplicarla.
- **Dificultades:** el editor sobrescribió el archivo la primera vez.
- **Dudas pendientes o conceptos por reforzar:** las medidas finales se ajustan en C01 tras medir el salto.
- **Verificación o evidencia:** se decodificó `tile_map_data` y coincide con el esquema; confirmé en el editor que el mapa se ve como se esperaba. La colisión se probará con el jugador en T04.

### T04 — Gravedad
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** la gravedad es una aceleración: cambia `velocity` cada frame y `move_and_slide()` convierte la velocidad en movimiento. En el suelo, la colisión cancela la velocidad hacia abajo; el `if not is_on_floor()` evita que se acumule. Sin `delta` el paso de gravedad es ~60 veces mayor y depende de los FPS.
- **Qué implementé por mi cuenta:** instancié `player.tscn` en `test_room.tscn` (en el aire) y escribí `scripts/player.gd` con `_physics_process`. Mi primera versión usaba `velocity = gravedad * delta` en el suelo, lo que borra todo el vector (incluido `velocity.x`); pedí la solución y quedó `if not is_on_floor(): velocity += get_gravity() * delta` + `move_and_slide()`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** confundí `=` con `+=` y atribuí la parada del jugador a la gravedad, no a `move_and_slide()` contra la colisión.
- **Dudas pendientes o conceptos por reforzar:** no reporté el resultado del experimento sin `delta`; repasarlo en T05. Reforzar que la colisión (no el `if`) detiene al jugador.
- **Verificación o evidencia:** `scripts/player.gd` revisado; probé en F6: el caballero cae, aterriza en el suelo y cae por el hueco.

### T05 — Movimiento horizontal
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** el Input Map nombra acciones y las separa de las teclas; `Input.get_axis` devuelve -1, 0 o 1 (A y D a la vez dan 0); `velocity.x` lo manda el input y `velocity.y` la gravedad. Sin un `else` que ponga `velocity.x` en 0, el personaje seguiría deslizándose con el último valor.
- **Qué implementé por mi cuenta:** acciones `move_left` y `move_right` (A/D y flechas, con `physical_keycode`), `@export` de velocidad, asignación de `velocity.x` con `get_axis`, frenado instantáneo y volteo del sprite con `flip_h`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** comentarios de dirección invertidos en el código; la variable exportada se llamó `SPEED` en lugar de `speed`.
- **Dudas pendientes o conceptos por reforzar:** frenado suave con `move_toward` (opcional); experimento de quitar `delta` pendiente desde T04.
- **Verificación o evidencia:** `scripts/player.gd` y Input Map revisados en `project.godot`; probé en F6: corre a ambos lados, se detiene al soltar, no atraviesa pared ni escalones y cae por el hueco.

*(Las secciones por tarea se añaden aquí conforme se trabajan.)*
