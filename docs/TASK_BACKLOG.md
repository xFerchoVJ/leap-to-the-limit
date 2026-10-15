# Backlog de tareas — Salto al Límite

Este backlog es una vista previa para que sepas qué viene. **Las instrucciones detalladas de cada tarea se dan solo cuando vas a trabajarla**; aquí cada tarea trae lo mínimo: objetivo, checklist corto, pistas progresivas, criterios de aceptación, errores comunes y dependencias.

- Tipos: **A** Aprendizaje (tú), **D** Contenido delegado (yo, con tu autorización), **C** Compartido.
- ♻ = repaso de Coin Collector. ★ = concepto nuevo.
- El estado de cada tarea vive en `docs/LEARNING_PROGRESS.md`.
- Las pistas están ordenadas de menos a más reveladoras. Léelas una por una.

---

## M0 — Preparación

### T01 — Proyecto pixel art
- **Tipo:** A · **Esfuerzo:** 20 min · **Depende de:** —
- **Objetivo:** dejar el proyecto listo para pixel art, igual que en Coin Collector T02.
- **Aprendes:** ♻ viewport vs. override de ventana, filtro Nearest.
- **Checklist:**
  - [ ] Viewport lógico de 320x180 y ventana de 1280x720.
  - [ ] Filtro de texturas por defecto en Nearest.
  - [ ] Carpetas `scenes/`, `scripts/` y `ui/`.
  - [ ] Nombrar las physics layers: `world`, `player`, `enemy`, `pickup`.
- **Pistas:** 1) Mira `coin-collector/project.godot`. 2) Project Settings → Display → Window y Rendering → Textures. 3) Los nombres de layers están en Project Settings → Layer Names → 2D Physics.
- **Aceptación:** al ejecutar una escena de prueba, un sprite se ve nítido y no borroso.
- **Errores comunes:** poner 1280x720 en el viewport en lugar de en el override.

---

## M1 — Jugador plataformero

### T02 — Escena Player
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T01
- **Objetivo:** crear `scenes/player.tscn` con el caballero visible y una colisión que coincida con su cuerpo.
- **Aprendes:** ♻ `CharacterBody2D`, `CollisionShape2D`, `AnimatedSprite2D`.
- **Checklist:**
  - [ ] Raíz `CharacterBody2D` en la layer `player`, con mask `world`.
  - [ ] `AnimatedSprite2D` con la animación `idle` (frames de 32x32 de `knight.png`).
  - [ ] `CollisionShape2D` ajustada a los píxeles opacos del personaje, no al frame completo.
- **Pistas:** 1) El `SpriteFrames` recorta el atlas con "Add frames from sprite sheet". 2) El caballero ocupa solo una parte del frame de 32x32; mide dónde. 3) Habilita *Debug → Visible Collision Shapes*.
- **Aceptación:** con F6 se ve el caballero animado y la colisión cubre solo su cuerpo.
- **Errores comunes:** recortar frames con el rótulo de texto de la imagen; una colisión del tamaño de todo el frame.

### T03 — TileSet 16x16 y suelo mínimo
- **Tipo:** A · **Esfuerzo:** 40 min · **Depende de:** T01
- **Objetivo:** crear `scenes/test_room.tscn` con un `TileMapLayer` cuyo `TileSet` tenga colisión en los tiles sólidos.
- **Aprendes:** ♻ `TileSet`, atlas, physics layer.
- **Checklist:**
  - [ ] `TileSet` con tiles de 16x16 sobre `world_tileset.png`.
  - [ ] Physics layer 0 en la layer `world`.
  - [ ] Polígono de colisión en los tiles de suelo y pared.
  - [ ] Pintar solo un suelo plano pequeño.
- **Pistas:** 1) El tamaño de tile por defecto ya es 16x16, pero verifícalo. 2) La colisión se pinta tile por tile en la pestaña *Paint → Physics Layer 0*. 3) El atlas tiene tiles decorativos que no deben chocar.
- **Aceptación:** *Visible Collision Shapes* muestra colisión únicamente en los tiles sólidos.
- **Errores comunes:** olvidar crear la physics layer antes de dibujar el polígono.

