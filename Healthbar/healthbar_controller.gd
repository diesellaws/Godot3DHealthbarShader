extends MeshInstance3D


## BEFORE SETUP:
# Things you should know = You can resize the QUADMESH to any size you want. However, the actual healthbar sizing is controlled by the BAR SIZE and BORDER THICKNESS separately. So I would suggest getting the size you'd like for your QUADMESH first, then adjusting BAR SIZE and BORDER THICKNESS last. Also, I recommend doing this with 3 distinct colours so it's easy to tell where the edges match up to.

## 1. SETUP:
# Add this "healthbar" MeshInstance3D into an object and connect it in export/onready, then call setup_healthbar remotely
## Example: healthbar.setup_healthbar(0, enemy_hp_max, enemy_hp_max)

## 1.5 SETUP LOCALLY:
# If you'd prefer to setup locally by using the min/max values in this script, turn ON the bool "setup_in_ready"

## 2. TAKING DAMAGE
# When taking damage, call update_healthbar with the new value.
## Example: healthbar.update_healthbar(enemy_hp)

### DAMAGE DELAY/SPEED
# To make the damage delay take longer before kicking in, or slower to trickle down, adjust damage_update_delay and damage_update_speed

### DEPTH IN 3D
#The shader itself has depth_test_disabled. If you'd prefer to have your healthbars hidden by 3D objects based on position, remove that in render_mode.


@onready var material = get_material_override()
@export_category("Healthbar Values")
@export var max_hp: float = 100.0

@export_category("Healthbar Settings")
@export var setup_in_ready : bool = false
@export var damage_update_delay = 0.5  # Delay before starting to update the damage bar
@export var damage_update_speed = 1.0

@export_category("Additional Options")
@export var hide_healthbar_at_full_health : bool = true
@export var hide_healthbar_at_zero_health : bool = true

var normalized_health = 0.0
var health_progress = 1.0
var damage_progress = 1.0
var target_damage = 1.0
var damage_update_active = false
var accumulated_time = 0.0


func _ready():
    ## Duplicate the material so each healthbar is unique
    material = material.duplicate()
    set_material_override(material)

    ## Initialize the healthbar locally if bool is active
    if setup_in_ready:
        setup_healthbar(max_hp, max_hp)


func setup_healthbar(new_max_hp: float, current_hp: float):
    max_hp = new_max_hp

    health_progress = current_hp / max_hp
    var new_health_progress = clamp(health_progress, 0, max_hp)
    material.set_shader_parameter("health_progress", new_health_progress)
    material.set_shader_parameter("damage_progress", new_health_progress)
    damage_progress = new_health_progress
    target_damage = new_health_progress

    if hide_healthbar_at_full_health and current_hp == max_hp:
        visible = false

    if !hide_healthbar_at_full_health:
        visible = true


func update_healthbar(current_hp: float):
    health_progress = current_hp / max_hp
    var new_health_progress = clamp(health_progress, 0, max_hp)
    material.set_shader_parameter("health_progress", new_health_progress)
    target_damage = new_health_progress
    accumulated_time = 0
    damage_update_active = true

    if hide_healthbar_at_full_health and current_hp == max_hp:
        visible = false

    if !visible and !hide_healthbar_at_full_health and current_hp > 0:
        visible = true

    if !visible and hide_healthbar_at_full_health and current_hp < max_hp:
        visible = true

    if hide_healthbar_at_zero_health and current_hp <= 0:
        visible = false


func _process(delta):
    if damage_update_active:
        accumulated_time += delta
        if accumulated_time >= damage_update_delay:
            if damage_progress > target_damage:
                damage_progress -= delta * damage_update_speed
                if damage_progress < target_damage:
                    damage_progress = target_damage
                material.set_shader_parameter("damage_progress", damage_progress)
            else:
                damage_update_active = false

