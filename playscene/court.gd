extends Node2D
@onready var character: Character = %character as Character
#@onready var dialogue: Dialogue = %dialogue as Dialogue
@onready var balloon_scene: CanvasLayer = %ExampleBalloon

#const  balloon_scene=preload("res://dialogue/balloon.tscn")
const dia_res:Resource=preload("res://dialogue/main.dialogue")
#首先复刻一次下框和角色一直在的情况
func _ready() -> void:
	balloon_scene.set_character.connect(_on_example_balloon_set_character)
	balloon_scene.start(dia_res,"start")
	pass 

func _process(delta: float) -> void:
	pass
 
func _input(event: InputEvent) -> void:
	
	#if event.is_action("ui_accept"):    
		#var balloon=balloon_scene.instantiate()
		#add_child(balloon)
		#balloon.start(dia_res,"start")
		#DialogueManager.show_example_dialogue_balloon(preload("res://dialogue/main.dialogue"),"start")
	pass

func _on_example_balloon_set_character(character_name:String)->void:
	print("传来的值："+character_name)
	character.set_anmi(character_name)
	pass
