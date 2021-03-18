uniform int scale = 2;
uniform float4x4 kernel = { 0, 8, 2, 10, 12, 4, 14, 6, 3, 11, 1, 9, 15, 7, 13, 5 };

float4 mainImage(VertData v_in) : TARGET
{
    float2 uv2 = v_in.uv * uv_size;

    uv2 = floor(uv2 / scale) * scale;
    float2 uv = uv2 / uv_size;

    return image.Sample(textureSampler, uv);
}