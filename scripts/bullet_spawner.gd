extends Node3D

# Simple bullet spawner example. Attach this as a child of Main and set bullet_scene to the bullet scene.

@export var bullet_scene: PackedScene
@export var bullet_speed := 30.0

func spawn_bullet(origin: Vector3) -> void:
    if bullet_scene == null:
        return
    var b = bullet_scene.instantiate()
    b.global_transform.origin = origin + Vector3(0, 1.5, 0)
    if b.has_variable("velocity"):
        b.velocity = Vector3(0, 0, -bullet_speed)
    get_tree().get_root().get_node("/root/Main").add_child(b)
