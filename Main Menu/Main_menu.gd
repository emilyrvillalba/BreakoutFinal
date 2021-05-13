extends Control

var classic_world = "res://Game_Classic/Game_Main/MainScene.tscn"
var improve_world = "res://Improved Game/Game_Dog/DogScene.tscn"
var instruction_world = "res://Main Menu/Instruction.tscn"

var main_menu_world = "res://Main Menu/Main_menu.tscn"

func _on_ClassicButton_pressed():
	get_tree().change_scene(classic_world)


func _on_ImprovedButton_pressed():
	get_tree().change_scene(improve_world)


func _on_InstructionButton_pressed():
	get_tree().change_scene(instruction_world)
	

