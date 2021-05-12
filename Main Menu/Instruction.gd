extends Control

var main_menu = "res://Main Menu/Main_menu.tscn"

	

func _on_BackButton_pressed():
	get_tree().change_scene(main_menu)
