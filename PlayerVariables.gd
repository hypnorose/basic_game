extends Node




var Effect = Items.Effect
var AttackEffect = Items.AttackEffect
var StatEffect = Items.StatEffect 
var Item = Items.Item
var Bullet = Items.Bullet

var orbs
var stats
var speed
var weapons
var all_weapons
var items
var all_items
var xp
var initiated = 0


class Weapon:
	var dmg
	var ats
	var tex
	var spawn_offset
	var name
	func _init(name,dmg,ats,tex):
		self.name = name
		self.dmg = dmg
		self.ats = ats
		self.tex = tex
		self.spawn_offset = 32
	func duplicate():
		var obj = Weapon.new(self.name,self.dmg,self.ats,self.tex)
		return obj

func _ready():
	if initiated == 1:
		return
	initiated = 1
	stats = {
		'max_hp' : 10,
		'dmg' : 0,
		'ats' : 1
	}
	xp = 6
	print("player variables initiated")
	all_weapons = [
		Weapon.new("Odlamek",2,1,"res://art/ice_wand.png"),
		Weapon.new("Kropla",1,0.8,"res://art/droplet.png"),
	]
	
	var bullets = {
		'ice':Bullet.new(load("res://art/bullets/ice.png")),
		'water':Bullet.new(load("res://art/bullets/water.png"))
	}
	all_items = {}
	all_items['droplet'] = Item.new(Items.WEAPON,[AttackEffect.new(2,1,bullets['water'])],"Kropla",load("res://art/weapons/droplet.png"))
	all_items['shard'] = Item.new(Items.WEAPON,[AttackEffect.new(1,0.8,bullets['ice'])],"Odłamek",load("res://art/weapons/ice_wand.png"))
	all_items['lapis'] = Item.new(Items.BONUS,[StatEffect.new(StatEffect.DMG,1.0)],"Lapis",load("res://art/items/lapis.png"))
	all_items['fishbone'] = Item.new(Items.BONUS,[StatEffect.new(StatEffect.ATS,0.1)],"Ość",load("res://art/items/fishbone.png"))
	all_items['seaweed'] = Item.new(Items.BONUS,[StatEffect.new(StatEffect.HP,3)],"Wodorost",load("res://art/items/seaweed.png"))
	items = []
	items.append(all_items['droplet'])
	items.append(all_items['shard'])
	items.append(all_items['seaweed'])
	pass 

