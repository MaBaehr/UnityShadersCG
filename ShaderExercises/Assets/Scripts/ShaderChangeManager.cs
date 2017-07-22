using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderChangeManager : MonoBehaviour {
	public delegate void KeyPressAction();
	public static event KeyPressAction KeyPressed;

	void Update() {
		
		if (Input.GetKeyDown ("space") && KeyPressed != null) {
			KeyPressed();
		}
	}


	/*void onGUI(){
		if (GUI.Button (new Rect (Screen.width / 2 - 50, 5, 100, 30), "Click")) {
			if (KeyPressed != null)
				KeyPressed ();
		}
	}*/
}
