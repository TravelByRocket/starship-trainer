// gameState range 0-9
void introMain() {
	
	imageMode(CORNER);

	if (scene == 0) {
		image(introScreen01,0,0,width,height);
	} else if (scene == 1) {
		image(introScreen02,0,0,width,height);
	} else {
		gameState = 10;
		scene = 0;
	}

}

void userInputsIntro(){
	if (key == ' ') {
		scene++;
	}

}
