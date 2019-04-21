// gameState range 0-9

PImage intro00;

void introMain() {
	
	imageMode(CORNER);

	if (scene == 0) {
		image(intro00,0,0,width,height);
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

void loadIntroImages(){
	intro00 = loadImage("../../data/intro00.png");
}