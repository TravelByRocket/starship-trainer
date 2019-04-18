// gameState range 0-9

PImage intro00;
PImage intro01;
PImage intro02;

void introMain() {
	
	imageMode(CORNER);

	if (scene == 0) {
		image(intro00,0,0,width,height);
	} else if (scene == 1) {
		image(intro01,0,0,width,height);
		leapManager();
	}  else if (scene == 2) {
		image(intro02,0,0,width,height);
		leapManager();
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
	intro01 = loadImage("../../data/intro01.png");
	intro02 = loadImage("../../data/intro02.png");
}