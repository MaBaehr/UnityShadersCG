using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventManager : MonoBehaviour {
	public delegate void KeyPressAction();
	public static event KeyPressAction Key0Pressed;
	public static event KeyPressAction Key1Pressed;
	public static event KeyPressAction Key2Pressed;
	public static event KeyPressAction Key3Pressed;


	void Update() {

		if (Input.GetKeyDown(KeyCode.Alpha0) && Key0Pressed != null) {
			Key0Pressed();
		} else if (Input.GetKeyDown(KeyCode.Alpha1) && Key1Pressed != null) {
			Key1Pressed();
		} else if (Input.GetKeyDown(KeyCode.Alpha2) && Key2Pressed != null) {
			Key2Pressed();
		} else if (Input.GetKeyDown(KeyCode.Alpha3) && Key3Pressed != null) {
			Key3Pressed();
		}
	} 
		
}
