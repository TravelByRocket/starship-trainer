// gameState range 40-49
void attack_i(){

	textAlign(CENTER,CENTER);
	text("Learn how to play. Press SPACE.", width/2, height/2);

}

void attack_ii(){
	textAlign(CENTER,CENTER);
	text("Attack Game Win", width/2, height/2);
	attackWin = true;
}

void attack_iii(){
	miniGameWin();
}

void actionButtonAttack(){
	if(gameState == 40){
		gameState++;
	} else if (gameState == 41){
		gameState++;
	} else if (gameState == 42) {
		//no button needed
	}
}