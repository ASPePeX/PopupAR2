using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;
using System.Collections.Generic;
using UnityEngine.UI;

public class Sceneloader : MonoBehaviour {

    public Text sceneText;

    private string[] scenes;
    private int currIndex;

	// Use this for initialization
	void Start () {
        scenes = new string[4];

        scenes[0] = "1";
        scenes[1] = "2";
        scenes[2] = "3";
        scenes[3] = "4";

        SceneManager.LoadScene("1");
    }

    public void NextScene()
    {
        if (currIndex + 1 >= scenes.Length)
        {
            currIndex = 0;
        }
        else
        {
            currIndex += 1;
        }

        SceneManager.LoadScene(scenes[currIndex]);
        sceneText.text = scenes[currIndex];
    }

    public void PrevScene()
    {
        if (currIndex - 1 < 0)
        {
            currIndex = scenes.Length - 1;
        }
        else
        {
            currIndex -= 1;
        }

        SceneManager.LoadScene(scenes[currIndex]);
        sceneText.text = scenes[currIndex];
    }
}
