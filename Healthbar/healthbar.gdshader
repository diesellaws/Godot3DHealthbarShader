shader_type spatial;
render_mode unshaded, cull_back, depth_test_disabled;

// NOTE: QUAD MESH SIZE IS SET TO 1.665m x 0.22m

uniform float health_progress : hint_range(0.0, 1.0) = 1.0;
uniform float damage_progress : hint_range(0.0, 1.0) = 1.0;
uniform vec4 health_color : source_color = vec4(1.0, 0.7, 0.0, 1.0); // Yellow
uniform vec4 damage_color : source_color = vec4(0.83, 0.0, 0.13, 1.0); // Red
uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Black
uniform float border_thickness = 0.05;
uniform vec2 bar_size = vec2(0.5, 0.108);

void vertex() {
    // Adjust the UV coordinates based on the vertex positions to fit the bar within defined size
    UV = (VERTEX.xy + vec2(1, 1)) * 0.5 * bar_size;
    MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
    MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
    MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}


// Fragment shader portion
void fragment() {
    float inner_width = bar_size.x - 2.0 * border_thickness;
    float health_width = inner_width  * health_progress; // Width based on current health
    float damage_width = inner_width  * damage_progress; // Width up to where damage has occurred
    float inner_height = bar_size.y - 2.0 * border_thickness;
    vec2 inner_start = vec2(border_thickness, border_thickness);
    vec2 inner_end_health = vec2(health_width + border_thickness, inner_height + border_thickness);
    vec2 inner_end_damage = vec2(damage_width + border_thickness, inner_height + border_thickness);

    // First draw the damage bar if damage is greater than health
    if (damage_progress > health_progress && UV.x >= inner_end_health.x && UV.x <= inner_end_damage.x && UV.y >= inner_start.y && UV.y <= inner_height + border_thickness) {
        ALBEDO = damage_color.rgb;
        ALPHA = damage_color.a;
    }
    // Then draw the health bar
    else if (UV.x >= inner_start.x && UV.x <= inner_end_health.x && UV.y >= inner_start.y && UV.y <= inner_height + border_thickness) {
        ALBEDO = health_color.rgb;
        ALPHA = health_color.a;
    }
    // Background color
    else {
        ALBEDO = background_color.rgb;
        ALPHA = background_color.a;
    }
}
//
//
//// Fragment shader portion
//void fragment() {
    //float health_width = bar_size.x * health_progress; // Use the normalized health directly
    //float inner_height = bar_size.y - 2.0 * border_thickness;
    //vec2 inner_start = vec2(border_thickness, border_thickness);
    //vec2 inner_end = vec2(health_width + border_thickness, inner_height + border_thickness);
//
    //if (UV.x >= inner_start.x && UV.x <= inner_end.x && UV.y >= inner_start.y && UV.y <= inner_end.y) {
        //ALBEDO = health_color.rgb;
        //ALPHA = health_color.a;
    //} else {
        //ALBEDO = background_color.rgb;
        //ALPHA = background_color.a;
    //}
//}






//void fragment() {
    //float inner_width = bar_size.x - 2.0 * border_thickness;
    //float inner_height = bar_size.y - 2.0 * border_thickness;
    //vec2 inner_start = vec2(border_thickness, border_thickness);
    //vec2 inner_end = vec2(inner_width + border_thickness, inner_height + border_thickness);
//
        //// Check if within the health bar region
        //if (UV.x >= inner_start.x && UV.x <= inner_end.x * health_progress && UV.y >= inner_start.y && UV.y <= inner_end.y) {
            //ALBEDO = health_color.rgb;
            //ALPHA = health_color.a;
        //} else if (UV.x >= inner_start.x && UV.x <= inner_end.x * damage_progress && UV.y >= inner_start.y && UV.y <= inner_end.y) {
            //ALBEDO = damage_color.rgb;
            //ALPHA = damage_color.a;
        //} else {
            //ALBEDO = background_color.rgb;
            //ALPHA = background_color.a;
        //}
//}

