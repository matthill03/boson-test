#version 410 core
out vec4 frag_colour;

in vec3 texture_coord;

uniform samplerCube skybox;

void main()
{
    // frag_colour = texture(skybox, texture_coord);
    frag_colour = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
