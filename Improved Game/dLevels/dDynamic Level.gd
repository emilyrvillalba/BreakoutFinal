extends Node2D

export var rows = 3
export var columns = 10
export(int, 1, 5) var difficulty = 1 #1 to 5, 1 is easy


const brick_class = preload("res://Improved Game/dBricks/dBrick.tscn")
onready var score_text = get_node("RichTextLabel")
onready var level_text = get_node("LevelText")



var total_score = 0
var last_complete = false

signal rainbow

#brick should be this dimension
const cell_width = 96
const cell_height = 50

var brick_arr = []
signal level_done


# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_difficulty()
	print(difficulty)
	var format_string = "Level: %s"
	var actual_string = format_string % difficulty
	level_text.set_text(actual_string)
	
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
	
	if brick.is_rainbow():
		emit_signal("rainbow")
		print("rainbow")
	
	if not brick.is_alive_after() and brick_found:
		brick_arr.remove(position)
		total_score += brick.get_score()		
		update_score()		
	
	if brick_arr.size() == 0:		
		emit_signal("level_done")
		difficulty += 1
		save_difficulty()
		print("level done")
		
		
func update_score():
	var format_string = "Score: %s"
	var actual_string = format_string % total_score
	score_text.set_text(actual_string)


func load_difficulty():
	var save_file = File.new()
	if not save_file.file_exists("user://savefile.save"):
		difficulty = 1

	save_file.open("user://savefile.save", File.READ)
	difficulty = int(save_file.get_line())
	save_file.close()

func save_difficulty():
	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	save_file.store_line(str(difficulty))
	save_file.close()


func _on_Ball2_game_over():
	difficulty = 1
	save_difficulty()
