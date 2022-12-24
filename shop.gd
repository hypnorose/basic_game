extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pool 
# Called when the node enters the scene tree for the first time.


func shop_generate():
	var i = 0
	pool = []
	var all_stuff_buyable = PlayerVariables.all_items
	for child in $Panel.get_children():
		var index = randi() % len(all_stuff_buyable)
		var weapon = all_stuff_buyable.values()[index]
		child.get_node("Sprite2D").texture = weapon.tex
		child.get_node("Label").text = weapon.name
		var desc 
		if "item" in weapon:
			desc = weapon.desc
		else:
			desc = ""
			for effect in weapon.effects:
				desc += effect.desc()
			#desc = "obrażenia: "+ str(weapon.dmg) + "\n prędkość: " + str(weapon.ats)
		child.get_node("Desc").text = desc
		child.id = i
		pool.append({
			'weapon': weapon,
			'node': child,
			'cost' : 3
		})
		child.show()
		i+=1
		
func _ready():
	randomize()
	shop_generate()

func item_picked(item_id):
	if pool[item_id]['weapon'] != null and pool[item_id]['cost'] <= PlayerVariables.xp:
		PlayerVariables.items.append(pool[item_id]['weapon'])
		PlayerVariables.xp -= pool[item_id]['cost']
		item_panel_clear(item_id)
	
func item_panel_clear(item_id):
	var child = pool[item_id]['node']
	child.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_next_pressed():
	get_tree().change_scene_to_file("res://scena.tscn")
	pass # Replace with function body.





func _on_button_roll_pressed():
	if PlayerVariables.xp >= 5:
		PlayerVariables.xp -= 5
		shop_generate()
