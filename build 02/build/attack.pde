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

void userInputsAttack(){
	
	if (key == ' ') {
		if(gameState == 40){
			gameState++;
		} else if (gameState == 41){
			gameState++;
		} else if (gameState == 42) {
			//no button needed
		}
	}
	
}

void leapInputsAttack(){ //better to call userLeapShooter?
	float commandPositionAVG;
	float commandPosition00 = width/2;
	float commandPosition01 = width/2;
	float commandPosition02 = width/2;
	PVector handPosition;
	boolean handIsRight;

	for (Hand hand : leap.getHands()) {
		handPosition = hand.getStabilizedPosition();
		handIsRight = hand.isRight();
		if (handIsRight){
			commandPosition00 = map(handPosition.x,150,650,0,width);
		} 
	}

	commandPosition02 = commandPosition01;
	commandPosition01 = commandPosition00;
	
	commandPositionAVG = (commandPosition00 + commandPosition01 + commandPosition02)/3;

	if (commandPositionAVG < player.posX-width/30){
		player.floatLeft();
	} else if (commandPositionAVG > player.posX+width/30) {
		player.floatRight();
	}
	
}