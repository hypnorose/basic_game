extends RigidBody2D

var root 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2()
var to_remove = false
# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	root = get_node("/root/scena/")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if to_remove:
		return
	linear_velocity = vel
	rotation = vel.angle()
	var colliding = get_colliding_bodies()
	for obj in colliding:
		if obj.is_in_group("enemies") : 
			obj.hit(1)
			queue_free()
			to_remove = true
			return