### D01 — Cuarto de pruebas *(delegada)*
- **Tipo:** D · **Depende de:** T03
- **Qué hago:** ampliar `test_room.tscn` pintando suelo, dos o tres escalones, una pared y un hueco, con los tiles que ya configuraste.
- **Archivos que tocaría:** solo `scenes/test_room.tscn`.
- **No se toca:** el `TileSet`, scripts, `player.tscn`, `project.godot`.
- **Cómo verificarlo:** abre la escena en Godot y revisa el `TileMapLayer`; puedes mover o borrar tiles. Si hay un ejecutable de Godot a mano, lo valido también por ahí.
- **Requiere:** tu autorización antes de empezar.

### T04 — Gravedad
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T02, D01
- **Objetivo:** que el jugador caiga y aterrice en el suelo del cuarto de pruebas.
- **Aprendes:** ★ gravedad como aceleración, `get_gravity()`, `delta`, `is_on_floor()`.
- **Checklist:**
  - [ ] Instanciar `player.tscn` en `test_room.tscn`.
  - [ ] Script `scripts/player.gd` con `_physics_process(delta)`.
  - [ ] Aplicar gravedad solo cuando no está en el suelo.
  - [ ] Llamar a `move_and_slide()`.
- **Pistas:** 1) La gravedad cambia la **velocidad** cada frame; no mueve la posición directamente. 2) Piensa: ¿qué pasaría con `velocity.y` si la sumas incluso en el suelo? 3) `velocity += get_gravity() * delta`, dentro de una condición con `is_on_floor()`.
- **Aceptación:** el jugador cae, se detiene en el suelo y no atraviesa los tiles.
- **Errores comunes:** olvidar `delta`; la velocidad crece sin parar si no se condiciona al suelo.
- **Predice antes de probar:** ¿qué pasa si quitas el `delta`?

### T05 — Movimiento horizontal
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T04
- **Objetivo:** correr a izquierda y derecha.
- **Aprendes:** ♻ Input Map, ★ `Input.get_axis`.
- **Checklist:**
  - [ ] Acciones `move_left` y `move_right` (con `physical_keycode`, para que A/D funcionen en cualquier teclado).
  - [ ] `@export var speed: float`.
  - [ ] Asignar `velocity.x` según el eje.
- **Pistas:** 1) A diferencia de top-down, aquí solo existe un eje. 2) `Input.get_axis("move_left", "move_right")` devuelve -1, 0 o 1. 3) Si no hay input, ¿a qué valor debería quedar `velocity.x`? Mira `move_toward`.
- **Aceptación:** corre en ambas direcciones y se detiene al soltar la tecla; no se cuela por las paredes.
- **Errores comunes:** usar `Input.get_vector` con un eje de sobra; no frenar al soltar.

### T06 — Salto
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T05
- **Objetivo:** saltar solo cuando está en el suelo.
- **Aprendes:** ★ `is_action_just_pressed`, el eje Y de Godot apunta hacia **abajo**.
- **Checklist:**
  - [ ] Acción `jump`.
  - [ ] `@export var jump_velocity: float`.
  - [ ] Saltar solo si está en el suelo.
- **Pistas:** 1) Un salto es darle de golpe una velocidad hacia arriba. 2) Arriba es negativo en Y. 3) Distingue "se presionó este frame" de "está presionada".
- **Aceptación:** un salto por pulsación; no se puede saltar en el aire ni mantener la tecla para rebotar.
- **Errores comunes:** velocidad Y positiva (el personaje se hunde); usar `is_action_pressed`.

### T07 — Salto variable
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T06
- **Objetivo:** que un toque corto dé un salto bajo y mantener la tecla dé un salto alto.
- **Aprendes:** ★ `is_action_just_released`, *game feel* (la sensación al controlar).
- **Checklist:**
  - [ ] Detectar que se soltó la tecla de salto mientras sube.
  - [ ] Recortar la velocidad hacia arriba.
