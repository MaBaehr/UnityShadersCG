using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderChange : MonoBehaviour {

	public static Shader distanceShader;
	public static Shader heatShader;
	public static Shader originalShader;
	public Renderer renderer1;

	void OnEnable()
	{
		EventManager.Key0Pressed += ChangeToOriginalShader;
		EventManager.Key1Pressed += ChangeToGreyScaleShader;
		EventManager.Key2Pressed += ChangeToDistanceShader;
		EventManager.Key3Pressed += ChangeToHeatMapShader;

		renderer1 = GetComponent<Renderer>();
		originalShader = renderer1.material.shader;
	}

	void OnDisable()
	{
		EventManager.Key0Pressed -= ChangeToOriginalShader;
		EventManager.Key1Pressed -= ChangeToGreyScaleShader;
		EventManager.Key2Pressed -= ChangeToDistanceShader;
		EventManager.Key3Pressed -= ChangeToHeatMapShader;	}

	void ChangeToOriginalShader()
	{
		distanceShader = originalShader;

		if (renderer1.material.shader != distanceShader) 
		{
			renderer1.material.shader = distanceShader;
		}
	}

	void ChangeToGreyScaleShader()
	{
		
	}

	void ChangeToDistanceShader()
	{
		distanceShader = Shader.Find("CGTestat/DistanceToCamera");

		if (renderer1.material.shader != distanceShader) 
		{
			renderer1.material.shader = distanceShader;
		}
	}

	void ChangeToHeatMapShader()
	{
		heatShader = Shader.Find("CGTestat/HeatSurface");

		if (renderer1.material.shader != heatShader) 
		{
			renderer1.material.shader = heatShader;
		}
	}

}
