extends CharacterBody3D

# Very simple AI bot that walks towards the player. Place instances manually in the scene or spawn them via code.

@export var speed := 3.0
var target: Node = null

func _ready():
    # Try to find Player node in the scene tree
    target = get_tree().get_root().get_node("/root/Main/Player") if get_tree().get_root().has_node("/root/Main/Player") else null

func _physics_process(delta: float) -> void:
    if target and target is Node:
        var dir = (target.global_transform.origin - global_transform.origin)
        dir.y = 0
        if dir.length() > 0.5:
            dir = dir.normalized()
            var vel = dir * speed
            vel = move_and_slide(vel, Vector3.UP)
