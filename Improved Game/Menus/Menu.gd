extends Control

var world = "res://Improved Game/Game_Dog/DogScene.tscn"
var main_menu_world = "res://Main Menu/Main_menu.tscn"

func _ready():
	visible = false
	
func _reset_button_pressed():
	get_tree().change_scene(world)
	

func _on_Button2_pressed():
	get_tree().change_scene(main_menu_world)
