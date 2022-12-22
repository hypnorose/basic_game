extends ConfirmationDialog
@tool

func _ready():
	await owner.ready
	find_child("Width").value = owner.paint_canvas.canvas_width
	find_child("Height").value = owner.paint_canvas.canvas_height


func _on_ConfirmationDialog_confirmed():
	var width = find_child("Width").value
	var height = find_child("Height").value
	print("change canvas size: ", width, " ", height)
	owner.paint_canvas.resize(width, height)


func _on_ChangeCanvasSize_visibility_changed():
	if visible:
		find_child("Width").value = owner.paint_canvas.canvas_width
		find_child("Height").value = owner.paint_canvas.canvas_height
