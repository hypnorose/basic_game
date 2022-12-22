extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time
# Called when the node enters the scene tree for the first time.
func _ready():
	time = 15
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta
	text = str(int(time))
	if time <= 0:
		get_tree().change_scene_to_file("res://shop.tscn")
