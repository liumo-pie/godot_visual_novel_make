extends Node2D
@onready var character: Character = %character as Character
@onready var dialogue: Dialogue = %dialogue as Dialogue
@onready var next_line: AudioStreamPlayer = %next_line
@onready var next_line_time: Timer = %next_line_time
@onready var texture_rect: TextureRect = %TextureRect


const BackGround:Dictionary={
	"court":preload("res://background/court.tres"),
	"office":preload("res://background/office.tres"),
	"courtroom":preload("res://background/courtroom.tres"),
	"title_screen":preload("res://background/title_screen.tres")
}
#var phoneix=preload("res://resources/phoneix.tres")
#var trucy=preload("res://resources/trucy.tres")
var first_dianum:int
var dia_num:int
var add_content:bool=false
var  path:String= "res://story/dialogue_chat.json"
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
			
	if Input.is_action_pressed("deep_ask") and dia_num<dialogue_content.size()-1:
		var content=dialogue_content[dia_num]
		if add_content==true:
			dia_num=find_goto(first_dianum,"add")
			print("现在看看值"+str(dia_num))
			add_content=false
		
		

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
	print("这个是过滤器对应的内容:"+str(content))
	if content.has("next_scene"):
		path=content["next_scene"]
		json_to_content()
		dia_num=0
		dialogue_fliter()
		pass
	#具有跳转逻辑
	if content.has("location"):
		texture_rect.texture=BackGround[content["location"]]
		dia_num+=1
		dialogue_fliter()
		return
	if content.has("goto_add"):
		first_dianum=dia_num

	if content.has("goto"):
		#找到goto所在的位置
		dia_num=find_goto(0,content["goto"])
		dialogue_fliter()
		return
	if content.has("anchor"):
		dia_num+=1
		dialogue_fliter()
		return 
	if content.has("choice"):
		dialogue.show_choice(content["choice"])
	else:
		next_line.play()
		next_line_time.start()

func find_goto(pos:int,val:String)->int:
	print("pos值是"+str(pos))
	for i in range(pos,dialogue_content.size()-1):
		if dialogue_content[i].has("anchor") and dialogue_content[i]["anchor"]==val:
			#print("找到的跳转方向是"+str(i))
			return i
	printerr("不存在这个分支"+"goto的内容是"+str(val))
	return 0

		
func _on_finish_speaking()->void:
	character.anmi_play()
	pass



func _on_next_line_time_timeout() -> void:
	#print(dia_num)
	var content=dialogue_content[dia_num]
	#print(content)
	var charactername
	var express="idel_talk"
	var content_speaker=CharacterRole.get_enum_from_str(content["speaker"])
	if content.has("AnmiCharacter"):
		charactername=CharacterRole.get_enum_from_str(content["AnmiCharacter"])
	else:
		charactername=content_speaker
	
	if content.has("expression"):
		express=content["expression"]	
	character.set_anmi(charactername,express)
	dialogue.set_all_info(content_speaker,content["text"])
	if content.has("goto_add"):
		print("add_content的值是"+str(add_content))
		dia_num=find_goto(dia_num+2,"add")
		add_content=true
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
	dia_num=find_goto(0,val)
	dialogue_fliter()
	pass
