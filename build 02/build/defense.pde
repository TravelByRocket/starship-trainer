// gameState range 20-29
void defense_i(){ //gameState 20

	imageMode(CORNER);
	image(defenseScreen01,0,0,width,height);

}

void defense_ii(){ //gameState 21

	imageMode(CORNER);
	image(defenseBackground,0,0,width,height);

	// textAlign(CENTER,CENTER);
	// text("Defense Game Win", width/2, height/2);
	
}

void defense_iii(){ //gameState 22
	defenseWin = true;
	miniGameWin();
}

void userInputsDefense(){
	
	if (key == ' ') {
		if(gameState == 20){
			gameState++;
		} else if (gameState == 21){
			gameState++;
		} else if (gameState == 22) {
			//no button needed
		}	
	}
	
}

// if you lose the mini game then go back to menu
// if you win the mini game and if all others have been won then go to finale
