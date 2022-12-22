extends CharacterBody2D

var weapon_template = preload("Weapon.tscn")
var speed = 300
var cd = 0 
var inv_time = 0
var xp = 0
var max_xp = 5
var stats
var hp
# Called when the node enters the scene tree for the first time.


func update_stat(effect) :
	if effect.stat == Items.StatEffect.DMG:
		stats['dmg'] += effect.value
	if effect.stat == Items.StatEffect.ATS:
		stats['ats'] += effect.value
	if effect.stat == Items.StatEffect.HP:
		stats['max_hp'] += effect.value
func items_update():
	
	for item in PlayerVariables.items:
		var stat_effects = item.getEffectOfType(Items.StatEffect)
		for effect in stat_effects:
			update_stat(effect)
		print(stats)
func _ready():
	print("player start")
	stats = PlayerVariables.stats.duplicate()
	items_update()
	
	
	var weapons = []
	for item in PlayerVariables.items:
		if item.type == Items.WEAPON:
			weapons.append(item)
			
	hp = stats['max_hp']
	var i = 0.0
	var number_of_weapons = len(weapons)
	for weapon in weapons:
		print(weapon.tex)
		var new_weapon = weapon_template.instantiate()
		new_weapon.weapon_info = weapon
		print(weapon)
		new_weapon.get_node("Sprite2D").texture = weapon.tex
		new_weapon.position =  Vector2(90,0).rotated(i/number_of_weapons * 2*PI)
		i+=1
		new_weapon.dmg += stats['dmg']
		new_weapon.ats *= 1.0 / stats['ats']
		print(position)
		print(new_weapon.position)
		add_child(new_weapon)
	pass # Replace with function body.

func hit(other):
	if other.get_owner().is_in_group("enemies") and inv_time == 0 and other.get_owner().active == 0:
			hp -= other.get_owner().dmg
			inv_time = 0.5
			$AnimationPlayer2.queue("hit")
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp <= 0:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	var velocity = Vector2(0,0);
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	inv_time = max(0,inv_time-delta)
	var collided = move_and_collide(velocity.normalized()*speed*delta,false,true,true)
	if collided:
		#print(collided.collider)
		pass
	set_velocity(velocity.normalized()*speed)
	set_floor_stop_on_slope_enabled(false)
	move_and_slide()
	if velocity==Vector2(0,0) :
		$AnimationPlayer.stop(false)
	else:
		$AnimationPlayer.play("player_moving")
	cd += delta
	
	
