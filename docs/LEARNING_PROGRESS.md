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
| T06 | Salto | M1 | Completado |
| T07 | Salto variable | M1 | Completado |
| T08 | Animaciones | M1 | Completado |
| T09 | Camera2D | M1 | Completado |
| T10 | Plataformas one-way | M2 | Completado |
| C01 | Medir el alcance del salto | M2 | Completado |
| D02 | Layout del nivel principal (delegada) | M2 | Completado |
| T11 | Moneda animada | M3 | Completado |
| T12 | HUD de puntaje | M3 | Completado |
| T13 | Escena Slime | M4 | Completado |
| T14 | Patrulla con RayCast2D | M4 | Completado |
| T15 | Muerte y reinicio con Timer | M4 | Completado |
| T16 | Kill zone | M4 | Completado |
| T17 | Plataforma móvil | M5 | Completado |
| T18 | Recorrido configurable | M5 | Completado |
| D03 | Poblar el nivel (delegada) | M5 | Completado |
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

### T06 — Salto
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** un salto es asignar de golpe una velocidad negativa en Y (el eje Y de Godot apunta hacia abajo) y dejar que la gravedad la frene. `is_action_just_pressed` es verdadero solo en el frame de la pulsación; `is_action_pressed` lo es mientras la tecla siga abajo y haría rebotar al personaje. El salto no lleva `delta` porque se asigna una sola vez; `velocity` persiste entre frames y `move_and_slide()` aplica el `delta`. Todo lo que modifica `velocity` va antes de `move_and_slide()`.
- **Qué implementé por mi cuenta:** acción `jump` (Space, con `physical_keycode`), `@export var jump_velocity: float = -250` y la condición `is_on_floor() and Input.is_action_just_pressed("jump")` que asigna `velocity.y = jump_velocity`. Moví el bloque del salto antes de `move_and_slide()` y cambié `+=` por `=`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** el salto quedó primero después de `move_and_slide()` (se aplicaba un frame tarde) y usé `+=` en lugar de `=`.
- **Dudas pendientes o conceptos por reforzar:** con `-250` el hueco de 3 tiles se cruza por muy poco; medir el alcance real en C01. Siguen pendientes el experimento sin `delta` (T04) y el frenado suave con `move_toward` (opcional).
- **Verificación o evidencia:** `scripts/player.gd` y la acción `jump` en `project.godot` revisados; probé en F6: un salto por pulsación, no salta en el aire, mantener la tecla no rebota, conserva el movimiento horizontal y cruza el hueco por poco.

### T07 — Salto variable
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** al soltar la tecla de salto mientras sube (`velocity.y < 0`) se recorta la velocidad ascendente y la gravedad hace el resto; así la altura depende de cuánto se mantiene la tecla (*game feel*). `velocity.y` ya no vale -250 a mitad del salto porque la gravedad la va acercando a 0 en cada frame. Multiplicar por un factor suaviza el corte, mientras que `velocity.y = 0` lo frena en seco. La condición `velocity.y < 0` evita alterar la caída: sin ella, soltar la tecla cayendo frenaría al personaje en el aire.
- **Qué implementé por mi cuenta:** `@export var jump_cut_factor: float = 0.5` y el bloque `if Input.is_action_just_released("jump") and velocity.y < 0` antes de `move_and_slide()`. Mi primera versión usaba `velocity *= jump_cut_factor`; lo corregí a `velocity.y *= jump_cut_factor` al notar que también recortaba `velocity.x`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** multiplicar el vector completo en vez de solo la componente Y (el error se corregía solo en el frame siguiente porque `velocity.x` se reasigna cada frame, por eso casi no se notaba). Al predecir, supuse que `velocity.y` seguía en -400 tras soltar la tecla.
- **Dudas pendientes o conceptos por reforzar:** un bug que "se arregla solo" se vuelve visible si `velocity.x` llegara a tener inercia (por ejemplo con `move_toward`). Siguen pendientes el experimento sin `delta` (T04) y el frenado suave (opcional).
- **Verificación o evidencia:** `scripts/player.gd` revisado (línea 29 usa `velocity.y`); probé en F6: toque corto y tecla mantenida dan dos alturas claramente distintas. Confirmado por mí.

