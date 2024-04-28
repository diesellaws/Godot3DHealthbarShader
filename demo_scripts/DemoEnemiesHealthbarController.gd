extends Node3D

# JUST A DEMO, CORE CODE IS HIGHLIGHTED

@export var healthbar1 : Node3D
@export var healthbar2 : Node3D
@export var healthbar3 : Node3D

var damage_countdown = 1
var hp_1_max_health = 100
var hp_2_max_health = 200
var hp_3_max_health = 300

func _ready():
    #########################
    ##### SETUP HEALTHBAR CODE
    healthbar1.setup_healthbar(hp_1_max_health,hp_1_max_health)
    healthbar2.setup_healthbar(hp_2_max_health,hp_2_max_health)
    healthbar3.setup_healthbar(hp_3_max_health,hp_3_max_health)


func _physics_process(delta):
    #Crude countdown for demo purposes
    if damage_countdown > 0:
        damage_countdown -= delta
    else:
        damage_countdown = 1

        if hp_1_max_health <= 0:
            hp_1_max_health = 100
            healthbar1.setup_healthbar(hp_1_max_health,hp_1_max_health)
        else:
            hp_1_max_health -= randf_range(0,30)

        if hp_2_max_health <= 0:
            hp_2_max_health = 200
            healthbar2.setup_healthbar(hp_2_max_health,hp_2_max_health)
        else:
            hp_2_max_health -= randf_range(0,60)

        if hp_3_max_health <= 0:
            hp_3_max_health = 300
            healthbar3.setup_healthbar(hp_3_max_health,hp_3_max_health)
        else:
            hp_3_max_health -= randf_range(40,70)

        #########################
        ##### TAKE DAMAGE CODE
        healthbar1.update_healthbar(hp_1_max_health)
        healthbar2.update_healthbar(hp_2_max_health)
        healthbar3.update_healthbar(hp_3_max_health)

