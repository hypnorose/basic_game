extends RefCounted
class_name GELayer
@tool


var name
var layer_width
var layer_height
var visible = true :
	get:
		return visible # TODOConverter40 Non existent get function 
	set(mod_value):
		mod_value  # TODOConverter40 Copy here content of set_visible
var locked = false
var alpha_locked = false

var texture: ImageTexture
var image: Image
var texture_rect_ref


func _init():
	texture = ImageTexture.new()


func create(texture_rect_ref, width: int, height: int):
	self.texture_rect_ref = texture_rect_ref
	
	assert(width > 0 and height > 0) #,"Texture2D size invalid!")
	
	layer_width = width
	layer_height = height
	
	image = Image.new()
	image.create(width, height, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	update_texture()


func resize(width: int, height: int):
	var pixel_colors = []
	var prev_width = layer_width
	var prev_height = layer_height
	
	false # image.lock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	for y in range(prev_height):
		for x in range(prev_width):
			pixel_colors.append(image.get_pixel(x, y))
	false # image.unlock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	
	layer_width = width
	layer_height = height
	
	image.create(width, height, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	false # image.lock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	for x in range(prev_width):
		for y in range(prev_height):
			if x >= width or y >= height:
				continue
			image.set_pixel(x, y, pixel_colors[GEUtils.to_1D(x, y, prev_width)])
	false # image.unlock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	
	update_texture()


func set_pixel(x, y, color):
	false # image.lock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	image.set_pixel(x, y, color)
	false # image.unlock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed


func get_pixel(x: int, y: int):
	if x < 0 or y < 0 or x >= image.get_width() or y >= image.get_height():
		return null
	false # image.lock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	var pixel = image.get_pixel(x, y)
	false # image.unlock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	return pixel


func clear():
	image.fill(Color.TRANSPARENT)
	update_texture()


func update_texture():
	texture.create_from_image(image) #,0
	texture_rect_ref.texture = texture
	texture_rect_ref.offset_right = 0
	texture_rect_ref.offset_bottom = 0


func set_visible(vis: bool):
	# TODO upate frame preview when hide/show 
	visible = vis
	texture_rect_ref.visible = visible


func toggle_lock():
	locked = not locked


func toggle_alpha_locked():
	alpha_locked = not alpha_locked


func copy_from(other: GELayer):
	image.copy_from(other.image)

