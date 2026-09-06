extends Area3D

# Simple bullet script. This is a placeholder; adjust collision layers/masks in Godot editor.

@export var lifetime := 3.0
var time_alive := 0.0
var velocity := Vector3(0,0,-30)

func _physics_process(delta: float) -> void:
    translate(velocity * delta)
    time_alive += delta
    if time_alive >= lifetime:
        queue_free()

func _on_body_entered(body):
    # Deal damage if the body has a `take_damage` method
    if body and body.has_method("take_damage"):
        body.take_damage(10)
    queue_free()
