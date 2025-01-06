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

uniform Material material;
uniform vec3 light_pos;
uniform vec3 view_pos;

uniform sampler2D textures[10];

void main()
{

    vec3 diffuse_texture = vec3(texture(textures[diffuse_index], texture_coord));
    vec3 specular_texture = vec3(texture(textures[specular_index], texture_coord));

    // ambient
    float ambient_strength = 0.1;
    vec3 ambient = diffuse_texture * vec3(1.0f, 1.0f, 1.0f);

    // diffuse
    vec3 normal = normalize(norm);
    vec3 light_dir = normalize(light_pos - frag_pos);
    float diff = max(dot(normal, light_dir), 0.0);
    vec3 diffuse = (diff * diffuse_texture) * vec3(1.0f, 1.0f, 1.0f);

    // specular
    vec3 view_dir = normalize(view_pos - frag_pos);
    vec3 reflect_dir = reflect(-light_dir, normal);
    float spec = pow(max(dot(view_dir, reflect_dir), 0.0), material.shininess);
    vec3 specular = (specular_texture * spec) * vec3(1.0f, 1.0f, 1.0f);

    vec3 result = (ambient + diffuse + specular);

    frag_colour = vec4(result, 1.0f);
}

