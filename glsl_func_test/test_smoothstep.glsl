const float line_width = 3.0; // 线宽
vec3 line_color = vec3(1.0, 0.4, 0.0); // 线的颜色
vec3 background_color = vec3(0.0, 1.0, 1.0); // 背景的颜色


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float delta = line_width * 0.001;
    vec2 p = fragCoord/iResolution.y;

    float time = iTime;
    
    // smoothstep的插值结果在[0,1]之间,但并不一定充满0-1
    // t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    // return t * t * (3.0 - 2.0 * t);
    // float an = smoothstep(0.0f,3.0f,sin(p.x*10.)+1.0);
    
    // 下面公式
    // t = clamp((x-(-0.1))/(0.1-(-0.1)), 0.0, 1.0)
    // t = clamp((x+0.1)*5, 0.0, 1.0)
    // 将x=sin(0.125*6.283185*(time+1.0/2.0))带入
    // x=sin(0.785398125*(time+0.5))
    // smoothstep(-0.1,0.1,sin(0.125*6.283185*(time+1.0/2.0)))的值是充满0-1的
    // 1-smoothstep(-0.1,0.1,sin(0.125*6.283185*(time+1.0/2.0)))的值是充满0-1的
    // float an = 0.3*(1.0-smoothstep(-0.1,0.1,sin(0.125*6.283185*(time+1.0/2.0))))是充满0-0.3的
    
    float an = 0.3*(1.0-smoothstep(-0.1,0.1,sin(0.125*6.283185*(time+1.0/2.0))));
    
    if (abs(p.y-an) <= delta) {
        fragColor = vec4(line_color, 1.0);
    } else {
        fragColor = vec4(background_color, 1.0);
    }
}