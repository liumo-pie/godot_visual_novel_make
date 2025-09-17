class_name Character extends Node2D
@onready var anmi_char: AnimatedSprite2D = %anmi_char
const dia_res:Resource=preload("res://dialogue/main.dialogue")
#使用插件实现功能，实例化
const balloon_scene=preload("res://dialogue/balloon.tscn")
const CHARACTER_FRAME:Dictionary={
	"Phoneix":preload("res://resources/phoneix.tres"),
	"Trucy":preload("res://resources/trucy.tres")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_anmi(char_name:CharacterRole.Char_name,play_anmi:String)->void:
	var sprite_frames=CharacterRole.CHAR_DETAIL[char_name]["res"]
	if sprite_frames:
		anmi_char.sprite_frames=sprite_frames
		anmi_char.play(play_anmi)		
	else:
		anmi_char.play("idel")
	pass

func  anmi_play()->void:
	anmi_char.play("idel")
	pass
