class_name Character extends Node2D
@onready var anmi_char: AnimatedSprite2D = %anmi_char
const dia_res:Resource=preload("res://dialogue/main.dialogue")
#使用插件实现功能，实例化
const balloon_scene=preload("res://dialogue/balloon.tscn")
const CHARACTER_FRAME:Dictionary={
	"Phoneix":preload("res://resources/phoneix.tres"),
	"Trucy":preload("res://resources/trucy.tres")
}
var show_character_name=null
var show_character_expression=null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_anmi(char_name:CharacterRole.Char_name,play_anmi:String)->void:
	var sprite_frames=CharacterRole.CHAR_DETAIL[char_name]["res"]
	if sprite_frames:
		show_character_name=char_name
		print("展示的角色名字是"+str(show_character_name))
		show_character_expression=play_anmi
		print("展示的角色动画是"+str(show_character_expression))
		anmi_char.sprite_frames=sprite_frames
		anmi_char.play(play_anmi)		
	else:
		anmi_char.play("idel")
	pass

	#pass

func  anmi_play()->void:
	#print("至少有进入这个函数")
	print("展示的角色名字是"+str(show_character_name))
	print("展示的角色动画是"+str(show_character_expression))
	if show_character_name!=null:
		var sprite_anmi_talk=CharacterRole.CHAR_DETAIL[show_character_name]["Talk_idel"]
		if sprite_anmi_talk.has(show_character_expression):
			print("对应的静止表情是"+str(sprite_anmi_talk[show_character_expression]))
			anmi_char.play(sprite_anmi_talk[show_character_expression])
	else:
		printerr("没有正确的传入")
	
	#anmi_char.play("idel")
	
