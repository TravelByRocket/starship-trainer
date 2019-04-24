// gameState range 0-9

PImage intro00;

void introMain() {

	if (scene == 0) {
		placeMenuImage(intro00);
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