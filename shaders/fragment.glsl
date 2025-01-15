#version 410 core
out vec4 frag_colour;

in vec3 norm;
in vec3 frag_pos;
in vec2 texture_coord;

flat in int diffuse_index;
flat in int specular_index;

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};

struct DirectionalLight {
    vec3 direction;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

struct PointLight {
    vec3 position;

    float constant;
    float linear;
    float quadratic;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform Material material;
uniform vec3 view_pos;

uniform DirectionalLight directional_light;
uniform PointLight point_lights[4];
uniform int num_point_lights;

uniform sampler2D textures[10];

vec3 calculate_directional_light(DirectionalLight light, vec3 normal, vec3 view_direction) {
    vec3 diffuse_texture = vec3(texture(textures[diffuse_index], texture_coord));
    vec3 specular_texture = vec3(texture(textures[specular_index], texture_coord));

    vec3 light_direction = normalize(-light.direction);
    vec3 halfway_direction = normalize(light_direction + view_direction);

    // Calculate diffuse lighting
    float diff = max(dot(normal, light_direction), 0.0);


    float spec = 0.0;
    spec = pow(max(dot(halfway_direction, normal), 0.0), material.shininess);

    // if (material_type == 0) {
    //     spec = pow(max(dot(halfway_direction, normal), 0.0), colour_material.base.shininess);
    // } else {
    //     spec = pow(max(dot(halfway_direction, normal), 0.0), texture_material.base.shininess);
    // }

    vec3 ambient = vec3(0.0);
    vec3 diffuse = vec3(0.0);
    vec3 specular = vec3(0.0);

    ambient = light.ambient * diffuse_texture;
    diffuse = light.diffuse * diff * diffuse_texture;
    specular = light.specular * spec * specular_texture;

    // if (material_type == 0) {
    //     ambient = light.ambient * colour_material.ambient;
    //     diffuse = light.diffuse * diff * colour_material.diffuse;
    //     specular = light.specular * spec * colour_material.specular;
    // } else {
    //     ambient = light.ambient * vec3(texture(texture_material.diffuse, TexCoord));
    //     diffuse = light.diffuse * diff * vec3(texture(texture_material.diffuse, TexCoord));
    //     specular = light.specular * spec * vec3(texture(texture_material.specular, TexCoord));
    // }

    // Combine result
    return (ambient + diffuse + specular);
}

vec3 calculate_point_light(PointLight light, vec3 normal, vec3 fragment_position, vec3 view_direction) {
    vec3 diffuse_texture = vec3(texture(textures[diffuse_index], texture_coord));
    vec3 specular_texture = vec3(texture(textures[specular_index], texture_coord));

    vec3 light_direction = normalize(light.position - fragment_position);
    vec3 halfway_direction = normalize(light_direction + view_direction);

    // diffuse shading
    float diff = max(dot(normal, light_direction), 0.0);

    float spec = 0.0;
    spec = pow(max(dot(normal, halfway_direction), 0.0), material.shininess);

    // if (material_type == 0) {
    //     spec = pow(max(dot(normal, halfway_direction), 0.0), colour_material.base.shininess);
    // } else {
    //     spec = pow(max(dot(normal, halfway_direction), 0.0), texture_material.base.shininess);
    // }

    // attenuation
    float distance = length(light.position - fragment_position);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));

    vec3 ambient = vec3(0.0);
    vec3 diffuse = vec3(0.0);
    vec3 specular = vec3(0.0);

    ambient = light.ambient * diffuse_texture * attenuation;
    diffuse = light.diffuse * diff * diffuse_texture * attenuation;
    specular = light.specular * spec * specular_texture * attenuation;

    // if (material_type == 0) {
    //     ambient = light.ambient * colour_material.ambient * attenuation;
    //     diffuse = light.diffuse * diff * colour_material.diffuse * attenuation;
    //     specular = light.specular * spec * colour_material.specular * attenuation;
    // } else {
    //     ambient = light.ambient * vec3(texture(texture_material.diffuse, TexCoord)) * attenuation;
    //     diffuse = light.diffuse * diff * vec3(texture(texture_material.diffuse, TexCoord)) * attenuation;
    //     specular = light.specular * spec * vec3(texture(texture_material.specular, TexCoord)) * attenuation;
    // }

    return (ambient + diffuse + specular);
}

void main()
{

    vec3 normal = normalize(norm);
    vec3 view_dir = normalize(view_pos - frag_pos);

    vec3 result = calculate_directional_light(directional_light, normal, view_dir);

    for (int i = 0; i < num_point_lights; i++) {
        result += calculate_point_light(point_lights[i], normal, frag_pos, view_dir);
    }

    //vec3 result = (ambient + diffuse + specular);

    frag_colour = vec4(result, 1.0f);
}

