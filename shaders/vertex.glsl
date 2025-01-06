#version 410 core
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 tex_coord;

// Per instance info
layout (location = 3) in mat4 model;
layout (location = 7) in int instance_diffuse;
layout (location = 8) in int instance_specular;

out vec3 norm;
out vec3 frag_pos;
out vec2 texture_coord;

out int diffuse_index;
out int specular_index;

uniform mat4 view;
uniform mat4 projection;
//uniform mat4 model;

void main()
{
    texture_coord = tex_coord;
    frag_pos = vec3(model * vec4(position, 1.0));
    norm = mat3(transpose(inverse(model))) * normal;

    diffuse_index = instance_diffuse;
    specular_index = instance_specular;

    gl_Position = projection * view * model * vec4(position, 1.0);
}

