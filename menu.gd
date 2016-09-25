extends Node2D

func _ready():
	for f in list_files_in_directory("res://maps/"):
		get_node("map_list").add_item(f)
	
	if get_node("map_list").get_item_count() > 0:
		get_node("map_list").select(0)
	else:
		get_node("edit").set_disabled(true)
	
func _on_create_new_pressed():
	global.edit = false
	global.file_name = get_node("new_file_name").get_text()
	get_tree().change_scene("main.tscn")
	
func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with(".") and not file == "map_template.json" and file.extension() == "json":
            files.append(file)

    dir.list_dir_end()

    return files

func _on_edit_pressed():
	global.edit = true
	global.file_name = get_node("map_list").get_item_text(get_node("map_list").get_selected_items()[0]).split(".")[0]
	get_tree().change_scene("main.tscn")
