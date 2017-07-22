using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderChange : MonoBehaviour {

	public static Shader distanceShader;
	public Renderer renderer1;

	void Enable()
	{
		ShaderChangeManager.KeyPressed += ChangeToDistanceShader;
	}

	void Disable()
	{
		ShaderChangeManager.KeyPressed -= ChangeToDistanceShader;
	}

	void ChangeToDistanceShader()
	{
		distanceShader = Shader.Find("Diffuse");
		renderer1 = GetComponent<Renderer>();

		//if (renderer1.material.shader != distanceShader) 
		//{
		renderer1.material.shader = distanceShader;
		//}
	}
}
