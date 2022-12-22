extends CharacterBody2D
var soul_template = preload("soul.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var vel = Vector2()
var speed = 0
var hp
var enemy = true
var root
var dmg
var active = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer2.play("foe_spawn")
	speed= 100
	hp = 2
	dmg = 3
	root = get_node("/root/scena")
	
	$AnimationPlayer.play("foe_animation")
	pass # Replace with function body.
func isActive():
	return active == 0
func hit(dmg):
	if active > 0:
		return
	$AnimationPlayer2.play("foe_hit")
	hp -= dmg
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	active -= delta
	if active <= 0:
		active = 0 
	else:
		return	
	if hp <= 0:
		var new_soul = soul_template.instantiate()
		new_soul.position = position
		root.add_child(new_soul)
		queue_free()
		root.enemies.erase(self)
		
	var player = get_node("/root/scena/player")
	vel = lerp(vel,speed*(player.position - position).normalized(),0.1)
	
	set_velocity(vel)
	move_and_slide()