### T08 — Animaciones
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** la animación se deduce cada frame del estado (aire antes que suelo; en el aire, el signo de `velocity.y` separa `jump` de `fall`). `play()` con la animación que ya se reproduce no la reinicia, por eso es seguro llamarlo cada frame. Evaluar `velocity.x` después de `move_and_slide()` refleja lo que realmente pasó: contra una pared vale 0 y se ve `idle`; usar `direction` reflejaría lo que el jugador quiere. `flip_h` solo cambia con input, así que conserva la dirección al detenerse.
- **Qué implementé por mi cuenta:** animaciones `run` (16 frames, filas y=64 y y=96, 10 FPS), `jump` y `fall` de 1 frame en `SpriteFrames`, y la selección de animación en `_physics_process` con `is_on_floor()` y `velocity.y`.
- **Trabajo delegado:** a petición mía, Claude cambió el frame de `fall` en `scenes/player.tscn` (línea 8) de `Rect2(96, 224, 32, 32)` (caballero tumbado de `DEATH`) a `Rect2(64, 160, 32, 32)` (frame de `ROLL` inclinado). Nada más.
- **Dificultades:** elegí por error un frame de `DEATH` para `fall`; en la predicción creí que `play()` repetido reinicia la animación (no lo hace).
- **Dudas pendientes o conceptos por reforzar:** contra una pared se ve `idle` porque la condición usa `velocity.x`; si luego molesta, cambiar a `direction`. `jump` usa un frame de `run`, mejorable si hace falta. Siguen pendientes el experimento sin `delta` (T04) y el frenado suave (opcional).
- **Verificación o evidencia:** `scripts/player.gd` y `player.tscn` revisados; probé en F6 las cuatro animaciones y la dirección al detenerme. Confirmado por mí.

### T09 — Camera2D
- **Estado:** Completado
- **Fechas:** 2026-10-15 / 2026-10-15
- **Qué aprendí:** una `Camera2D` hija del jugador lo sigue sin código. `position_smoothing` hace que la cámara lo persiga con retraso y evita tirones. Los límites son coordenadas del mundo en píxeles; se calculan con el **conteo** de tiles × 16 (la última fila 10 son 11 filas, 176 px), no con el índice del último tile. Si el rango de los límites es más chico que el viewport (176 < 180), Godot no puede respetarlos y se ve un pequeño vacío; en un nivel más grande que la pantalla no pasa.
- **Qué implementé por mi cuenta:** `Camera2D` como hija de `Player` en `player.tscn`, con suavizado activado y límites `Left` 0, `Top` 0, `Right` 320 y `Bottom` 176 (calculé yo los dos últimos).
- **Trabajo delegado:** ninguno. Claude decodificó el `tile_map_data` para darme la extensión del mapa (columnas 0–19, filas 4–10).
- **Dificultades:** al principio no entendía qué eran los límites; se aclaró con el diagrama del conteo de tiles frente al índice.
- **Dudas pendientes o conceptos por reforzar:** en `test_room` el mundo mide lo mismo que la pantalla de ancho, así que la cámara no se desplaza horizontalmente; los límites se verán de verdad en `level_01`. Siguen pendientes el experimento sin `delta` (T04) y el frenado suave (opcional).
- **Verificación o evidencia:** `scenes/player.tscn` revisado (líneas 200–205); probé en F6: el suavizado se nota sin límites, con límites no aparece vacío a los lados y se ve un vacío pequeño abajo, explicado por el rango de 176 px. Confirmado por mí.

