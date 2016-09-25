extends Area2D

onready var main = get_node("/root/main")
onready var tile = get_node("tiles")

var x = 0
var y = 0

var mouse_down = 0
var current_button = 0

func _ready():
	pass

func _on_tile_mouse_enter():
	if y > 0 and x > 0 and y < main.map.size()-1 and x < main.map[0].size()-1:
		mouse_down = main.mouse_down
		current_button = main.current_button
		if mouse_down:
			if current_button == 0:
				tile.set_frame(0)
				main.map[y][x] = 0
				main.map_tiles[y][x] = 0
				main.neighbours_adjust(x,y)
			elif current_button == 1:
				printt(y,x)
				main.set_tile(x,y,true)
			elif current_button == 2:
				main.get_node("player_1").set_pos(Vector2(x*32+100+16,y*32+16))
			elif current_button == 3:
				main.get_node("player_2").set_pos(Vector2(x*32+100+16,y*32+16))