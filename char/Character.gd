class_name CharacterRole
extends Node

enum Char_name{
	PHOENIX,
	APOLLO,
	TRUCY
	
}
const CHAR_DETAIL:Dictionary={
	Char_name.PHOENIX:{
		"name":"Phoenix",
		"gender":"male",
		"res":preload("res://resources/phoneix.tres"),
		"Talk_idel":{
			"idel_talk":"idel",
			"confident-talking":"confident-idle",
			"happy-talking":"happy-idle",
		}
	},
	Char_name.TRUCY:{
		"name":"Trucy",
		"gender":"female",
		"res":preload("res://resources/trucy.tres"),
		"Talk_idel":{
			"idel_talk":"idel",
			"confident-talking":"confident-idle",
			"happy-talking":"happy-idle",
			
		}
	},
	Char_name.APOLLO:{
		"name":"Apollo",
		"gender":"male",
		"res":null
	}
	
}

static func get_enum_from_str(character_name:String)->int:
	#全部转换为大写
	character_name=character_name.to_upper()
	if Char_name.has(character_name):
		return Char_name[character_name]
	else:
		print("无效名字"+character_name)
		return -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
