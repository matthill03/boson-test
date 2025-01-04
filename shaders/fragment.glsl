#version 410 core
out vec4 frag_colour;

in vec3 norm;
in vec3 frag_pos;

struct Material {
    vec3 colour;
};

uniform Material material;
uniform vec3 light_pos;
uniform vec3 view_pos;

void main()
{
    // ambient
    float ambient_strength = 0.2;
    vec3 ambient = ambient_strength * vec3(1.0f, 1.0f, 1.0f);

    // diffuse 
    vec3 normal = normalize(norm);
    vec3 light_dir = normalize(light_pos - frag_pos);
    float diff = max(dot(normal, light_dir), 0.0);
    vec3 diffuse = diff * vec3(1.0f, 1.0f, 1.0f);

    // specular
    float specular_strength = 0.5;
    vec3 view_dir = normalize(view_pos - frag_pos);
    vec3 reflect_dir = reflect(-light_dir, normal);
    float spec = pow(max(dot(view_dir, reflect_dir), 0.0), 128);
    vec3 specular = specular_strength * spec * vec3(1.0f, 1.0f, 1.0f);

    vec3 result = (ambient * diffuse * specular) * material.colour;

    frag_colour = vec4(result, 1.0f);
}

