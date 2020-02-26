extends Node2D

export var starting_position = 0.0
export var speed = 0.0
export var acceleration = 0.0
export var max_time = 0.0;

var starting_location = Vector2.ZERO
var ending_location;

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_location = position
	ending_location = position;
	ending_location.x = get_viewport().size.x - position.x
	
	starting_position = float(get_node("../EquationValues/PositionValue").text)
	speed = float(get_node("../EquationValues/SpeedValue").text)
	acceleration = float(get_node("../EquationValues/AccelerationValue").text)
	max_time = float(get_node("../Time/TimeValue").text)

func _process(delta):
	pass
	
func jump_to_time(time):
	position = lerp(starting_location, ending_location, time)
	evaluate_equation(time)
	
func evaluate_equation(time):
	var real_time = time * max_time
	
	var total_speed = speed + acceleration * real_time * real_time * 0.5
	var travelled_distance = speed * real_time + acceleration * real_time * real_time * 0.5
	var current_position = starting_position + travelled_distance

	$SpeedContainer/SpeedValue.text = "Greitis: " + String(total_speed) + " m/s"
	$PositionContainer/PositionValue.text = "Pozicija: " + String(current_position) + " m"
	$DeltaPosContainer/DeltaPosValue.text = "Kelias: " + String(travelled_distance) + " m"


func _on_Time_value_changed(value):
	jump_to_time(value)


func _on_SpeedValue_entered(new_text):
	speed = float(new_text)


func _on_AccelerationValue_entered(new_text):
	acceleration = float(new_text);


func _on_PositionValue_entered(new_text):
	starting_position = float(new_text)


func _on_TimeValue_entered(new_text):
	max_time = float(new_text)
