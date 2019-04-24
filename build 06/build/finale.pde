// gameState range 50-59

PImage finalePre00;
PImage finalePre01;
PImage finaleGame00;
PImage finalePostSuccess00;
PImage finalePostSuccess01;
PImage finalePostSuccess02;
PImage finalePostSuccess03;
PImage endCredits;

void finaleIntro(){ //gameState 50
	if (scene == 0) {
		placeMenuImage(finalePre00);
	} else if (scene == 1) {
		placeMenuImage(finalePre01);
	} else {
		gameState++;
		scene = 0;
	}
}

void finaleTraining(){ //gameState 51
	gameState++;
}

void finaleGame(){ //gameState 52
	
	if (scene == 0){
		placeMenuImage(finaleGame00);	
	} else if (scene == 1) {
		gameState++;
		scene = 0;
	}
	
}

void finaleStory(){ // gameState 53
	if (scene == 0) {
		placeMenuImage(finalePostSuccess00);
	} else if (scene == 1) {
		placeMenuImage(finalePostSuccess01);
	} else if (scene == 2) {
		placeMenuImage(finalePostSuccess02);
	} else if (scene == 2) {
		placeMenuImage(finalePostSuccess03);
	} else if (scene == 3) {
		placeMenuImage(endCredits);
	} else if (scene == 4) {
		resetGame();
	}
}

void userInputsFinale(){
	if (key == ' ') {
		scene++;
	}
}

void loadFinaleImages(){
	finalePre00 = requestImage("../../data/finalePre00.png");
	finalePre01 = requestImage("../../data/finalePre01.png");
	finaleGame00 = requestImage("../../data/finaleGame00.png");
	finalePostSuccess00 = requestImage("../../data/finalePostSuccess00.png");
	finalePostSuccess01 = requestImage("../../data/finalePostSuccess01.png");
	finalePostSuccess02 = requestImage("../../data/finalePostSuccess02.png");
	finalePostSuccess03 = requestImage("../../data/finalePostSuccess03.png");
	endCredits = requestImage("../../data/endCredits.png");
}