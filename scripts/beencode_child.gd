extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var encoder_path: NodePath
onready var encoder = get_node(encoder_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	# encode
	var result = encoder.beencode($TextEdit.text)
	$TextEdit.text = result
	pass # Replace with function body.


func _on_Button2_pressed():
	# decode
	var result = encoder.beedecode($TextEdit.text)
	$TextEdit.text = result
	pass # Replace with function body.
