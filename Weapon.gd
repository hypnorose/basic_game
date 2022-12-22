extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weapon_info
var cd 
var bullet_template = preload("bullet.tscn")
# Called when the node enters the scene tree for the first time.
var root
var closest = null;
var dmg = 0 
var ats = 1
var attack_effects = []
func _ready():
	cd = ats  
	attack_effects = weapon_info.getEffectOfType(Items.AttackEffect)
	root = get_node("/root/scena")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cd += delta
	for enemy in root.enemies :
		if global_position.distance_to(enemy.global_position) > 300 or not enemy.isActive():
			continue
		if not is_instance_valid(closest):
			closest = enemy
			continue
		if global_position.distance_to(enemy.position) < global_position.distance_to(closest.position) :
			closest = enemy
	if is_instance_valid(closest):
		look_at(closest.position)
	for effect in attack_effects:
		if cd < effect.ats * ats:
			return
		if len(root.enemies) == 0 :
			return
		
		if not is_instance_valid(closest):
			return
		var bullet = bullet_template.instantiate()
		root.add_child(bullet)
		look_at(closest.position)
		print(rotation)
		bullet.global_position = Vector2(global_position.x,global_position.y)+40*Vector2(cos(rotation),sin(rotation))
		bullet.vel = (closest.global_position - global_position).normalized() * 800
		cd = 0
