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

func set_anmi(char_name:String)->void:
	anmi_char.sprite_frames=CHARACTER_FRAME[char_name]
	anmi_char.play("idel_talk")
	#match anmi_char.sprite_frames.resource_name:
		#"phoneix":
			#print("进来了")
			#anmi_char.play("idel_talk")
		#"trucy":
			#anmi_char.play("idel_talk")
	pass

func  anmi_play()->void:
	anmi_char.play("idel")
	#match anmi_char.sprite_frames.resource_name:
		#"phoneix":
			#anmi_char.play("idel")
		#"trucy":
			#anmi_char.play("idel")
		#_:
			#print("搞错了")
	pass
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action("ui_accept"):
		#var balloon=balloon_scene.instantiate()
		#get_parent().add_child(balloon)
		#balloon.start(dia_res,"start")
		##DialogueManager.show_example_dialogue_balloon(preload("res://dialogue/main.dialogue"),"start")
	#pass
