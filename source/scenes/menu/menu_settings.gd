extends Node
class_name MenuSettings

var volume: int = 100
var brilho: int = 100
var base_light_energy: float = 1.0

var resolucoes = [Vector2i(1920, 1080), Vector2i(1600, 900), Vector2i(1366, 768), Vector2i(1280, 720)]
var res_idx: int = 0
var tela_cheia: bool = false

var luz_mesa: Light3D = null

func set_volume(valor: int) -> void:
	volume = clamp(volume + valor, 0, 100)
	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus, volume == 0)
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(volume / 100.0))

func set_brightness(valor: int) -> void:
	brilho = clamp(brilho + valor, 10, 100)
	if luz_mesa:
		luz_mesa.light_energy = base_light_energy * (brilho / 100.0)

func next_resolution() -> void:
	res_idx = (res_idx + 1) % resolucoes.size()
	DisplayServer.window_set_size(resolucoes[res_idx])

func toggle_fullscreen() -> void:
	tela_cheia = !tela_cheia
	var modo = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if tela_cheia else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(modo)

func resolution_string() -> String:
	return str(resolucoes[res_idx].x) + "x" + str(resolucoes[res_idx].y)
