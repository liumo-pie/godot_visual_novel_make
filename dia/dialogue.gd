class_name  Dialogue extends Control
@onready var name_val: Label = %name_val
@onready var content: RichTextLabel = %content
@onready var timer: Timer = %Timer
signal finish_speaking
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_context(val:String)->void:
	content.text=val
	content.visible_characters=0
	timer.start()
	#要匀速的显示文字，用循环的方式一个一个输出
	pass

func set_name_val(val:String)->void:
	name_val.text=val



func _on_timer_timeout() -> void:
	if content.visible_characters<content.text.length():
		content.visible_characters+=1
	else:
		
		timer.stop()
		finish_speaking.emit()
	pass # Replace with function body.
