Shader "CGTestat/DistanceToCamera"
{
Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                // Add a variable to carry depth information
                float depth : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Black = (0.0, 0.0, 0.0, 1.0);

            v2f vert (appdata v)
            {
                v2f o;
                //Built-in state variables in shader programs:
                //https://docs.unity3d.com/352/Documentation/Components/SL-BuiltinStateInPrograms.html

                // Transform vertex into view space UNITY_MATRIX_MV UnityObjectToViewPos
                o.vertex = mul(UNITY_MATRIX_MV, v.vertex);
                // Copy the viewspace z coordinate and call it depth
                o.depth = o.vertex.z;
                // Finish transforming the vertex by applying the projection matrix
                //UNITY_MATRIX_P -> Current projection matrix
                o.vertex = mul(UNITY_MATRIX_P, o.vertex);

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv); 
                // Blend colour using depth parameter we calculated earlier         
                return lerp(col, _Black, saturate(-0.05f * i.depth));
            }
            ENDCG
        }
    }
}