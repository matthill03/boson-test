#version 410 core
out vec4 frag_colour;

in vec3 norm;
in vec3 frag_pos;

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};

uniform Material material;
uniform vec3 light_pos;
uniform vec3 view_pos;

void main()
{
    // ambient
    float ambient_strength = 0.1;
    vec3 ambient = material.ambient * vec3(1.0f, 1.0f, 1.0f);

    // diffuse
    vec3 normal = normalize(norm);
    vec3 light_dir = normalize(light_pos - frag_pos);
    float diff = max(dot(normal, light_dir), 0.0);
    vec3 diffuse = (diff * material.diffuse) * vec3(1.0f, 1.0f, 1.0f);

    // specular
    vec3 view_dir = normalize(view_pos - frag_pos);
    vec3 reflect_dir = reflect(-light_dir, normal);
    float spec = pow(max(dot(view_dir, reflect_dir), 0.0), material.shininess);
    vec3 specular = (material.specular * spec) * vec3(1.0f, 1.0f, 1.0f);

    vec3 result = (ambient + diffuse + specular);

    frag_colour = vec4(result, 1.0f);
}

