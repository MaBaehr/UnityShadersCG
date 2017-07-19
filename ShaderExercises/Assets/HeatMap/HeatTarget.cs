using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatTarget : MonoBehaviour {

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

            Vector4 posMe = new Vector4(this.transform.position.x, this.transform.position.y, this.transform.position.z, 1);
            Vector4 difference = posHeatSource - posMe;
            float distance = difference.magnitude;

            HeatSimulator heatSimulator = heatSource.GetComponent<HeatSimulator>();
            
            this.GetComponent<MeshRenderer>().material.SetFloat("_Energy", heatSimulator.totalEnergy);
            this.GetComponent<MeshRenderer>().material.SetFloat("_Distance", distance);

        }
    }
}