### T10 — Plataformas one-way
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** la colisión one-way es una propiedad del polígono de cada tile en el `TileSet` (casilla `one_way`), no del jugador ni del `TileMapLayer`; por eso un mismo `TileSet` mezcla tiles sólidos y one-way sin tocar `player.gd`. El grosor del polígono no decide el sentido: incluso un tile completo se atraviesa desde abajo. La franja delgada solo sirve para que el jugador quede alineado con el dibujo.
- **Qué implementé por mi cuenta:** polígono de franja delgada (~2.5 px, arriba del tile) con `one_way = true` en los tiles de cuerda `(10,0)`, `(10,1)` y `(10,2)` del atlas, y plataformas pintadas en `test_room.tscn`: tres en fila sobre el hueco, `(15,6)` y `(17,5)`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** mi predicción inicial fue incorrecta: pensé que un polígono completo bloquearía desde abajo aunque fuera one-way. Quedó aclarado.
- **Dudas pendientes o conceptos por reforzar:** el borde superior del polígono quedó con una inclinación de 0.18 px (puntos `-5.935` y `-6.115`); es cosmético y puede igualarse con snap. El alcance real del salto se medirá en C01.
- **Verificación o evidencia:** `scenes/test_room.tscn` revisado (solo los tres tiles de cuerda tienen `one_way`; suelo y paredes sin cambios); probé en F6: atravieso desde abajo, aterrizo encima, llego a las plataformas y el suelo sigue bloqueando. Confirmado por mí.

### C01 — Medir el alcance del salto
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** el alcance sale de `jump_velocity` (-250), la gravedad (980 px/s²) y `speed` (80). Altura: `v² / (2g) ≈ 32 px`, unos 2 tiles. Hueco: ~41 px de recorrido del centro durante ~0.51 s en el aire, más hasta 12 px por el ancho del cuerpo (12 px) y `is_on_floor()` en el borde, ~53 px: unos 3 tiles, pero con margen de pocos frames. Con `Editable Children` se cambia un nodo interno de una instancia (la `Camera2D` del jugador) sin tocar `player.tscn`.
- **Qué implementé por mi cuenta:** medí el salto completo en `jump_test.tscn`, movi al jugador pasado el pilar de 3 tiles y arreglé los límites de la cámara.
- **Trabajo delegado:** `scenes/jump_test.tscn` (escena nueva con escalones de 1, 2 y 3 tiles, huecos de 2, 3 y 4, y `TileSet` copiado de `test_room`). El pilar de 3 tiles bloqueaba el acceso a los huecos y el override de cámara no se guardó; ambos se corrigieron en el editor.
- **Resultados:** altura máxima **2 tiles** (el de 3 no); hueco máximo **3 tiles**, apenas (el de 4 no). Mi predicción: altura 2 ✅, hueco 2 ❌ (la cuenta daba 3). Predicción de Claude: altura 2 ✅, hueco 3 ✅.
- **Valores de diseño (80%):** altura **1 tile** normal (2 solo como reto); hueco **2 tiles** como máximo (el de 3 queda fuera). Confirmado por mí.
- **Dudas pendientes o conceptos por reforzar:** si cambia `jump_velocity` hay que remedir. El salto corto de T07 no se midió.
- **Verificación o evidencia:** probé en F6 con `jump_test.tscn`: escalones 1 y 2 sí, 3 no; huecos de 2 y 3 sí (el de 3 apenas), el de 4 no. Confirmado por mí.

### D02 — Layout del nivel principal (delegada)
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** separar la decoración en un `TileMapLayer` aparte (`Decor`, sin colisión, detrás de `Terrain`) permite editar los adornos sin tocar la colisión. Los límites de cámara por instancia se guardan con `Editable Children` (`[editable path="Player"]`). Un nivel con 12 filas (192 px) evita el vacío que se veía con 11 (176 < 180).
- **Qué implementé por mi cuenta:** nada; es contenido delegado. Yo aprobé la propuesta (80×12, jugador incluido, decoración con los tiles de arbolitos).
- **Trabajo delegado:** `scenes/level_01.tscn` (nuevo): 80×12 tiles (1280×192 px), `TileSet` copiado sin cambios, capas `Decor` y `Terrain`, jugador instanciado y `Camera2D` con `limit_right = 1280` y `limit_bottom = 192`. Cinco zonas (calentamiento, huecos, plataformas one-way, descenso y tramo final), muros de borde en las columnas 0 y 79 y 28 tiles de decoración. Sin monedas ni enemigos.
- **Dificultades:** ninguna; apliqué lo aprendido en `jump_test.tscn` (el override de la cámara con `[editable path="Player"]`).
- **Dudas pendientes o conceptos por reforzar:** las medidas de C01 (escalones de 1 tile, huecos de 2) se respetan, pero la comodidad de cada salto es subjetiva y se ajustará al jugar. La meta y la plataforma móvil llegan en D03/T17/T19.
- **Verificación o evidencia:** se decodificó `tile_map_data`: ningún escalón supera 1 tile, ningún hueco pasa de 2, los tiles de `Decor` existen en el `TileSet`, no tienen colisión y no solapan el terreno. Probé en F5/F6 y se ve y se juega bien. Confirmado por mí.

