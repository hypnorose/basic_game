extends Node2D
var foe_template = preload("foe.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var enemies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_mob_timer_timeout():
	var mob = foe_template.instantiate()
	
	var spawn_pos1 = get_node("spawn_left_up_corner").position
	var spawn_pos2 = get_node("spawn_right_down_corner").position
	var spawnloc = Vector2(
		randf_range(spawn_pos1.x,spawn_pos2.x),
		randf_range(spawn_pos1.y,spawn_pos2.y)
		)
	mob.position = spawnloc
	mob.get_node("Sprite2/Sprite2D").modulate = Color(1,1,1,0)
	add_child(mob)
	enemies.push_back(mob)
	
