// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
Shader "CGTestat/HeatSurface"
{
	Properties
	{
		_HeatSourcePosition ("Heat Source Position",Vector) = (0,0,0)
		//_Color("Color",Color) = (0,0,0,1)
		_Distance("Distance", float) = 0
		_HeatSourceEnergy("Heat Source Energy", float) = 0
		_AbsorbtionPercentage("Absorbtion Percentage", float) = 0
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
					if (distance >= 1) {idx1 = idx2 = numberOfColors - 1; }
					else {
						distance = distance * (numberOfColors - 1);
						idx1 = (int) distance;
						idx2 = idx1 + 1;
						
						fractBetween = distance - (float)idx1;						
					}
				}
					
				float red = (color[idx2][0] - color[idx1][0])*fractBetween + color[idx1][0];
				float green = (color[idx2][1] - color[idx1][1])*fractBetween + color[idx1][1];
				float blue = (color[idx2][2] - color[idx1][2])*fractBetween + color[idx1][2];								
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

			float4 _HeatSourcePosition;
			//float4 _WindSourceVector;
			//float4 _Color;
			float _Distance;
			float _HeatSourceEnergy;
			float _AbsorbtionPercentage;
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				const float PI = 3.14159;

				float4 worldVertex = mul(unity_ObjectToWorld, v.vertex);
				float4 heatDirection = worldVertex - _HeatSourcePosition;
				float distance = length(worldVertex - _HeatSourcePosition);				

				float4 newWorldVertex = worldVertex;
				float crossProduct = dot(heatDirection, -v.normal);
				//float force = 1 / (2 * distance);				

				//newWorldVertex = worldVertex + ((1*force)*heatDirection);



				float incomingEnergy = _HeatSourceEnergy / (4 * PI * distance * distance);
				incomingEnergy = incomingEnergy * (1 - _AbsorbtionPercentage);
				
				
				float dotProduct = dot(heatDirection, - v.normal);
				float heatDirectionMagniture = length(heatDirection);
				float normalMagnitude = length(v.normal);
				float angle = dotProduct / (heatDirectionMagniture * normalMagnitude);

				o.color = getColorForDistance(incomingEnergy  * angle);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = i.color;
				return col;
			}

			ENDCG
		}
	}
}
