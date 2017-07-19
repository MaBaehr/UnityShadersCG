Shader "Unlit/NormalShader"
{
	// Tutorial - Vertex und Fragment Shader examples: https://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html 

	// Für den Normal Shader werden keine externen Properties benötigt

	SubShader
	{
		Pass
		{
			CGPROGRAM

			// Definition über die Shader die verwendet werden, und wie sie heißen
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			// Struct zum Austausch der Daten zwischen Vertex und Fragment Shader
			struct v2f
			{
				// Weitergabe der konvertierten Vertex Positionen in Homogenen Koordinaten
				float4 vertex : SV_POSITION;

				// Weitergabe der Normalen im Welt-Koordinaten system als interpolierten Wert (Ähnlich den Textur Koordinaten)
				half3 worldNormal : TEXCOORD0;
			};

			// Möglicher Ausgabe Struct des Fragment shaders
			struct fragmentOut
			{
				fixed4 color : SV_Target;
			};
			
			// VERTEX SHADER
			// 'appdata_base' ist ein standard struct das genutzt werden kann um den Vertex Shader mit Daten zu füttern
			// https://docs.unity3d.com/Manual/SL-VertexProgramInputs.html
			// http://wiki.unity3d.com/index.php?title=Shader_Code
			v2f vert (appdata_base vertexIn)
			{
				v2f vertexOut;

				// Transformation der Vertices aus Objekt-Koordinaten in Clip-Koordinaten
				vertexOut.vertex = UnityObjectToClipPos(vertexIn.vertex);

				// Transformation der Normalen in Welt-Koordinaten.
				vertexOut.worldNormal = UnityObjectToWorldNormal(vertexIn.normal);
				
				return vertexOut;
			}

			// FRAGMENT / PIXEL SHADER
			// Als input erhält er die interpolierten Output-Daten des Vertex-Shaders.
			// Dieser Typ des Fragment Shaders erfordert eigentlich kein Input, da er für jedes Fragment einfach nur eine Farbe zurück gibt.
			// Output ist 4d vector der die Farbe des Fragments/Pixels angibt.
			// SV_Target gibt an, dass es sich shcon um die "Target" Farbe handelt. Alternativ könnte auch das Struct fragmentOut
			// als Rückgabe des Fragment Shaders verwendet werden.
			fixed4 frag (v2f fragIn) : SV_Target
			{
				fixed4 color = 0;

				// Die Oberflächen-Normalen sind 3D Vektoren mit xyz komponenten, im Intervall von -1..1.
				// zur Anzeige wird es in das Interval von 0..1 gebracht, dann ergeben die xyz komponenten die rgb Werte
				// der einzufärbenden Farbe.
                color.rgb = fragIn.worldNormal*0.5+0.5;

                return color;
			}
			ENDCG
		}
	}
}
