// gameState range 50-59
void finaleIntro(){ //gameState 50
	tint(255);
	imageMode(CORNER);
	image(finaleScreenAfter01, 0, 0, width, height);

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