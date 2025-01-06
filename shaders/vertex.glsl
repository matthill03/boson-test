#version 410 core
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 tex_coord;

// Per instance info
layout (location = 3) in mat4 model;

out vec3 norm;
out vec3 frag_pos;
out vec2 texture_coord;

uniform mat4 view;
uniform mat4 projection;
//uniform mat4 model;

void main()
{
    texture_coord = tex_coord;
    frag_pos = vec3(model * vec4(position, 1.0));
    norm = mat3(transpose(inverse(model))) * normal;

    gl_Position = projection * view * model * vec4(position, 1.0);
}

