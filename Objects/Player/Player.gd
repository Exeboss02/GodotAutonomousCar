extends Node3D

@export var camera : Camera3D
@onready var sub_vp: SubViewport = $SubViewport

var rng = RandomNumberGenerator.new()
var counter = 0
const path = "/home/exeboss/MinaFiler/Godot/Godot_v4.7.2-stable_mono_linux_x86_64/Images/Trafficlight2/trafficlight"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Testing testing...")

func CapturePNG(path: String) -> void:
	await RenderingServer.frame_post_draw  # make sure the frame is rendered
	var img: Image = sub_vp.get_texture().get_image()
	img.save_png(path)

func CaptureRawBytes() -> PackedByteArray:
	await RenderingServer.frame_post_draw
	var img: Image = sub_vp.get_texture().get_image()
	img.convert(Image.FORMAT_RGB8)  # known format for OpenCV
	return img.get_data()  # raw RGB bytes, ready for your Python socket


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counter < 50:
		var randomX = rng.randf_range(-996.0, -978.0)
		var randomY = rng.randf_range(13.0, 23.0)
		var randomZ = rng.randf_range(-200.0, -200.0,)
		camera.position = Vector3(randomX, randomY, randomZ)
		camera.rotation = Vector3(0, 4.0, 0)
		
		#camera.position = Vector3(-197.675, 19.214, -153.774)
		
		await CapturePNG(path + str(counter) + ".png")
		counter += 1
	