- **Pistas:** 1) Se corta el salto "frenando" la subida. 2) Solo tiene sentido si `velocity.y` es negativa. 3) Multiplicar por un factor menor a 1 suaviza el corte.
- **Aceptación:** dos alturas de salto claramente distintas.
- **Errores comunes:** poner `velocity.y = 0` mientras cae.

### T08 — Animaciones
- **Tipo:** A · **Esfuerzo:** 40 min · **Depende de:** T06
- **Objetivo:** `idle`, `run`, `jump` y `fall`, y que el personaje mire hacia donde corre.
- **Aprendes:** ♻ `SpriteFrames`, `flip_h`; ★ elegir la animación según el estado aéreo.
- **Checklist:**
  - [ ] Animaciones `idle` y `run` desde `knight.png`; `jump` y `fall` con un frame cada una.
  - [ ] Elegir la animación con `is_on_floor()` y el signo de `velocity.y`.
  - [ ] `flip_h` solo cuando hay input horizontal.
- **Pistas:** 1) Prioridad: aire antes que suelo. 2) Subir es `velocity.y < 0`. 3) Repite el patrón de `flip_h` de Coin Collector T05.
- **Aceptación:** las cuatro animaciones se ven en su momento y el sprite conserva su dirección al detenerse.
- **Errores comunes:** que `flip_h` se resetee al quedar quieto.

### T09 — Camera2D
- **Tipo:** A · **Esfuerzo:** 25 min · **Depende de:** T05
- **Objetivo:** una cámara que siga al jugador sin saltos bruscos y sin salirse del nivel.
- **Aprendes:** ♻ `Camera2D` y límites; ★ `position_smoothing`.
- **Checklist:**
  - [ ] `Camera2D` como hija del jugador.
  - [ ] Activar el suavizado.
  - [ ] Límites en píxeles del mundo.
- **Pistas:** 1) Los límites son conteos de tiles × 16, no el índice del último tile. 2) Mira Coin Collector T08. 3) Pruébalo corriendo hasta los bordes.
- **Aceptación:** la cámara sigue con suavidad y no muestra el vacío fuera del mapa.
- **Errores comunes:** límites calculados con el índice en vez del conteo.

---

## M2 — Nivel

### T10 — Plataformas one-way
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T06
- **Objetivo:** plataformas que se atraviesan desde abajo y sostienen desde arriba.
- **Aprendes:** ★ *one-way collision* (colisión de un solo sentido).
- **Checklist:**
  - [ ] Elegir tiles de plataforma del atlas.
  - [ ] Activar one-way en su polígono de colisión.
  - [ ] Probarlas en `test_room.tscn`.
- **Pistas:** 1) Es una propiedad del polígono de colisión del tile. 2) La colisión debe ser delgada, solo la parte superior. 3) Ya puedes saltar para atravesarlas desde abajo.
- **Aceptación:** subes saltando desde abajo y aterrizas encima.
- **Errores comunes:** one-way activado en tiles de suelo normales.

### C01 — Medir el alcance del salto
- **Tipo:** C · **Esfuerzo:** 20 min · **Depende de:** T07
- **Objetivo:** saber cuántos tiles de altura y de distancia alcanza tu salto, para que yo pueda diseñar un nivel alcanzable.
- **Checklist:** [ ] En el cuarto de pruebas, probar escalones y huecos de distintos tamaños. [ ] Anotar la altura máxima y el hueco máximo cruzable, en tiles. [ ] Dejar un margen de seguridad (usa ~80% del máximo para el diseño).
- **Aceptación:** dos números anotados en `LEARNING_PROGRESS.md`.

