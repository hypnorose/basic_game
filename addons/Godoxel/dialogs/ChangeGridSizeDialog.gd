extends AcceptDialog
@tool

func _ready():
	await owner.ready
	find_child("GridValue").value = owner.paint_canvas.grid_size
	find_child("BigGridValue").value = owner.paint_canvas.big_grid_size


func _on_ChangeGridSizeDialog_confirmed():
	var grid_size = find_child("GridValue").value
	var big_grid_size = find_child("BigGridValue").value
	owner.paint_canvas.grid_size = grid_size
	owner.paint_canvas.big_grid_size = big_grid_size


func _on_GridValue_value_changed(value):
	var grid_size = value
	owner.paint_canvas.grid_size = grid_size


func _on_BigGridValue_value_changed(value):
	var big_grid_size = value
	owner.paint_canvas.big_grid_size = big_grid_size


func _on_ChangeGridSizeDialog_visibility_changed():
	pass # Replace with function body.
