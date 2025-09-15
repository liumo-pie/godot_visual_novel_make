extends Node2D
@onready var character: Character = %character as Character
@onready var dialogue: Dialogue = %dialogue as Dialogue
@onready var next_line: AudioStreamPlayer = %next_line
@onready var next_line_time: Timer = %next_line_time

#var phoneix=preload("res://resources/phoneix.tres")
#var trucy=preload("res://resources/trucy.tres")
var dia_num:int
var char:String
#后面用resource替换
const dialogue_content:Array[String]=[
	"Phoneix:hello! i am about laugh",
	"Trucy:you are,... so poor dad",
	"Phoneix:doesnt,. matter,i have you",
	"Trucy:you are so great",
	"Phoneix:doesnt matter,i have you",
	"Trucy:you are so great",
	"Phoneix:doesnt matter,i have you",
	"Apollo:you guys are cute"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.finish_speaking.connect(_on_finish_speaking)
	dia_num=0
	char="Trucy"
	dialogue_fliter()
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("next_dia"):
		#print("可见字母"+str(dialogue.content.visible_characters)+"实际字母"+str(dialogue.content.text.length()))
		if dialogue.content.visible_characters<dialogue.content.text.length():
			dialogue.display_entire_dialogue()
		elif  dia_num<dialogue_content.size()-1:
			dia_num+=1
			dialogue_fliter()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#我写的代码功能不够细分，应该是分割再来一个函数，然后返回字典
func parse_line(content:String)->Dictionary:
	var arr_dia=content.split(":")
	assert(arr_dia.size()>=2)
	return {
		"Speaker_name":arr_dia[0],
		"Content":arr_dia[1]
	}

func dialogue_fliter()->void:
	next_line.play()
	next_line_time.start()

		
func _on_finish_speaking()->void:
	character.anmi_play()
	pass


func _on_next_line_time_timeout() -> void:
	var content:String=dialogue_content[dia_num]
	var line_info=parse_line(content)
	var charactername=CharacterRole.get_enum_from_str(line_info["Speaker_name"])
	character.set_anmi(charactername)
	dialogue.set_all_info(charactername,line_info["Content"])
	pass # Replace with function body.
