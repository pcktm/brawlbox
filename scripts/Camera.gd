extends Camera2D

export(float) var shakeDamping;
export(float) var shakeTreshold;

onready var CRTShader = (get_node("/root/CRTShader/ShaderRect").material) as ShaderMaterial;

var shakeAmount = 0;
var rng = RandomNumberGenerator.new();

func _ready():
	rng.randomize();

func shake(amount: float):
	shakeAmount = amount;
	CRTShader.set_shader_param("aberration_amount", abs(shakeAmount)*0.6 + 0.4);
	CRTShader.set_shader_param("boost", abs(shakeAmount)*0.05 + 1.38);

func reduceShake(delta: float):
	if shakeAmount > shakeTreshold:
		shakeAmount = shakeAmount - shakeAmount * shakeDamping * delta;
	else: 
		shakeAmount = 0;
	CRTShader.set_shader_param("aberration_amount", abs(shakeAmount)*0.6 + 0.4);
	CRTShader.set_shader_param("boost", abs(shakeAmount)*0.05 + 1.38);

func _process(delta):
	offset = Vector2(rng.randf_range(-1,1) * shakeAmount, rng.randf_range(-1,1) * shakeAmount);
	reduceShake(delta);
