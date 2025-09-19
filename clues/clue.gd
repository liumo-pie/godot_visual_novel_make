extends Area2D
@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var background: TextureRect = %Background
const addCollision=preload("res://clue_collision.tscn")
const adddialogue=preload("res://dia/dialogue.tscn")
const location="office"

#对应的线索文件
var path
#对应的线索值
var clues_val
#碰撞体的列表（碰撞体增加修改等对应该怎么看）
var shape_list: Array = []
#对话列表
var dia_arr
#遍历线索对话使用
var dia_num=0
#用于input触发
var empty_dia:Dialogue
#判断是否是线索触发之后的显示条件
var click_flag:bool=false
func _ready() -> void:
	#文件在ready的时候就要准备好了
	set_clue_scene()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("next_dia") and click_flag==true:
		if empty_dia.content.visible_characters<empty_dia.content.text.length():
			empty_dia.display_entire_dialogue()
		elif  dia_num<dia_arr.size()-1:
			dia_num+=1
			display_clue()
		else:
			click_flag=false
			dia_num=0
			empty_dia.queue_free()

func set_clue_scene()->void:
	var clue_location=Clues.get_cluescene_clue(location)
	print("clue val"+str(clue_location))
	#把里面的值都处理成可以用的形式
	background.texture=Clues.Clues_detail[clue_location]["background_res"]
	print("背景图案显示"+str(Clues.Clues_detail[clue_location]["background_res"]))
	print("对应文件显示"+str(Clues.Clues_detail[clue_location]["res"]))
	clues_val=file_access(Clues.Clues_detail[clue_location]["res"])
	#处理碰撞体并且添加
	print("clues_val:"+str(clues_val))
	for i in clues_val:
		add_collision(i)
	pass
func file_access(path_val:String):
	if not FileAccess.file_exists(path_val):
		printerr("文件不存在:"+str(path_val))
		return
	var file=FileAccess.open(path_val,FileAccess.READ)
	if file==null:
		printerr("文件打开失败:"+str(path_val))
	var cluesval=get_json_array(file.get_as_text())
	return cluesval

func get_json_array(str_val:String):
	#解析这个json文件,会被识别成字典数组
	var json_val=JSON.parse_string(str_val)
	if json_val==null:
		printerr("json解析失败："+str(str_val))
	return json_val
	
func add_collision(collision_val:Dictionary):
	#实例化之后，内部的值都是可以改变的，可以指定每个碰撞体的大小还有位置，不用怕大小改不了
	#print("碰撞信息"+str(collision_val))
	var new_collision=addCollision.instantiate()
	var rect_shape=RectangleShape2D.new()
	rect_shape.size=Vector2(collision_val["size"][0],collision_val["size"][1])
	#设置碰撞体的位置
	new_collision.position=Vector2(collision_val["position"][0],collision_val["position"][1])
	new_collision.shape=rect_shape
	new_collision.set_content(collision_val["clue_content"])
	add_child(new_collision)
	shape_list.append(new_collision)
	#设置碰撞体的大小
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var dialogue_text=adddialogue.instantiate()
			dia_arr=shape_list[shape_idx].get_content()
			canvas_layer.add_child(dialogue_text)
			empty_dia=dialogue_text
			print("是否添加成功：", dialogue_text)
			print("位置：", dialogue_text.position)
			print("是否可见：", dialogue_text.visible)
			print("大小：", dialogue_text.size)
			click_flag=true
			display_clue()
		pass
	pass # Replace with function body.

func display_clue()->void:
	var content=dia_arr[dia_num]
	#print("对话值是"+str(content))
	#print("不知道错在哪"+str(content["text"]))
	var content_speaker=CharacterRole.get_enum_from_str(content["speaker"])
	empty_dia.set_all_info(content_speaker,content["text"])
