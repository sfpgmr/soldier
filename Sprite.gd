tool
extends Sprite

export(bool) var show_sprites = false setget set_show_sprites
export(bool) var rotate_sprites = false setget set_rotate_sprites
export(float) var rotate_angle = false setget set_rotate_angle


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var txz = Transform2D()
# Translation
# Rotation
var rot = 0 # The rotation to apply.

func set_rotate_angle(v : float) :
	rot = v
	rotate_angle = v


func set_rotate_sprites(_rotate_sprites):
	txz.origin = Vector2(0, 0)
	rotate_sprites = _rotate_sprites

func set_show_sprites(_show_sprites):
	show_sprites = _show_sprites
	if show_sprites:
		render_sprites()
	else:
		clear_sprites()

func clear_sprites():
	for sprite in get_children():
		sprite.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	render_sprites() 

func render_sprites() :
	clear_sprites()
	for i in range(0,vframes):
		var next_sprite = Sprite.new()
		next_sprite.texture = texture
		next_sprite.vframes = vframes
		next_sprite.frame = i
		#next_sprite.position.x = -0.1 * i
		add_child(next_sprite)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rot += 1.0
	if rot > 360 : rot = 0 
	var rad : float = rot / 360 * 2 * PI 
	txz.x.x = cos(rad)
	txz.y.y = cos(rad)
	txz.x.y = sin(rad)
	txz.y.x = -sin(rad)
	txz.origin = Vector2(0,0)

	var i : float = -12.0
	get_node("../test").text = str(rot)
	for sprite in get_children():
		var pos : Vector2 = Vector2() 
		pos.x = 0.0
		pos.y = i
		pos = txz.xform(pos)
		if  rot >= 90 && rot <= 270 :
			sprite.z_index = -i
			sprite.position.x = pos.x
			sprite.flip_h = true			
		else :
			sprite.position.x = pos.x
			sprite.z_index = i
			sprite.flip_h = false			
		i += 1
#	rot = PI / 2  
#	if rot >=  2 * PI :
#		rot = rot - 2 * PI
		
