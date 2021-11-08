float sdLine( in vec2 p, in vec2 a, in vec2 b )
{
    // ab代表一条线段
    // 这个函数是在计算p点到线段ab的距离
	vec2 pa = p - a;
	vec2 ba = b - a;
    
    // h是向量pa投影到向量ba上的长度，占ba长度的比例
    // ba*h就是pa在ba上的投影向量
    // pa-ba*h就是p点到ab的垂直向量，就是距离
	float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
	return length( pa - ba*h );
}


float line( in vec2 p, in vec2 a, in vec2 b, float w , float e)
{
    // sdLine( p, a, b )是p点到ab的距离
    // sdLine( p, a, b ) - w < 0的值经过smoothstep都会变为0
    // 也就是在线段ab w距离的点，该函数的输出为1
    // 该函数的输出
    // e限制了线段的分辨率
    return 1.0 - smoothstep( -e, e, sdLine( p, a, b ) - w );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

 	vec2 p = fragCoord/iResolution.x;
    vec2 q = p;
    p.x = mod(p.x,1.0/3.0) - 1.0/6.0;
    
    p.y -= 0.5*iResolution.y/iResolution.x;
    p.y += 0.04;
    
    float e = 1.0/iResolution.x;

    vec3 col = vec3(0.15);
    col = vec3(21,32,43)/255.0;

    // pe决定线的方向和长度
    vec2 pe = vec2(0.4, 0.6);
    
    float wi = 0.0015;
    
    col = mix( col, vec3(0.7), line(p, -0.12*pe, 0.12*pe, wi, e) );
    
    fragColor = vec4(col, 1.0);
    
}