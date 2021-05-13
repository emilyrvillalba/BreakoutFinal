extends Control

var world = "res://Game_Classic/Game_Main/MainScene.tscn"
var main_menu_world = "res://Main Menu/Main_menu.tscn"


func _ready():
	visible = false

func _on_Reset_pressed():
	get_tree().change_scene(world)


func _on_Main_pressed():
	get_tree().change_scene(main_menu_world)


func _on_Dynamic_Level_level_done():
	visible = true