### T11 — Moneda animada
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** un `Area2D` detecta cuerpos sin bloquearlos y avisa con `body_entered`. Hay dos filtros: la mask (física, la hace el motor) y el grupo (en el script); es como un `WHERE` frente a filtrar en Ruby. Si la mask incluyera `world`, el `TileMapLayer` también dispararía `body_entered`, pero el grupo lo descartaría. La señal `collected` se emite antes de `queue_free()` para que quien escuche (el HUD, en T12) se entere; la moneda no sabe quién escucha ("signal up").
- **Qué implementé por mi cuenta:** `scenes/coin.tscn` (`Area2D` en la layer `pickup`, mask `player`, `AnimatedSprite2D` con 12 frames de 16x16 a 8 fps en bucle con autoplay, colisión circular de radio ~4 px), `scripts/coin.gd` (señal tipada `collected`, comprobación del grupo `player`, `emit` y `queue_free()`), el grupo `player` en `player.tscn` y una moneda de prueba en `test_room.tscn`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** ninguna relevante. Mis predicciones: con `world` en la mask "sigue igual" (casi: el grupo descarta el suelo) y sin `emit` nadie se entera (correcto).
- **Dudas pendientes o conceptos por reforzar:** quitar el `print` de depuración cuando el HUD (T12) conecte `collected`. El radio 4.12 podría redondearse.
- **Verificación o evidencia:** `coin.tscn`, `coin.gd` y `player.tscn` revisados (layers, 12 regiones, señal y conexión). Probé en F6 en `test_room.tscn`: la moneda gira, desaparece una sola vez al tocarla y no se recoge si no la toco. Confirmado por mí.

### T12 — HUD de puntaje
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** un `CanvasLayer` se dibuja en coordenadas de pantalla, así que el HUD no se mueve con la cámara. `LabelSettings` guarda fuente y tamaño de un `Label` y se puede reutilizar. "Call down, signal up": el nivel escucha `collected` de cada moneda (hacia arriba) y llama a `hud.update_label()` (hacia abajo); el nivel guarda el estado y el HUD solo lo muestra. Para pixel art la fuente debe usar un tamaño múltiplo de su tamaño base (8 o 16 en `PixelOperator8`) y desactivar el antialiasing en la pestaña *Import* (con *Reimport*), no en el `Label`.
- **Qué implementé por mi cuenta:** `scenes/hud.tscn` (`CanvasLayer` + `Label` con `LabelSettings` y `PixelOperator8`, tamaño 8), `scripts/hud.gd` (`update_label(qty)`), `scripts/level_01.gd` (contador, conexión de las monedas del grupo `coins`), 9 monedas colocadas por mí en `level_01.tscn`, el grupo `coins` en `coin.tscn` y el antialiasing de la fuente desactivado.
- **Trabajo delegado:** ninguno.
- **Dificultades:** no encontraba dónde quitar el antialiasing; está en el panel *Import* de la fuente. Mis predicciones: el label se queda atrás sin `CanvasLayer` (correcto) y el contador vive en el nivel porque coordina (correcto).
- **Dudas pendientes o conceptos por reforzar:** tipar mejor `hud` y `coin.collected` (por ejemplo con `class_name`) si luego se quiere más seguridad; renombrar `collected_coins` a `score` es cuestión de gusto.
- **Verificación o evidencia:** `hud.tscn`, `hud.gd`, `level_01.gd`, `coin.tscn` y `level_01.tscn` revisados (nueve monedas con grupo, cámara conservada). Probé en F6 en `level_01.tscn`: el HUD sube de 1 en 1, se queda fijo con la cámara y la fuente se ve nítida. Confirmado por mí.

