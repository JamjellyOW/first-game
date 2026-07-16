extends CanvasLayer

var score = 0
@onready var score_label: Label = $ScoreLabel

var time_elapsed: float = 0.0
@onready var timer_label: Label = $TimerLabel
var is_timer_active: bool = true

func add_point():
	score += 1
	score_label.text = str(score)


func _process(delta: float) -> void:
	if is_timer_active:
		time_elapsed += delta
		timer_label.text = format_time(time_elapsed)

func format_time(time: float) -> String:
	var minutes: int = int(time / 60)
	var seconds: int = int(time) % 60
	# Multiply remainder by 100 to get centiseconds (hundredths of a second)
	var centiseconds: int = int((time - int(time)) * 100)
	
	# If under a minute, you can show just SS.CC (e.g., "04.25")
	# If over a minute, display MM:SS.CC (e.g., "01:05.12")
	if minutes > 0:
		return "%02d:%02d.%02d" % [minutes, seconds, centiseconds]
	else:
		return "%02d.%02d" % [seconds, centiseconds]
