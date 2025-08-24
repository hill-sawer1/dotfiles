#version 450
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    float time;
};

void main() {
    vec2 resolution = vec2(1366, 768);
    vec2 uv = gl_FragCoord.xy / resolution;
    float noise = 0.5;
    vec3 fogColor = vec3(0.8, 0.9, 1.0);
    fragColor = vec4(fogColor, 0.5); // Force semi-transparent
}