### T13 — Escena Slime
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** la escena de un enemigo repite la estructura del jugador: `CharacterBody2D` + `AnimatedSprite2D` + `CollisionShape2D`. Sin gravedad un `CharacterBody2D` se queda en el aire; sin `world` en la mask atraviesa el suelo y cae sin fin. La layer dice qué es el cuerpo y la mask qué escanea. El valor de `collision_layer` es el bit (layer 3 `enemy` = 4), y si la mask no aparece en el `.tscn` vale el valor por defecto (1 = `world`).
- **Qué implementé por mi cuenta:** `scenes/slime.tscn` (raíz `Slime`, layer `enemy`, mask `world`, `AnimatedSprite2D` con `idle` de 4 frames de 24x24 a 8 FPS en bucle con autoplay, colisión de 14x12 en `(0, 6)`), `scripts/slime.gd` con la gravedad de T04 y una instancia de prueba en `test_room.tscn`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** ninguna relevante. Mis predicciones (sin gravedad se queda en el aire, sin mask atraviesa los tiles) fueron correctas.
- **Dudas pendientes o conceptos por reforzar:** no respondí por qué el jugador no choca físicamente con el slime ni qué nodo detectará el contacto en T15 (un `Area2D`); retomarlo ahí. `speed` está sin tipo y sin usar; tiparlo en T14. Confirmar que la mask `world` es explícita en el Inspector.
- **Verificación o evidencia:** `slime.tscn` y `slime.gd` revisados (layer 4, frames, colisión alineada con el borde inferior). Probé en F6: el slime cae, aterriza, se queda quieto y se anima. Confirmado por mí.

### T14 — Patrulla con RayCast2D
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** un `RayCast2D` es un rayo que solo consulta (`is_colliding()`), no bloquea nada. Se adelanta del cuerpo para detectar el borde antes de que el slime quede colgando, y debe moverse al otro lado al voltear (si no, mira hacia atrás y el slime cae por el borde contrario). Patrullar por el entorno reemplaza el recorrido por distancia de Coin Collector. `is_on_wall()` solo es válido después de `move_and_slide()`. "El rayo no choca" es ambiguo en el aire (borde o caída), por eso el giro se condiciona a `is_on_floor()`.
- **Qué implementé por mi cuenta:** `RayCast2D` en `(8, 0)` con `target_position (0, 15)` (mask `world`), `scripts/slime.gd` con dirección, `speed` tipado, `flip_character()` (invierte dirección, `flip_h` y `position.x` del rayo) y el grupo `enemies` en `slime.tscn`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** mi primera versión volteaba también mientras caía (el rayo no choca en el aire); lo resolví encerrando el giro en `if is_on_floor()`. Mis predicciones sobre el rayo en el centro y sin mover el raycast fueron correctas en lo esencial.
- **Dudas pendientes o conceptos por reforzar:** mientras cae, el slime conserva `velocity.x` (decisión de diseño aceptada). Una pared en el aire no lo hace girar. Sigue pendiente la pregunta de T13 sobre qué nodo detecta el contacto con el jugador (T15).
- **Verificación o evidencia:** `slime.gd` y `slime.tscn` revisados. Probé en F6: cae desde el aire sin girar de más, recorre una plataforma de lado a lado sin caerse y se voltea contra una pared. Confirmado por mí.

