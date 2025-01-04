#version 410 core
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 tex_coord;

out vec3 norm;
out vec3 frag_pos;

uniform mat4 view;
uniform mat4 projection;
uniform mat4 model;

void main()
{
    frag_pos = vec3(model * vec4(position, 1.0));
    norm = mat3(transpose(inverse(model))) * normal;

    gl_Position = projection * view * model * vec4(position, 1.0);
}

