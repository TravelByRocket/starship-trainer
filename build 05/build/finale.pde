// gameState range 50-59

PImage FinalePre00;
PImage FinalePre01;
PImage FinalePre02;
PImage FinalePre03;
PImage FinalePost00;
PImage FinalePost01;
PImage FinalePost02;

PImage finaleScreenAfter01;

void finaleIntro(){ //gameState 50
	// tint(255);
	// imageMode(CORNER);
	// image(finaleScreenAfter01, 0, 0, width, height);

	tint(255);

	imageMode(CORNER);

	if (scene == 0) {
		image(FinalePre00,0,0,width,height);
	} else if (scene == 1) {
		image(FinalePre01,0,0,width,height);
	} else if (scene == 2) {
		image(FinalePre02,0,0,width,height);
	} else if (scene == 3) {
		image(FinalePre03,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
	}

}

void finaleTraining(){ //gameState 51
	gameState++;
}

void finaleGame(){ //gameState 52
	textAlign(CENTER,CENTER);
	text("Finale Win", width/2, height/2);
}

void finaleStory(){
	resetGame();
}

void userInputsFinale(){
	if(gameState == 50){
		gameState++;
	} else if (gameState == 51){
		gameState++;
	} else if (gameState == 52) {
		//no button needed
	}
}

void loadFinaleImages(){
	FinalePre00 = loadImage("../../data/FinalePre00.png");
	FinalePre01 = loadImage("../../data/FinalePre01.png");
	FinalePre02 = loadImage("../../data/FinalePre02.png");
	FinalePre03 = loadImage("../../data/FinalePre03.png");
	FinalePost00 = loadImage("../../data/FinalePost00.png");
	FinalePost01 = loadImage("../../data/FinalePost01.png");
	FinalePost02 = loadImage("../../data/FinalePost02.png");

	finaleScreenAfter01 = loadImage("../../data/End screen 2-01.png");

}