### T15 — Muerte y reinicio con Timer
- **Estado:** Completado
- **Fechas:** 2026-10-16 / 2026-10-16
- **Qué aprendí:** "slime avisa, nivel decide, jugador reacciona": el slime emite `hit_player`, el nivel llama a `player.die()` y el jugador cambia su propio estado. `body_entered` se dispara al entrar, no cada frame; sin bandera, varias llamadas lanzarían varios `await` y varios `reload_current_scene()`. `await get_tree().create_timer(1.0).timeout` pausa solo esa función. Si se reinicia sin esperar, la animación de muerte no llega a verse.
- **Qué implementé por mi cuenta:** `HitArea` (`Area2D`, layer `enemy`, mask `player`, forma 8x6) en `slime.tscn`, señal `hit_player` en `slime.gd`, `die()` con bandera `is_dead` y `set_physics_process(false)` en `player.gd`, animación `die` (sin bucle) en `player.tscn`, y en `level_01.gd` la conexión de los `enemies`, la espera de 1 s y `reload_current_scene()`. Un slime colocado en `level_01.tscn`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** ninguna relevante. Mis predicciones (N llamadas sin bandera; sin espera no se ve la animación) fueron correctas.
- **Dudas pendientes o conceptos por reforzar:** (1) revisar los frames de `die`: usan la fila HIT (y=192) y un frame de ROLL `(96,160)`; la fila DEATH está en y=224. (2) `set_physics_process(false)` deja al jugador flotando si muere en el aire; no reporté cómo se ve ni si quiero cambiarlo. (3) No respondí por qué el jugador no choca físicamente con el slime (un `Area2D` detecta sin bloquear). (4) Quedó guardado en `player.tscn` `animation = die`/`frame = 3` del editor; limpiar antes del commit.
- **Verificación o evidencia:** `slime.gd`, `slime.tscn`, `player.gd`, `level_01.gd` y los diffs de las escenas revisados. Probé en F6 en `level_01.tscn`: la muerte, la espera y el reinicio funcionan. Confirmado por mí.

### T16 — Kill zone
- **Estado:** Completado
- **Fechas:** 2026-10-17 / 2026-10-17
- **Qué aprendí:** un `Area2D` ancho debajo del nivel sirve como zona de muerte. La kill zone solo avisa (`hit_player`) y reutiliza la ruta de muerte del nivel, sin duplicar lógica. No necesita estar en ninguna layer: un `Area2D` detecta con su mask, y no hace falta que el jugador la detecte a ella.
- **Qué implementé por mi cuenta:** `scenes/kill_zone.tscn` (`Area2D`, mask `player`, forma 1515x20), `scripts/kill_zone.gd` con la señal `hit_player` y el filtro por grupo `player`, una instancia en `level_01.tscn` y su conexión a `_on_die_player` en `level_01.gd`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** ninguna relevante. Mi respuesta de repaso (la zona solo necesita detectar al jugador con su mask) fue correcta.
- **Dudas pendientes o conceptos por reforzar:** pendiente limpiar el cambio del editor en `player.tscn` (`animation`/`frame`) antes del commit.
- **Verificación o evidencia:** `kill_zone.gd`, `kill_zone.tscn`, `level_01.gd` y `level_01.tscn` revisados. Probé en F6: al caer por ambos bordes hay animación `die`, pausa de ~1 s y reinicio una sola vez, sin errores. Confirmado por mí.

### T17 — Plataforma móvil
- **Estado:** Completado
- **Fechas:** 2026-10-17 / 2026-10-17
- **Qué aprendí:** un `AnimatableBody2D` se mueve y arrastra lo que lo pisa; un `StaticBody2D` movido a mano no. Una pista de `position` en el nodo que también colocas en el nivel sobrescribe su posición (valores absolutos), así que se separa un ancla `Node2D` (se coloca) del `AnimatableBody2D` (se anima, relativo al padre). `sync_to_physics` aplica el movimiento dentro del paso de física, para que el motor conozca la velocidad de la plataforma y `move_and_slide()` arrastre al jugador.
- **Qué implementé por mi cuenta:** `scenes/moving_platform.tscn` (`Node2D` > `AnimatableBody2D` con `Sprite2D` y colisión one-way de 18x3, más `AnimationPlayer` con la animación `move` en bucle y autoplay), y una instancia en `test_room.tscn`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** la instancia aparecía en `(0, 0)` porque la animación pisaba `position`; lo diagnostiqué y lo resolví reestructurando los nodos.
- **Dudas pendientes o conceptos por reforzar:** no supe responder por qué mover un `AnimatableBody2D` en `_process` falla (frame de dibujo vs. paso de física); se explicó, pendiente de reforzar. El `Sprite2D` (`hframes = 4`, `vframes = 6`) se ve bien; revisado por mí. Recorrido de 20 px en 8 s: se ajusta en T18.
- **Verificación o evidencia:** `moving_platform.tscn` y `test_room.tscn` revisados. Probé en F6 en `test_room.tscn`: subo desde abajo, viajo encima sin patinar y puedo bajar. Confirmado por mí.

