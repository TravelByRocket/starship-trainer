// gameState range 30-39
void shooter_i(){ //gameState 30

	textAlign(CENTER,CENTER);
	text("Learn how to play. Press SPACE.", width/2, height/2);
}

void shooter_ii(){ //gameState 31
	textAlign(CENTER,CENTER);
	text("Shooter Game Win", width/2, height/2);
	shooterWin = true;
}

void shooter_iii(){ //gameState 32
	miniGameWin();
}

void actionButtonShooter(){
	if(gameState == 30){
		gameState++;
	} else if (gameState == 31){
		gameState++;
	} else if (gameState == 32) {
		//no button needed
	}
}






// if you lose the mini game then go back to menu
// if you win the mini game and if all others have been won then go to finale
