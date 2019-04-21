// gameState range 50-59

PImage finalePre00;
PImage finalePre01;
PImage finalePre02;
PImage finalePre03;
PImage finalePost00;
PImage finalePost01;
PImage finalePost02;

void finaleIntro(){ //gameState 50

	tint(255);

	imageMode(CORNER);

	if (scene == 0) {
		image(finalePre00,0,0,width,height);
	} else if (scene == 1) {
		image(finalePre01,0,0,width,height);
	} else if (scene == 2) {
		image(finalePre02,0,0,width,height);
	} else if (scene == 3) {
		image(finalePre03,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
	}

}

void finaleTraining(){ //gameState 51
	gameState++;
}

void finaleGame(){ //gameState 52
	// textAlign(CENTER,CENTER);
	// text("Finale Win", width/2, height/2);
	gameState++;
}

void finaleStory(){ // gameState 53
	if (scene == 0) {
		// image(FinalePost00,0,0,width,height);
		image(finalePost01,0,0,width,height);
	} else if (scene == 1) {
		resetGame();
	}	
}

void userInputsFinale(){
	if (key == ' ') {
		scene++;
	}
}

void loadFinaleImages(){
	finalePre00 = loadImage("../../data/finalePre00.png");
	finalePre01 = loadImage("../../data/finalePre01.png");
	finalePre02 = loadImage("../../data/finalePre02.png");
	finalePre03 = loadImage("../../data/finalePre03.png");
	finalePost00 = loadImage("../../data/finalePost00.png");
	finalePost01 = loadImage("../../data/finalePost01.png");

}