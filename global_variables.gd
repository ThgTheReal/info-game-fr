extends Node


var RatKills

var Round

var comunismRatHealth
var comunismRatMaxHealth

var RatsNextRound
var RatCount
var startNextRound = true

func _ready() -> void:
	RatKills = 0 
	comunismRatHealth = 0
	comunismRatMaxHealth = 0
	Round = 0

func _process(delta: float) -> void:
	RatsNextRound = Round * 2
	if RatCount == 0:
		startNextRound = true
