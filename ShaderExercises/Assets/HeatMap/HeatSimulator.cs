using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatSimulator : MonoBehaviour {

    public float temperature;
    public float surfaceSize;
    public float totalEnergy;

    static float bolzmannConst = 5.67f * Mathf.Pow(10, -8);
    float radius = 1;


    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {        
        surfaceSize = (4 / 3) * Mathf.PI * radius;

        totalEnergy = surfaceSize * bolzmannConst * Mathf.Pow(temperature, 4);
	}
}
