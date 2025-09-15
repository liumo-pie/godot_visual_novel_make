class_name  Dialogue extends Control
@onready var name_val: Label = %name_val
@onready var content: RichTextLabel = %content
@onready var timer: Timer = %Timer
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

const Character_audio={
	"male":preload("res://Audio/male.tres"),
	"female":preload("res://Audio/famale.tres")
}
signal finish_speaking
#添加一个状态值控制音频的播放
#var anmi_play:bool=false
var audio_index := 0
var audio_sequence := []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func set_name_val(val:CharacterRole.Char_name)->void:
	#name_val.text=CharacterRole.CHAR_DETAIL[val]["name"]
#
#func set_context(val:String)->void:
	#content.text=val
	#content.visible_characters=0
	#timer.start()
	##要匀速的显示文字，用循环的方式一个一个输出
	#pass

func set_all_info(val:CharacterRole.Char_name,dialogue_info:String)->void:
	name_val.text=CharacterRole.CHAR_DETAIL[val]["name"]
	content.text=dialogue_info
	content.visible_characters=0
	timer.start()
	play_audio()
	pass
	



func _on_timer_timeout() -> void:
	var audio_name=CharacterRole.get_enum_from_str(name_val.text)
	if content.visible_characters<content.text.length():
		content.visible_characters+=1
	else:
		
		timer.stop()
		finish_speaking.emit()
	pass # Replace with function body.

func display_entire_dialogue()->void:
	content.visible_characters=content.text.length()
	audio_stream_player.stop()
	timer.stop()
	finish_speaking.emit()
	pass

func play_audio()->void:
	while content.visible_characters<content.text.length():
		audio_stream_player.play()
		await audio_stream_player.finished
		var char_name=CharacterRole.get_enum_from_str(name_val.text)
		audio_stream_player.stream=Character_audio[CharacterRole.CHAR_DETAIL[char_name]["gender"]]
		audio_stream_player.play()
		await audio_stream_player.finished	

	pass
	
