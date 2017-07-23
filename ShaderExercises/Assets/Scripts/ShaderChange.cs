using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderChange : MonoBehaviour {

	public static Shader distanceShader;
	public static Shader heatShader;
	public static Shader originalShader;
	public Renderer renderer1;
	public MonoBehaviour greyScript;
	public GameObject cam;

	void OnEnable()
	{
		EventManager.Key0Pressed += ChangeToOriginalShader;
		EventManager.Key1Pressed += ChangeToGreyScaleShader;
		EventManager.Key2Pressed += ChangeToDistanceShader;
		EventManager.Key3Pressed += ChangeToHeatMapShader;

		renderer1 = GetComponent<Renderer>();
		originalShader = renderer1.material.shader;
		distanceShader = Shader.Find("CGTestat/DistanceToCamera");
		heatShader = Shader.Find("CGTestat/HeatSurface");

		cam = GameObject.Find ("Main Camera");
		greyScript = cam.GetComponent<CameraGreyscale> ();

	}

	void OnDisable()
	{
		EventManager.Key0Pressed -= ChangeToOriginalShader;
		EventManager.Key1Pressed -= ChangeToGreyScaleShader;
		EventManager.Key2Pressed -= ChangeToDistanceShader;
		EventManager.Key3Pressed -= ChangeToHeatMapShader;	}

	void ChangeToOriginalShader()
	{
		greyScript.enabled = false;
		if (renderer1.material.shader != originalShader) 
		{
			renderer1.material.shader = originalShader;
		}
	}

	void ChangeToGreyScaleShader()
	{
		greyScript.enabled = true;
	}

	void ChangeToDistanceShader()
	{		
		greyScript.enabled = false;
		if (renderer1.material.shader != distanceShader) 
		{
			renderer1.material.shader = distanceShader;
		}
	}

	void ChangeToHeatMapShader()
	{
		greyScript.enabled = false;
		if (renderer1.material.shader != heatShader) 
		{
			renderer1.material.shader = heatShader;
		}
	}

}
