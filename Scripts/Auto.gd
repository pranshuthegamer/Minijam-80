extends Node

var Menu = preload("res://Scenes/Not Levels/Menu.tscn").instance()
var Char = preload("res://Scenes/Entity/Entity.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node_or_null("/root/Main"):
		$"/root/Main/Gui".add_child(Menu)
		$"/root/Main".add_child(Char)
	else:
		var children = $"/root".get_children()
		var i = children.find(self)
		children.remove(i)
		children[0].add_child(Char)
		if get_node_or_null(str("/root/" + children[0].name + "/Start")) != null:
			Char.transform = get_node(str("/root/" + children[0].name + "/Start")).transform

func _cng_scene(scene,caller):
	var tempscene = load(scene).instance()
	$"/root/Main".add_child(tempscene)
	caller.queue_free()
	Char.get_node("Camera2D").current = true
	Char.transform = tempscene.get_node("Start").transform
