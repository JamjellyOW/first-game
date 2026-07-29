extends CanvasLayer

@onready var final_score_label: Label = %FinalScoreLabel
@onready var final_time_label: Label = %FinalTimerLabel

func update_display(score_value: int, time_string: String) -> void:
	final_score_label.text = "Score: " + str(score_value)
	final_time_label.text = "Time: " + time_string
