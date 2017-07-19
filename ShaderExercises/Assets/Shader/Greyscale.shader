// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CGTestat/Greyscale"
{
    Properties
    {
        // Color property for material inspector, default to white
        _Color ("Main Color", Color) = (1,1,1,1)
  //      _isGray ("Grayscale", fixed) = 0
       
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            // vertex shader
            // this time instead of using "appdata" struct, just spell inputs manually,
            // and instead of returning v2f struct, also just return a single output
            // float4 clip position
            float4 vert (float4 vertex : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }
            
            // color from the material
            fixed4 _Color;
          

            // pixel shader, no inputs needed
            fixed4 frag () : SV_Target
            {
            	
       			float gray = dot(float3(0.3, 0.59, 0.11), _Color);
        		return gray;//(0.2126*Math.Pow(r, gamma) + 0.7152*Math.Pow(g, gamma) + 0.0722*Math.Pow(b, gamma));
            	
            	//return _Color; // just return it

              }
            ENDCG
        }
    }
}
