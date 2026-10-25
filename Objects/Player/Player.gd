extends Node3D

@export var camera : Camera3D
@export var object : Node3D
@onready var sub_vp: SubViewport = $SubViewport

var rng = RandomNumberGenerator.new()
var counter = 0
const path = "/home/exeboss/MinaFiler/Godot/Stopsigns2_2/stopsign"
const csvPath = "/home/exeboss/MinaFiler/Godot/Stopsigns2_2/stop_sign1_positions.csv"
var positions = {}

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
	
func SaveCSV(data):
	var file = FileAccess.open(csvPath, FileAccess.WRITE)
		
	for fname in data:
		var pos = data[fname]
		file.store_line("%s,%d,%d" % [fname, pos.x, pos.y])
		
	file.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counter < 50:
		var randomX = rng.randf_range(274.0, 309.0)
		var randomY = rng.randf_range(13.0, 23.0)
		var randomZ = rng.randf_range(-710, -734.0)
		camera.position = Vector3(randomX, randomY, randomZ)
		camera.rotation = Vector3(0, 1.3, 0)
		
		#last is 4
		
		var imageName = "stopsign" + str(counter)
		await CapturePNG(path + str(counter) + ".png")
		var pos_2d = camera.unproject_position(object.global_position)
		positions[imageName] = pos_2d
		counter += 1
		
	if counter == 50:
		SaveCSV(positions)
		counter += 1
	
