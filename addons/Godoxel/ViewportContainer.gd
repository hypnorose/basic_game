extends SubViewportContainer
@tool

func _ready():
	get_child(0).size = size

