class_name  Dialogue extends Control
@onready var name_val: Label =%name_val
@onready var content: RichTextLabel = %content
@onready var timer: Timer = %Timer
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var audio_time: Timer = %audio_time
@onready var stop_time: Timer = %stop_time
@onready var choices_vbox: VBoxContainer = %choices_vbox

const choice_button=preload("res://choicebutton.tscn")
const letter=["!","?","."]
const Character_audio={
	"male":preload("res://Audio/male.tres"),
	"female":preload("res://Audio/famale.tres")
}
signal finish_speaking
signal choice_press(val:String)
func _ready() -> void:
	choices_vbox.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_all_info(val:CharacterRole.Char_name,dialogue_info:String)->void:
	print("啊啊啊啊啊啊啊啊啊"+CharacterRole.CHAR_DETAIL[val]["name"])
	print("aaaa"+dialogue_info)
	name_val.text=CharacterRole.CHAR_DETAIL[val]["name"]
	content.text=dialogue_info
	content.visible_characters=0
	timer.start()
	audio_time.start()
	pass
	



func _on_timer_timeout() -> void:
	var audio_name=CharacterRole.get_enum_from_str(name_val.text)
	if content.visible_characters<content.text.length():
		content.visible_characters+=1
		#添加句子和句子间的停顿
		var letter_word=content.text[content.visible_characters-1]
		if content.visible_characters<content.text.length()-1:
			var next_letter=content.text[content.visible_characters]
			if letter_word in letter and next_letter==" ":
				stop_time.start()
				audio_time.stop()
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
		var char_name=CharacterRole.get_enum_from_str(name_val.text)
		audio_stream_player.play_audio(char_name)



func _on_audio_time_timeout() -> void:
	if content.visible_characters<content.text.length():
		play_audio()
	else:
			audio_time.stop()


func _on_stop_time_timeout() -> void:
	audio_time.start()
	pass # Replace with function body.


func show_choice(choices:Array)->void:
	for childs in choices_vbox.get_children():
		childs.queue_free()
	for i in range(choices.size()) :
		var new_button=choice_button.instantiate()
		new_button.text=choices[i]["text"]
		choices_vbox.add_child(new_button)
		# bind起到了一个绑定参数的作用
		new_button.pressed.connect(one_choice_pressed.bind(choices[i]["goto"]))
	choices_vbox.show()
	pass

func one_choice_pressed(val:String)->void:
	choice_press.emit(val)
	choices_vbox.hide()
	pass
