extends StaticBody2D

var points

onready var animated_sprite = get_node("AnimatedSprite")

var bone_frames = preload("res://Improved Game/dBricks/dframes/dbrick1_frame.tres")
var leaf_frames = preload("res://Improved Game/dBricks/dframes/dbrick2_frame.tres")
var squirrel_frames = preload("res://Improved Game/dBricks/dframes/dbrick0_frame.tres")


enum dFrames {BONE = 1, LEAF = 2, SQUIRREL = 0}

var current_frames = dFrames.BONE

var indestructable = false

func set_frames(frames):
	current_frames = frames

func change_frames():
	match current_frames:
		dFrames.BONE:
			animated_sprite.frames = bone_frames
		dFrames.LEAF:
			animated_sprite.frames = leaf_frames
		dFrames.SQUIRREL:
			animated_sprite.frames = squirrel_frames

			
# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("brick", true)
	change_frames()
	points = animated_sprite.frames.get_frame_count("default")
	
func set_indestructable(booleanValue):
	indestructable = booleanValue

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func decrease_points():
	if indestructable:
		return
	
	points -= 1
	
	if animated_sprite.frame < animated_sprite.frames.get_frame_count("default")  -1:
		animated_sprite.frame += 1
	
	if points <= 0:
		queue_free()

func is_alive_after():
	return points > 1
