using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour {
	public float speed = 10f;
	public float sensitivity = 10.0f;
	//public bool inverted = false;
	public string mouseHorizontalAxisName = "Mouse X";
	public string mouseVerticalAxisName = "Mouse Y";

	//	private float horizontalRotation;
	//	private float verticalRotation;
	//	private float z;
	//private Vector3 lastMouse = new Vector3 (255, 255, 255);

	void Start () {

	}

	// Update is called once per frame
	void Update () {
		// Mouse control
		//				lastMouse = Input.mousePosition - lastMouse;
		//				if (!inverted) {
		//					lastMouse.y = -lastMouse.y;
		//				}
		//				lastMouse *= sensitivity;
		//				lastMouse = new Vector3 (transform.eulerAngles.x + lastMouse.y, transform.eulerAngles.y + lastMouse.x, 0);

		//
		//		float horizontalRotation = -Input.GetAxis("mouseHorizontalAxisName") * Time.deltaTime * sensitivity;
		//		float verticalRotation = Input.GetAxis("mouseVerticalAxisName") * Time.deltaTime * sensitivity;
		//		float z = 0;
		//		transform.Rotate(horizontalRotation, verticalRotation, z);
		//transform.rotation = Quaternion.Euler(Mathf.Clamp(transform.rotation.eulerAngles.x, 0, 360.0f), Mathf.Clamp(transform.rotation.eulerAngles.y, 0, 360.0f), 0);
		//		transform.eulerAngles = new Vector3(horizontalRotation, verticalRotation, 0);
		//		//yaw
		float rotationX = Input.GetAxis(mouseHorizontalAxisName) * sensitivity;
		//transform.Rotate(0, rotationX, 0);
		//
		//		//pitch
		float rotationY = Input.GetAxis(mouseVerticalAxisName) * sensitivity;

		Vector3 euler = transform.eulerAngles;
		euler.z = transform.eulerAngles.z;
		//transform.Rotate(-rotationY, 0, 0);
		transform.Rotate(-rotationY,rotationX,-euler.z);



		//float rotationZ = transform.eulerAngles.rotationZ;
		//
		//

		// Keyboard control
		Vector3 dir = new Vector3 ();

		if (Input.GetKey (KeyCode.UpArrow)) {
			dir.z += speed;
		}
		if (Input.GetKey (KeyCode.DownArrow)){
			dir.z -= speed;
		}
		if (Input.GetKey (KeyCode.LeftArrow)){
			dir.x -= speed;
		}
		if (Input.GetKey (KeyCode.RightArrow)){
			dir.x += speed;
		}
		dir.Normalize ();

		transform.Translate (dir * speed * Time.deltaTime);

	}
}
