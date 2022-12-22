extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var Player
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node("/root/root/game/player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.value = 100.0 * PlayerVariables.xp / PlayerVariables.max_xp
