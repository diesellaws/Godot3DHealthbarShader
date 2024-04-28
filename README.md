# Godot 4 3D Healthbar Shader
A 3D Healthbar Shader with recent damage delay, built for Godot 4 - no viewports needed! 
---
When creating healthbars I had trouble finding good references for a basic shader-based 3D healthbar without needing viewports. So I built one, and decided to make it public! 
I worked to make it as simple and flexible as possible, while allowing anyone to build off it. 

https://youtu.be/fCPXheLS-oc

## WHAT IS IT?
It's a simple drag and drop node = A resized Quadmesh with a Shader Material and a healthbar_controller script.

![image](https://github.com/diesellaws/Godot3DHealthbarShader/assets/1047027/28a4cf26-c21b-43fb-b5fa-d147577abb18)


## BEFORE SETUP:
Resize the QUADMESH to any size you want. However, the actual healthbar sizing is controlled by the BAR SIZE and BORDER THICKNESS separately. So I would suggest getting the size you'd like for your QUADMESH first, then adjusting BAR SIZE and BORDER THICKNESS last. Also, I recommend doing this with 3 distinct colours so it's easy to tell where the edges match up to.

## 1. SETUP:
Add this "healthbar" MeshInstance3D into an object and connect it in export/onready, then call setup_healthbar remotely
> ## setup_healthbar(maximum_hp, current_hp)

## 1.5 SETUP LOCALLY:
If you'd prefer to setup locally by using the max values in this script, turn ON the bool "setup_in_ready"

## 2. TAKING DAMAGE
When taking damage, call update_healthbar with the new value.
> ## update_healthbar(new_hp)

### DAMAGE DELAY/SPEED
To make the damage delay take longer before kicking in, or slower to trickle down, adjust damage_update_delay and damage_update_speed

### DEPTH IN 3D
The shader itself has depth_test_disabled. If you'd prefer to have your healthbars hidden by 3D objects based on position, remove that in render_mode.