### D02 — Layout del nivel principal *(delegada)*
- **Tipo:** D · **Depende de:** C01, T10
- **Qué hago:** crear `scenes/level_01.tscn` con un `TileMapLayer` (reutilizando tu `TileSet`) y pintar el terreno y las plataformas respetando las medidas de C01.
- **Archivos que tocaría:** solo `scenes/level_01.tscn` (nuevo).
- **No se toca:** el `TileSet`, scripts, `player.tscn`, `test_room.tscn`, `project.godot`. Sin monedas ni enemigos todavía.
- **Cómo verificarlo:** abre el nivel en Godot; prueba que cada salto sea posible instanciando tu jugador temporalmente.
- **Requiere:** tu autorización antes de empezar.

---

## M3 — Monedas y HUD

### T11 — Moneda animada
- **Tipo:** A · **Esfuerzo:** 40 min · **Depende de:** T02
- **Objetivo:** `scenes/coin.tscn` que se anima y desaparece al tocarla.
- **Aprendes:** ♻ `Area2D`, `body_entered`, grupos, `queue_free()`.
- **Checklist:**
  - [ ] `Area2D` en la layer `pickup`, con mask a `player`.
  - [ ] `AnimatedSprite2D` con 12 frames de 16x16, en bucle.
  - [ ] Script que comprueba el grupo `player` y se elimina.
  - [ ] Emitir una señal `collected` antes de borrarse.
- **Pistas:** 1) Es Coin Collector T09 + T10. 2) Recuerda guardar la escena del jugador con su grupo. 3) La señal se emite antes de `queue_free()`.
- **Aceptación:** la moneda gira y desaparece una sola vez al tocarla.
- **Errores comunes:** olvidar el grupo; mask incluyendo `world`.

### T12 — HUD de puntaje
- **Tipo:** A · **Esfuerzo:** 40 min · **Depende de:** T11
- **Objetivo:** mostrar el puntaje con la fuente pixel.
- **Aprendes:** ♻ `CanvasLayer`, señal personalizada; ★ `LabelSettings`, fuentes.
- **Checklist:**
  - [ ] `scenes/hud.tscn` con un `Label` y la fuente `PixelOperator8`.
  - [ ] Un método para actualizar el texto.
  - [ ] Conectar `collected` de cada moneda al contador del nivel.
- **Pistas:** 1) Repite el patrón "call down, signal up" de Coin Collector T11. 2) La fuente se asigna en `LabelSettings` o en los theme overrides. 3) El nivel cuenta y coordina; el HUD solo muestra.
- **Aceptación:** el HUD sube con cada moneda y se queda fijo en pantalla.

---

## M4 — Peligros

### T13 — Escena Slime
- **Tipo:** A · **Esfuerzo:** 25 min · **Depende de:** T03
- **Objetivo:** `scenes/slime.tscn` animado y con colisión.
- **Aprendes:** ♻ escena de enemigo, `CharacterBody2D`.
- **Checklist:** [ ] Raíz `CharacterBody2D` en la layer `enemy`, con mask `world`. [ ] `AnimatedSprite2D` con frames de 24x24. [ ] Colisión ajustada. [ ] Gravedad (repite T04).
- **Pistas:** 1) Mira Coin Collector T12. 2) El spritesheet trae varias filas de animación; identifica cuál es el idle. 3) Usa el slime verde, y el morado queda para variar.
- **Aceptación:** el slime cae y se queda en el suelo, animado.

### T14 — Patrulla con RayCast2D
- **Tipo:** A · **Esfuerzo:** 50 min · **Depende de:** T13
- **Objetivo:** que el slime avance, dé la vuelta ante una pared o un borde, y no se caiga.
- **Aprendes:** ★ `RayCast2D` (un rayo invisible que detecta colisiones), `is_colliding()`, `is_on_wall()`.
- **Checklist:**
  - [ ] Un `RayCast2D` al frente y abajo del slime, para detectar el borde.
  - [ ] Invertir la dirección en paredes y bordes.
  - [ ] Voltear el sprite y el raycast con la dirección.
- **Pistas:** 1) En Coin Collector patrullabas por distancia; aquí se patrulla por el entorno. 2) Un rayo apuntando hacia abajo, adelantado respecto al centro, deja de chocar en un borde. 3) Al invertir la dirección hay que mover el raycast al otro lado.
- **Aceptación:** el slime recorre una plataforma de lado a lado sin caerse, indefinidamente.
- **Errores comunes:** el raycast ignora el suelo por la mask equivocada; no se voltea con el sprite.

