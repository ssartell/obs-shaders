uniform float4 lu;

float luma(float3 color) 
{
    return dot(color, lu);
    // float3(.299, .587, .114) // standard luma
}

float4 mainImage(VertData v_in) : TARGET
{
    float c = 0.75 + 0.25 * sin((v_in.uv.x + v_in.uv.y) * 600.0);
    
    float3 color = image.Sample(textureSampler, v_in.uv).rgb;
    float l = luma(color);

    float f = smoothstep(0.5 * c, c, l);
    f = smoothstep(.0, .5, f);
    
    //return float4(c, c, c, 1.);
    return float4(f, f, f, 1.);
}