extends AudioStreamPlayer


const Character_audio={
	"male":preload("res://Audio/male.tres"),
	"female":preload("res://Audio/famale.tres")
}

func play_audio(name:CharacterRole.Char_name)->void:
	stream=Character_audio[CharacterRole.CHAR_DETAIL[name]["gender"]]
	play()
	pass