### T15 — Muerte y reinicio con Timer
- **Tipo:** A · **Esfuerzo:** 50 min · **Depende de:** T14
- **Objetivo:** tocar un slime mata al jugador, que se detiene, y tras una pausa el nivel se reinicia.
- **Aprendes:** ♻ `Area2D` hijo, "call down, signal up"; ★ nodo `Timer`, `await`.
- **Checklist:**
  - [ ] `HitArea` en el slime, con la señal de contacto.
  - [ ] `die()` en el jugador: bandera, animación de muerte, deja de moverse.
  - [ ] Esperar ~1 s con un `Timer` y reiniciar con `reload_current_scene()`.
- **Pistas:** 1) Mismo reparto de Coin Collector T14: el slime avisa, el nivel decide, el jugador reacciona. 2) Una bandera evita morir dos veces. 3) `await get_tree().create_timer(1.0).timeout` es la versión corta; explora también el nodo `Timer`.
- **Aceptación:** muere una sola vez, se ve la animación y el nivel reinicia solo.
- **Errores comunes:** reiniciar sin esperar; detectar la muerte varias veces.

### T16 — Kill zone
- **Tipo:** A · **Esfuerzo:** 25 min · **Depende de:** T15
- **Objetivo:** caer al vacío también reinicia el nivel.
- **Aprendes:** ★ un `Area2D` grande como zona; reutilizar la lógica de muerte.
- **Checklist:** [ ] `scenes/kill_zone.tscn` con `Area2D` y colisión ancha. [ ] Que use la misma ruta de muerte que el slime.
- **Pistas:** 1) No dupliques la lógica de morir. 2) Colócala debajo del nivel. 3) Ya conoces el patrón de detección por grupo.
- **Aceptación:** al caer, hay la misma muerte y el mismo reinicio que con el slime.

---

## M5 — Plataformas móviles

### T17 — Plataforma móvil
- **Tipo:** A · **Esfuerzo:** 50 min · **Depende de:** T06
- **Objetivo:** una plataforma que va y viene y lleva al jugador encima.
- **Aprendes:** ★ `AnimatableBody2D`, `AnimationPlayer`, pistas de propiedades, `sync_to_physics`.
- **Checklist:**
  - [ ] `scenes/moving_platform.tscn` con `AnimatableBody2D`, sprite de `platforms.png` y colisión (one-way).
  - [ ] Animación en bucle de `position` con `AnimationPlayer`.
  - [ ] Probar que el jugador viaja encima sin resbalar.
- **Pistas:** 1) `AnimatableBody2D` es un cuerpo estático que se mueve y arrastra lo que pisa. 2) La animación va en una pista de propiedad sobre `position`. 3) Activa el bucle y la interpolación; revisa `sync_to_physics`.
- **Aceptación:** el jugador sube, viaja sin patinar y puede bajar.
- **Errores comunes:** usar `StaticBody2D` o mover con `position +=` en `_process`.

### T18 — Recorrido configurable
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** T17
- **Objetivo:** ajustar distancia y velocidad por instancia sin tocar la animación.
- **Aprendes:** ★ `Tween`, o `@export` aplicado a una animación.
- **Checklist:** [ ] Exportar distancia y duración. [ ] Mover con un `Tween` en bucle o ajustar el `AnimationPlayer` desde código. [ ] Probar dos instancias distintas.
- **Pistas:** 1) Mira cómo exportabas la distancia en Coin Collector T13. 2) Un `Tween` se crea desde el árbol y puede repetirse. 3) Piensa si prefieres animación visual o código.
- **Aceptación:** dos plataformas con recorridos distintos desde el inspector.

