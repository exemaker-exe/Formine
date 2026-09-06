extends CharacterBody3D

# Simple movement script for Godot 4 (CharacterBody3D)
# Controls: WASD to move, Space to jump, Left mouse to "shoot" (spawns a bullet if you add the bullet scene)

@export var speed := 6.0
@export var jump_velocity := 4.5
var gravity := ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
    InputMap.add_action("move_forward")
    InputMap.add_action("move_backward")
    InputMap.add_action("move_left")
    InputMap.add_action("move_right")
    InputMap.add_action("jump")
    InputMap.add_action("shoot")
    InputMap.action_erase_events("move_forward")
    InputMap.action_erase_events("move_backward")
    InputMap.action_erase_events("move_left")
    InputMap.action_erase_events("move_right")
    InputMap.action_erase_events("jump")
    InputMap.action_erase_events("shoot")
    InputMap.action_add_event("move_forward", InputEventKey.new_from_scancode(KEY_W))
    InputMap.action_add_event("move_backward", InputEventKey.new_from_scancode(KEY_S))
    InputMap.action_add_event("move_left", InputEventKey.new_from_scancode(KEY_A))
    InputMap.action_add_event("move_right", InputEventKey.new_from_scancode(KEY_D))
    InputMap.action_add_event("jump", InputEventKey.new_from_scancode(KEY_SPACE))
    InputMap.action_add_event("shoot", InputEventMouseButton.new().set_button_index(BUTTON_LEFT))

func _physics_process(delta: float) -> void:
    var input_dir := Vector3.ZERO
    if Input.is_action_pressed("move_forward"):
        input_dir.z -= 1
    if Input.is_action_pressed("move_backward"):
        input_dir.z += 1
    if Input.is_action_pressed("move_left"):
        input_dir.x -= 1
    if Input.is_action_pressed("move_right"):
        input_dir.x += 1

    input_dir = input_dir.normalized()

    var velocity := Vector3.ZERO
    velocity.x = input_dir.x * speed
    velocity.z = input_dir.z * speed

    if not is_on_floor():
        velocity.y = velocity.y - gravity * delta
    else:
        if Input.is_action_just_pressed("jump"):
            velocity.y = jump_velocity

    # Move and slide using the built-in method
    velocity = move_and_slide(velocity, Vector3.UP)

    # Shooting (placeholder) - user must create a Bullet scene at res://scenes/bullet.tscn
    if Input.is_action_just_pressed("shoot"):
        if has_node("../BulletSpawner"):
            var spawner = get_node("../BulletSpawner")
            if spawner and spawner.has_method("spawn_bullet"):
                spawner.spawn_bullet(global_transform.origin)
