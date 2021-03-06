﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatTarget : MonoBehaviour {


    [Range(0.0f, 1.0f)]
    public float absorbtionPercentage;
    public GameObject heatSource;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        if (heatSource != null)
        { 
            Vector4 posHeatSource = new Vector4(heatSource.transform.position.x, heatSource.transform.position.y, heatSource.transform.position.z, 1);

            this.GetComponent<MeshRenderer>().material.SetVector("_HeatSourcePosition", posHeatSource);            
            this.GetComponent<MeshRenderer>().material.SetFloat("_HeatSourceEnergy", heatSource.GetComponent<HeatSimulator>().totalEnergy);            
            this.GetComponent<MeshRenderer>().material.SetFloat("_AbsorbtionPercentage", absorbtionPercentage);
        }
    }
}