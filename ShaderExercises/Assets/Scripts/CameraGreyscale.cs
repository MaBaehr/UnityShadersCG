using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CameraGreyscale : MonoBehaviour {

	public Material EffectMatierial;

	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		Graphics.Blit (src, dst, EffectMatierial);
	}


}

