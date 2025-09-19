class_name Clues extends Node
enum CLUESSCENE{
	OFFICE,
	COURT
}
const Clues_detail={
	CLUESSCENE.OFFICE:{
		"res":"res://story/office_clue.json",
		"background_res":preload("res://background/office.tres")
	},
	CLUESSCENE.COURT:{
		"res":"res://story/court_clue.json",
		"background_res":preload("res://background/court.tres")
		}
	
}

#加载线索文本的函数
static  func get_cluescene_clue(clue_scene:String)->CLUESSCENE:
	#变换为大写
	clue_scene=clue_scene.to_upper()
	if CLUESSCENE.has(clue_scene):
		#返回的是枚举值
		return CLUESSCENE[clue_scene]
	printerr("不存在该线索场景"+str(clue_scene))
	return -1
