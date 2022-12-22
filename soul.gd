extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	print("soul created")
	contact_monitor = true
	max_contacts_reported = 10
	player =  get_node("/root/scena/player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(player.position) < 100:
		linear_velocity = (500 - position.distance_to(player.position)) * (player.position - position).normalized()
	var colliding = get_colliding_bodies()
	for obj in colliding:
		if obj.is_in_group("player") : 
			PlayerVariables.xp += 1
			queue_free()
#	pass