### T18 — Recorrido configurable
- **Estado:** Completado
- **Fechas:** 2026-10-18 / 2026-10-18
- **Qué aprendí:** un `Tween` anima una propiedad de forma gradual desde código y se destruye al terminar, salvo que se use `set_loops()`. Los pasos de un Tween se ejecutan en orden (ida y vuelta con dos `tween_property`). `TWEEN_PROCESS_PHYSICS` hace que se actualice en el paso de física, como `sync_to_physics` con el `AnimationPlayer`. `set_trans` y `set_ease` suavizan los extremos. `@export` permite un recorrido distinto por instancia sin tocar el script.
- **Qué implementé por mi cuenta:** `scripts/moving_platform.gd` con `distance` y `duration` exportadas, Tween en bucle con `TRANS_SINE`/`EASE_IN_OUT`, y el cambio de `moving_platform.tscn` (sin `AnimationPlayer`). Dos instancias en `test_room.tscn`.
- **Trabajo delegado:** ninguno.
- **Dificultades:** el avance inicial tenía el destino fijo (`Vector2(400, 300)`), un solo viaje y `distance` sin usar; se corrigió con una guía y ajusté el código.
- **Dudas pendientes o conceptos por reforzar:** la predicción sobre quitar `TWEEN_PROCESS_PHYSICS` queda por comprobar. El recorrido solo es horizontal; uno vertical requeriría una dirección exportada.
- **Verificación o evidencia:** `moving_platform.gd` y `test_room.tscn` revisados. Probé en F6 con dos instancias (60 px / 2 s y 20 px / 5 s) con recorridos distintos. Confirmado por mí.

### D03 — Poblar el nivel (delegada)
- **Estado:** Completado
- **Fechas:** 2026-10-18 / 2026-10-18
- **Qué aprendí:** `level_01.gd` conecta monedas y enemigos por grupo (`coins`, `enemies`), así que las instancias nuevas funcionan sin tocar el script. La posición de una `MovingPlatform` es su punto inicial y se mueve hacia la derecha `distance` px. El alcance del salto (~32 px con `jump_velocity = -250`) limita a qué altura se puede colocar una plataforma (usando ~80% como margen, ~25 px).
- **Qué implementé por mi cuenta:** nada; es contenido delegado. Yo aprobé el plan completo.
- **Trabajo delegado:** solo `scenes/level_01.tscn`: 2 instancias de `moving_platform.tscn` (sobre el hueco de los tiles 56–57, y una ruta alta con 48 px / 2.5 s hacia `Coin10`), `Slime2` y `Slime3` en suelo plano, y `Coin10` y `Coin11`. Sin cambios en scripts, escenas de objetos ni `project.godot`.
- **Dificultades:** ninguna.
- **Dudas pendientes o conceptos por reforzar:** la meta no existe todavía (T19). Las posiciones se pueden ajustar al gusto en el inspector.
- **Verificación o evidencia:** se decodificó `Terrain` para ubicar suelo y huecos; sin `unique_id` duplicados. Probé en F6: ambas plataformas se pueden usar, `Coin10` es alcanzable, los slimes patrullan sin caerse y el HUD cuenta bien. Confirmado por mí.

*(Las secciones por tarea se añaden aquí conforme se trabajan.)*
