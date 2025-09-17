extends Node2D
@onready var character: Character = %character as Character
@onready var dialogue: Dialogue = %dialogue as Dialogue
@onready var next_line: AudioStreamPlayer = %next_line
@onready var next_line_time: Timer = %next_line_time
const  path:String= "res://story/dialogue_chat.json"
#var phoneix=preload("res://resources/phoneix.tres")
#var trucy=preload("res://resources/trucy.tres")
var dia_num:int
#var char:String
#后面用resource替换
var dialogue_content:Array=[
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	json_to_content()
	dialogue.choice_press.connect(on_choose_button)
	dialogue.finish_speaking.connect(_on_finish_speaking)
	dia_num=0
	#char="Trucy"
	dialogue_fliter()
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("next_dia") and !dialogue_content[dia_num].has("choice"):
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
#func parse_line(content:String)->Dictionary:
	#var arr_dia=content.split(":")
	#assert(arr_dia.size()>=2)
	#return {
		#"Speaker_name":arr_dia[0],
		#"Content":arr_dia[1]
	#}

func dialogue_fliter()->void:
	#需要在这里添加判断
	var content=dialogue_content[dia_num]
	#具有跳转逻辑
	if content.has("goto"):
		#找到goto所在的位置
		dia_num=find_goto(content["goto"])
		dialogue_fliter()
	if content.has("anchor"):
		dia_num+=1
		dialogue_fliter()
	if content.has("choice"):
		dialogue.show_choice(content["choice"])
		pass
	else:
		next_line.play()
		next_line_time.start()

func find_goto(val)->int:
	for i in range(0,dialogue_content.size()-1):
		if dialogue_content[i].has("anchor") and dialogue_content[i]["anchor"]==val:
			print("找到的跳转方向是"+str(i))
			return i
	printerr("不存在这个分支"+"goto的内容是"+str(val))
	return 0

		
func _on_finish_speaking()->void:
	character.anmi_play()
	pass



func _on_next_line_time_timeout() -> void:
	#print("现在的语句是在"+str(dia_num))
	var content=dialogue_content[dia_num]
	#print("content 的内容是"+str(content))
	var charactername=CharacterRole.get_enum_from_str(content["speaker"])
	#因为有影响到角色的动画，所以在主场景进行判断
	character.set_anmi(charactername)
	dialogue.set_all_info(charactername,content["text"])
	pass # Replace with function body.

func json_to_content()->void:
	#添加一下文件的查错功能
	#查询是否存在文件
	if not FileAccess.file_exists(path):
		print("不存在文件"+path)
	var file=FileAccess.open(path,FileAccess.READ)
	#查询文件是否打开成功
	if file==null:
		print("文件打开失败"+path)
	#获取内容以string的形式
	dialogue_content=string_to_arrayString(file.get_as_text())	



func string_to_arrayString(content:String)->Array:
	var arr_content:Array=JSON.parse_string(content)
	if arr_content==null:
		print("文件解析失败"+path)
	return arr_content

func on_choose_button(val:String)->void:
	dia_num=find_goto(val)
	dialogue_fliter()
	pass