### D03 — Poblar el nivel *(delegada)*
- **Tipo:** D · **Depende de:** D02, T12, T16, T18
- **Qué hago:** instanciar en `level_01.tscn` tus escenas de moneda, slime, plataforma móvil y kill zone, más el jugador y el HUD, en posiciones jugables.
- **Archivos que tocaría:** solo `scenes/level_01.tscn`.
- **No se toca:** scripts, escenas de objetos, `project.godot`; no añado lógica.
- **Cómo verificarlo:** Godot muestra las instancias en el árbol. Tú juegas el nivel y me dices qué ajustar.
- **Requiere:** tu autorización antes de empezar.

---

## M6 — Meta y bucle de juego

### T19 — Meta y victoria
- **Tipo:** A · **Esfuerzo:** 30 min · **Depende de:** D03
- **Objetivo:** llegar a la meta termina el nivel.
- **Aprendes:** ♻ `Area2D`, señales, `monitoring`.
- **Checklist:** [ ] `scenes/goal.tscn` con una señal `player_entered`. [ ] El nivel la conecta y marca la victoria. [ ] Una bandera impide ganar si ya murió.
- **Pistas:** 1) Es la salida de Coin Collector T15, sin la apertura. 2) Comprueba el estado antes de ganar. 3) Detén al jugador al ganar.
- **Aceptación:** al llegar a la meta se registra la victoria una sola vez.

### T20 — Pantalla de victoria y menú principal
- **Tipo:** A · **Esfuerzo:** 60 min · **Depende de:** T19
- **Objetivo:** ver "¡Ganaste!" con opción de reiniciar o volver al menú, y arrancar el juego desde un menú.
- **Aprendes:** ♻ `Control`, contenedores, `change_scene_to_file`, `reload_current_scene`.
- **Checklist:** [ ] `scenes/end_screen.tscn`. [ ] `scenes/main_menu.tscn` con "Jugar" y "Salir". [ ] Fijar el menú como escena principal.
- **Pistas:** 1) Coin Collector T16 y T17 son casi el mismo ejercicio. 2) `Full Rect` y `CenterContainer`. 3) Cambia el Layout Mode si no aparece el preset.
- **Aceptación:** el flujo menú → nivel → victoria → menú funciona sin errores.

---

## M7 — Audio y cierre

### T21 — Efectos de sonido
- **Tipo:** A · **Esfuerzo:** 40 min · **Depende de:** T06, T11, T15
- **Objetivo:** sonidos al saltar, recoger una moneda y morir.
- **Aprendes:** ★ `AudioStreamPlayer` (global) vs `AudioStreamPlayer2D` (posicional), `play()`.
- **Checklist:** [ ] Un reproductor por sonido. [ ] Reproducirlos en el momento correcto. [ ] Que el sonido de la moneda no se corte cuando la moneda desaparece.
- **Pistas:** 1) ¿Qué pasa con un sonido que está dentro de un nodo que hace `queue_free()`? 2) Espera a que termine (`finished`) antes de borrarla, o ponlo en otro nodo. 3) Cuidado con el volumen.
- **Aceptación:** los tres sonidos se oyen completos y sin repetirse de más.

### T22 — Música de fondo
- **Tipo:** A · **Esfuerzo:** 20 min · **Depende de:** T20
- **Objetivo:** música en bucle durante el juego.
- **Aprendes:** ★ loop en el importador, buses de audio (básico).
- **Checklist:** [ ] Activar el loop del mp3 en la pestaña Import. [ ] Un `AudioStreamPlayer` con `autoplay`. [ ] Bajar su volumen para no tapar los efectos.
- **Pistas:** 1) El loop se activa en el panel de importación y requiere *Reimport*. 2) Decide si la música suena también en el menú.
- **Aceptación:** la música se repite sin cortes y no tapa los efectos.

### C02 — Revisión final
- **Tipo:** C · **Esfuerzo:** 45 min · **Depende de:** todo
- **Objetivo:** verificar la DoD punto por punto, jugando desde el menú, y repasar qué conceptos domino y cuáles necesitan práctica.
- **Aceptación:** DoD marcada y `LEARNING_PROGRESS.md` completo, con una lista de conceptos para reforzar en el siguiente proyecto.
