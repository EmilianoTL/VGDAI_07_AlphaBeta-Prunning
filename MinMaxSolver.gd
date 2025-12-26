extends VBoxContainer

@onready var currentState: BoardState = BoardState.new()
@export var init_depth = 4
@onready var arr_buttons: Array= [[$Row0/Btn01, $Row0/Btn02, $Row0/Btn03, $Row0/Btn04],
					[$Row1/Btn11, $Row1/Btn12, $Row1/Btn13, $Row1/Btn14],
					[$Row2/Btn21, $Row2/Btn22, $Row2/Btn23, $Row2/Btn24],
					[$Row3/Btn31, $Row3/Btn32, $Row3/Btn33, $Row3/Btn34]]

func calculate_minmax(newState: BoardState, depth: int, minMax: bool = true) -> BoardState:
	var solutionValue: int = newState.evaluate_win()
	if solutionValue != 0 || depth == 0:
		return newState
		
	solutionValue = 99 #will be rewrited
	var solutionState:BoardState = null
	if minMax: #max
		for i in range(3):
			for j in range(3):
				if newState.get_pos(i,j) != 0:
					continue
					
				var testState:BoardState = BoardState.new()
				testState.state = newState.state.duplicate(true) #Duplicate node
				testState.set_pos(i,j,1)
				var resState:BoardState = calculate_minmax(testState, depth-1, false)
				if resState != null:
					var retVal:int = resState. evaluate_win()
					if (retVal > solutionValue || solutionValue == 99):
						solutionValue = retVal
						solutionState = testState
	else: #min
		for i in range(3):
			for j in range(3):
				if newState.get_pos(i,j) != 0:
					continue
					
				var testState: BoardState = BoardState.new()
				testState.state = newState.state.duplicate(true) #Duplicate node

				testState.set_pos(i,j,-1)
				var resState: BoardState = calculate_minmax(testState, depth-1, true)
				if resState != null:
					var retVal:int = resState. evaluate_win()
					if (retVal < solutionValue || solutionValue == 99) :
						solutionValue = retVal
						solutionState = testState
	return solutionState

func activate_button(x:int , y: int):
	currentState.set_pos(x,y,-1)
	if currentState.evaluate_win() == -1:
		print("YOU WIN")
		return
	#Enemy turn
	var newState:BoardState = calculate_minmax(currentState, init_depth)
	newState.evaluate_win()
	if newState != null:
		currentState = newState
	else:
		print ("empate")
		
	if currentState.evaluate_win() == 1:
		print("YOU LOSE!")

func update_visuals ():
	for i in range(4):
		for j in range(4):
			if currentState.get_pos(i,j) == -1:
				(arr_buttons[i][j] as Button).text = "X"
			elif currentState.get_pos(i, j) == 1:
				(arr_buttons[i][j] as Button).text = "0"


func _on_btn_01_pressed() -> void:
	activate_button(0,0)
	update_visuals ()


func _on_btn_02_pressed() -> void:
	activate_button(0,1)
	update_visuals ()


func _on_btn_03_pressed() -> void:
	activate_button(0,2)
	update_visuals ()


func _on_btn_04_pressed() -> void:
	activate_button(0,3)
	update_visuals ()


func _on_btn_11_pressed() -> void:
	activate_button(1,0)
	update_visuals ()


func _on_btn_12_pressed() -> void:
	activate_button(1,1)
	update_visuals ()

func _on_btn_13_pressed() -> void:
	activate_button(1,2)
	update_visuals ()

func _on_btn_14_pressed() -> void:
	activate_button(1,3)
	update_visuals ()

func _on_btn_21_pressed() -> void:
	activate_button(2,0)
	update_visuals ()


func _on_btn_22_pressed() -> void:
	activate_button(2,1)
	update_visuals ()


func _on_btn_23_pressed() -> void:
	activate_button(2,2)
	update_visuals ()


func _on_btn_24_pressed() -> void:
	activate_button(2,3)
	update_visuals ()


func _on_btn_31_pressed() -> void:
	activate_button(3,0)
	update_visuals ()


func _on_btn_32_pressed() -> void:
	activate_button(3,1)
	update_visuals ()


func _on_btn_33_pressed() -> void:
	activate_button(3,2)
	update_visuals ()


func _on_btn_34_pressed() -> void:
	activate_button(3,3)
	update_visuals ()
