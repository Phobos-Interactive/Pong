extends PanelContainer

@onready var texture_rect = %TextureRect

func display(ball:BallType):
	texture_rect.texture = ball.texture
