using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatSimulator : MonoBehaviour {

    public float temperature;        
    public float radius;
    public float totalEnergy;

    static float bolzmannConst = 5.67f * Mathf.Pow(10, -8);    


    // Use this for initialization
    void Start () {
        // initial temperature at game start
        temperature = 80;
        radius = 1;
	}
	
	// Update is called once per frame
	void Update () {

        // set size based on given radius
        Vector3 pos = new Vector3(radius, radius, radius);
        transform.localScale = pos;

        // calculate energy based on size
        float surfaceSize = (4 / 3) * Mathf.PI * radius;
        totalEnergy = surfaceSize * bolzmannConst * Mathf.Pow(temperature, 4);        
	}
}
