@tool
extends Control

var image = Image.new()
var image_texture = ImageTexture.new()

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func setup(region_size):
	image.create(region_size, region_size, true, Image.FORMAT_RGBA8)
	false # image.lock() # TODOConverter40, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed

func update_chunk():
	image_texture.create_from_image(image)
	image_texture.set_flags(0)
	self.texture = image_texture

func set_cell(x, y, color):
	image.set_pixel(x, y, color)
	update_chunk()

func _on_VisibilityNotifier2D_screen_entered():
	visible = true

func _on_VisibilityNotifier2D_screen_exited():
	visible = false
