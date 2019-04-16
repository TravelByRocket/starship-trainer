// gameState range 0-9

PImage Intro00;
PImage Intro01;

void introMain() {
	
	imageMode(CORNER);

	if (scene == 0) {
		image(Intro00,0,0,width,height);
	} else if (scene == 1) {
		image(Intro01,0,0,width,height);
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
	Intro00 = loadImage("../../data/Intro00.png");
	Intro01 = loadImage("../../data/Intro01.png");
}