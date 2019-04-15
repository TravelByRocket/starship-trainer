// gameState range 50-59
void finale_i(){ //gameState 50

	textAlign(CENTER,CENTER);
	text("FINALE\nPress SPACE.", width/2, height/2);

}

void finale_ii(){ //gameState 51
	textAlign(CENTER,CENTER);
	text("Finale Win", width/2, height/2);
}

void finale_iii(){ //gameState 52
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