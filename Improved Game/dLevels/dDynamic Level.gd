extends Node2D

export var rows = 3
export var columns = 10
export(int, 1, 5) var difficulty = 1 #1 to 5, 1 is easy

const brick_class = preload("res://Improved Game/dBricks/dBrick.tscn")

#brick should be this dimension
const cell_width = 96
const cell_height = 50

var brick_arr = []
signal level_done

# Called when the node enters the scene tree for the first time.
func _ready():
	var audio = AudioStreamPlayer.new()
	self.add_child(audio)
	audio.stream = load("res://Improved Game/dSound/dsong.wav")
	#audio.play()
	rows += difficulty
	var empty_range = 0.6 - (difficulty/ 10.0) #(0.1 to 0.5)
	
	for column in range(columns):
		for row in range(rows):
			var random = rand_range(0,1)
			if random < empty_range:
				pass
			elif random < 0.7:
				var brick = brick_class.instance()
				init_brick(brick.dFrames.BONE,brick, row, column, false)
				
			elif random < 0.9:
				var brick = brick_class.instance()
				init_brick(brick.dFrames.LEAF, brick, row, column, false)
			elif random < 0.92:
				var brick = brick_class.instance()
				init_brick(brick.dFrames.RAINBOW, brick, row, column, false)
		
			else:
				var brick = brick_class.instance()
				init_brick(brick.dFrames.SQUIRREL, brick, row, column, true)
				
func init_brick(frame, brick, row, column, indestructable):
		brick.set_frames(frame)
		brick.set_indestructable(indestructable)
		add_child(brick)
		brick.position.x = 80 + column  * cell_width
		brick.position.y = 24 + row* cell_height
		if not indestructable:
			brick_arr.append(brick)

func _on_Ball2_ball_hit(brick):
	var position = brick_arr.find(brick)
	var brick_found = position != -1
	if not brick.is_alive_after() and brick_found:
		brick_arr.remove(position)
		
	
	if brick_arr.size() == 0:
		emit_signal("level_done")
		print("level done")
		

