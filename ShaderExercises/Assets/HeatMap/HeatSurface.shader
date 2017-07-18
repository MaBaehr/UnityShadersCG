// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
Shader "CGTestat/HeatSurface"
{
	Properties
	{
		_WindSourcePosition ("Wind Source Position",Vector) = (0,0,0)
		_Color("Color",Color) = (0,0,0,1)
		_Distance("Distance", float) = 0
		_Temperature("Temperature", float) = 0
	}

	CGINCLUDE	

			fixed4 getColorForDistance(float distance) {			
				// array for 4 colors: blue, green, yellow, red
				int numberOfColors = 4;
				float color[4][3] = { {0,0,1}, {0,1,0}, {1,1,0}, {1,0,0} };
				
				int idx1 = 0;
				int idx2 = 0;
				float fractBetween = 0;
				
				if (distance <= 0) { idx1 = idx2 = 0; }
				else {
					if (distance >= 1) {idx1 = idx2 = numberOfColors; }
					else {
						distance = distance * (numberOfColors - 1);
						idx1 = (int) distance;
						idx2 = idx1 + 1;
						
						fractBetween = distance - (float)idx1;						
					}
				}
					
				float blue = (color[idx2][0] - color[idx1][0])*fractBetween + color[idx1][0];
				float green = (color[idx2][1] - color[idx1][1])*fractBetween + color[idx1][1];
				float red = (color[idx2][2] - color[idx1][2])*fractBetween + color[idx1][2];								
				return fixed4(red, green, blue, 1);
			}

	ENDCG

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"			

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
			};

			float4 _WindSourcePosition;
			float4 _WindSourceVector;
			float4 _Color;
			float _Distance;
			
			v2f vert (appdata_base v)
			{
				v2f o;
				//o.vertex = UnityObjectToClipPos(v.vertex);
				float4 worldVertex = mul(unity_ObjectToWorld, v.vertex);
				float4 windDirection = worldVertex - _WindSourcePosition;
				float distance = length(worldVertex - _WindSourcePosition);				

				float4 newWorldVertex = worldVertex;
				float crossProduct = dot(windDirection, -v.normal);
				float force = 1 / (2 * distance);				

				newWorldVertex = worldVertex + ((1*force)*windDirection);
				
				o.color = getColorForDistance(distance / 10);
				o.vertex = mul(UNITY_MATRIX_VP, newWorldVertex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				//fixed4 col = _Color;
				fixed4 col = i.color;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}

			ENDCG
		}
	}
}
