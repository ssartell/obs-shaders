uniform int scale = 2;
uniform float4x4 kernel = { 0, 8, 2, 10, 12, 4, 14, 6, 3, 11, 1, 9, 15, 7, 13, 5 };

float3 sample(float2 uv) {
    return image.Sample(textureSampler, uv).xyz;
}

float average(float3 p) {
    return .2126 * p.x + .7152 * p.y + .0722 * p.z;
}

float indexValue(float2 uv) {
    int x = floor(fmod(uv.x / scale, 4.));
    int y = floor(fmod(uv.y / scale, 4.));
    return kernel[x][y] / 16.0;
}

float dither(float2 uv, float col) {
    return (col < indexValue(uv)) ? 0. : 1.;
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 uv2 = v_in.uv * uv_size;

    uv2 = floor(uv2 / scale) * scale;
    float2 uv = uv2 / uv_size;

    float3 col = sample(uv).rgb;

    float d = dither(uv2, average(sample(uv)));

    //return float4(col.r, col.g, col.b, 1.0);
    return float4(d, d, d, 1.0);
}