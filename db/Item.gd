extends Node
class_name Items

enum {WEAPON,BONUS }
		
class Effect:
	pass
	
class Bullet:
	var tex
	func _init(tex):
		self.tex = tex

class AttackEffect:
	var dmg : int
	var ats : float
	var melee : bool
	var bullet
	func _init(_dmg, _ats,_bullet = null):
		self.dmg = _dmg
		self.ats = _ats
		self.melee = _bullet == null
		self.bullet = bullet
	func desc():
		var retval =str("obrażenia: " +str(dmg) + "\nCzas odnowienia: " + str(ats))
		return retval 
class StatEffect:
	enum {DMG,ATS,HP}
	var value : float
	var stat 
	func _init(stat,value : float):
		self.stat = stat
		self.value = value
	func desc():
		var retval = ""
		if stat == DMG:
			retval += "Obrażenia +"
		if stat == ATS:
			retval += "Prędkość ataku +"
		if stat == HP:
			retval += "Max hp +"
		retval += str(value)
		retval += '\n'
		return retval
class Item:
	var type 
	var effects : Array
	var tex
	var name
	func _init(_type ,_effects : Array,name : String,tex):
		self.type = _type
		self.effects = _effects
		self.name = name
		self.tex = tex
	func getEffectOfType(type):
		var retval = []
		for effect in effects:
			if effect is type:
				retval.append(effect)
		return retval
	func getType():
		return self.type.type
	func desc():
		return "abstract item"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
