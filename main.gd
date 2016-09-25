extends Node2D

const tile = preload("res://tile.tscn")
const TILE_SIZE = 32

var current_button = 0
var mouse_down = false

var map = []
var map_tiles = []
var file_name = "map_template"

func _ready():
	
	if global.edit:
		file_name = global.file_name
	var f_in = File.new()
	f_in.open("res://maps/"+file_name+".json",File.READ)
	var line = {}
	line.parse_json(f_in.get_line())
	map = line['map']
	map_tiles = line['map_tiles']
	get_node("player_1").set_pos(Vector2(line['player_1_x'],line['player_1_y']))
	get_node("player_2").set_pos(Vector2(line['player_2_x'],line['player_2_y']))
	
	set_process_input(true)
	get_node("gui/buttons/tile_grass").set_disabled(true)
	for y in range(map.size()):
		for x in range(map[0].size()):
			var tile_new = tile.instance()
			tile_new.set_name("tile_"+str(y)+"_"+str(x))
			tile_new.x = x
			tile_new.y = y
			tile_new.set_pos(Vector2(x*TILE_SIZE+TILE_SIZE/2+100,y*TILE_SIZE+TILE_SIZE/2))
			tile_new.get_node("tiles").set_frame(map_tiles[y][x])
			add_child(tile_new)

func buttons_enable():
	for button in get_node("gui/buttons").get_button_list():
		button.set_disabled(false)

func _on_tile_grass_pressed():
	current_button = 0
	buttons_enable()
	get_node("gui/buttons/tile_grass").set_disabled(true)

func _on_tile_cliff_pressed():
	current_button = 1
	buttons_enable()
	get_node("gui/buttons/tile_cliff").set_disabled(true)
	
func _on_tile_p1_pressed():
	current_button = 2
	buttons_enable()
	get_node("gui/buttons/tile_p1").set_disabled(true)
	
func _on_tile_p2_pressed():
	current_button = 3
	buttons_enable()
	get_node("gui/buttons/tile_p2").set_disabled(true)

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON && event.button_index == 1:
		mouse_down = event.pressed
		
func neighbours_adjust(x,y):
	if y > 0:
		if map[y-1][x] == 1:
			set_tile(x,y-1,false)
	if x < map[0].size()-2:
		if map[y][x+1] == 1:
			set_tile(x+1,y,false)
	if y < map.size()-2:
		if map[y+1][x] == 1:
			set_tile(x,y+1,false)
	if x > 0:
		if map[y][x-1] == 1:
			set_tile(x-1,y,false)
		
func set_tile(x,y,adjust):
	var tile_new = get_node("tile_"+str(y)+"_"+str(x)+"/tiles")
	if map[y-1][x] == 1 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 1:
			tile_new.set_frame(5)
			map_tiles[y][x] = 5
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 1:
			tile_new.set_frame(2)
			map_tiles[y][x] = 2
			
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 1:
			tile_new.set_frame(6)
			map_tiles[y][x] = 6
			
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 1:
			tile_new.set_frame(8)
			map_tiles[y][x] = 8
			
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 0:
			tile_new.set_frame(4)
			map_tiles[y][x] = 4
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 1:
			tile_new.set_frame(3)
			map_tiles[y][x] = 3
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 0:
			tile_new.set_frame(1)
			map_tiles[y][x] = 1
			
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 0:
			tile_new.set_frame(7)
			map_tiles[y][x] = 7
			
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 1:
			tile_new.set_frame(9)
			map_tiles[y][x] = 9
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 0:
			tile_new.set_frame(10)
			map_tiles[y][x] = 10
	
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 0:
			tile_new.set_frame(11)
			map_tiles[y][x] = 11
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 0:
			tile_new.set_frame(12)
			map_tiles[y][x] = 12
			
	elif map[y-1][x] == 1 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 1 \
		and map[y][x-1] == 0:
			tile_new.set_frame(13)
			map_tiles[y][x] = 13
	
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 0:
			tile_new.set_frame(14)
			map_tiles[y][x] = 14
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 1 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 1:
			tile_new.set_frame(15)
			map_tiles[y][x] = 15
			
	elif map[y-1][x] == 0 \
		and map[y][x+1] == 0 \
		and map[y+1][x] == 0 \
		and map[y][x-1] == 1:
			tile_new.set_frame(16)
			map_tiles[y][x] = 16
			
	else:
		tile_new.set_frame(5)
		map_tiles[y][x] = 5
	
	if adjust:
		map[y][x] = 1
		neighbours_adjust(x,y)

func _on_tile_save_pressed():
	var a = 3
	var f_out = File.new()
	var out = {
		player_1_x=get_node("player_1").get_pos().x,
		player_1_y=get_node("player_1").get_pos().y,
		player_2_x=get_node("player_2").get_pos().x,
		player_2_y=get_node("player_2").get_pos().y,
		map=map,
		map_tiles=map_tiles
	}
	f_out.open("res://maps/"+global.file_name+".json",File.WRITE)
	f_out.store_line(out.to_json())
	f_out.close()
	get_node("gui/AcceptDialog").popup()

func _on_tile_menu_pressed():
	get_tree().change_scene("menu.tscn")
