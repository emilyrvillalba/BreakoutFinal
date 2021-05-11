extends Control

var world = "res://Improved Game/Game_Dog/DogScene.tscn"

func _ready():
	visible = false
	
func _reset_button_pressed():
	get_tree().change_scene(world)
