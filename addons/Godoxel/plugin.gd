@tool
extends EditorPlugin

var editor_scene = load("res://addons/Godoxel/Editor.tscn").instantiate()

func _enter_tree():
	editor_scene.name = "Editor"
	if get_editor_interface().get_editor_main_screen().has_node("Editor"):
		var n = get_editor_interface().get_editor_main_screen().get_node("Editor")
		n.name = "EditorDel"
		n.queue_free()
	get_editor_interface().get_editor_main_screen().add_child(editor_scene, true)
	editor_scene.owner = get_editor_interface().get_editor_main_screen()
	_make_visible(false)


func _exit_tree():
	if editor_scene:
		editor_scene.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if editor_scene:
		editor_scene.visible = visible


func _get_plugin_name():
	return "Godoxel"


func _get_plugin_icon():
	# Must return some kind of Texture2D for the icon.
	return get_editor_interface().get_base_control().get_icon("CanvasModulate", "EditorIcons")
