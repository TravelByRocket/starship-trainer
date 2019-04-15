// gameState range 10-19



void menu_i() {
	
	fill(255);
	textSize(48);
	textAlign(CENTER,BOTTOM);
	text("Choose your training mission:", width/2, height/4);

	// MENU ITEMS (3 positions, Left-to-Right, 0-indexed)
	menuItemDraw(0, asteroid, gameRed, defenseWin, defenseLabel);
	menuItemDraw(1, spacecraft, gameOrange, shooterWin, shooterLabel);
	menuItemDraw(2, rocket, gamePink, attackWin, attackLabel);
}

void menu_ii(){
	gameState = gameStateSelection; // go to selected game
}

// actionButtonMenu(){ // this game active/static conflict
	// if (gameState == 10) { 
	// 	gameState = gameStateSelection; // go to selected game
	// }
// }

void menuItemDraw(
	int thePosition, 
	PImage theIcon, 
	color theColor, 
	boolean theState, 
	PImage theName){

	// FUNCTION SETTINGS
	imageMode(CENTER);
	ellipseMode(CENTER); // this is the default but making eplicit
	float itemPosX = thePosition*width/3 + width/6;
	float itemPosY = height*2/3;
	float ringDiamOutside = width*0.30;
	// float ringDiamInside =  width*0.19;
	float iconHeight = width*0.35;
	float iconWidth = iconHeight;

	// DEACTIVATE COMPLETED LEVELS
	if (theState) { // if the level has been beaten
		tint(gameInactiveGray); // set the color to gray
	} else { // if it has not been beaten
		tint(theColor); // use the color assigned
	}

	// DRAW MENU RINGS

	image(missionRing, itemPosX, itemPosY, ringDiamOutside, ringDiamOutside);	

	// ellipse( // outside of the icon ring
	// 	itemPosX, // horizontal position, center of each of 3 columns
	// 	itemPosY, // vertical position
	// 	ringDiamOutside, // responsive width
	// 	ringDiamOutside); // repsonsive height
	// fill(0); //change to black for inside of ring
	// ellipse( // black inside of ring
	// 	itemPosX, // match center position of outside circle
	// 	itemPosY, // see above
	// 	ringDiamInside, // determines thickness of ring
	// 	ringDiamInside); // see above


	if(theState){
		tint(gameInactiveGray);
	} else {
		tint(gameWhite);
	}

	// DRAW THE ICON
	image(theIcon, 
		itemPosX, 
		itemPosY, 
		iconHeight, 
		iconWidth);

	// DRAW CHECKMARK IF COMPLETED
	if (theState) {
		tint(gameGreen);
		image(checkmark, 
			itemPosX, 
			itemPosY, 
			iconHeight*0.5, 
			iconWidth*0.5);
	}
	
	// DRAW SELECTION INDICATOR, DRAW LEVEL NAME, DETERMINE GAMESTATE IF SELECTED
	float commandPosition = leapInputsMenu();
	if( // do not draw the selection indicator of the level is completed
		commandPosition > thePosition*width/3 // if mouse to the right of the left limit
		&& commandPosition < (thePosition+1)*width/3){ // and if mouse to the left of the right limit
		// mouseX > thePosition*width/3 // if mouse to the right of the left limit
		// && mouseX < (thePosition+1)*width/3){ // and if mouse to the left of the right limit
		
		if(theState == false){ // and if the level has not been complete
			// LEVEL NAME
			tint(theColor);
			image(theName, width/2, height*2/5);

			// fill(theColor);
			// textSize(40);
			// textAlign(CENTER,BOTTOM);
			// text(theName, width/2, height*2/5);

			// SELECTION INDICATOR
			fill(gameWhite);
			rectMode(CENTER);
			rect(
				itemPosX,
				height*6/7,
				width/5,
				width/150);

			// GAME STATE SELECTION
			gameStateSelection = (thePosition+2)*10; // target cases 20, 30, & 40 from positions 0,1,2
			// println("gameStateSelection: "+gameStateSelection);
		} else { // selecting inactive section will keep in menu state
			gameStateSelection = 10; 
		}
	}
}

float leapInputsMenu(){ //better to call userLeapShooter?
	float commandPosition = width/2;
	// float commandPositionAVG;
	// float commandPosition00 = width/2;
	// float commandPosition01 = width/2;
	// float commandPosition02 = width/2;
	PVector handPosition;
	boolean handIsRight;

	for (Hand hand : leap.getHands()) {
		handPosition = hand.getStabilizedPosition();
		handIsRight = hand.isRight();
		if (handIsRight){
			commandPosition = map(handPosition.x,150,650,0,width);
		}
	
	}
	return commandPosition;
	// commandPosition02 = commandPosition01;
	// commandPosition01 = commandPosition00;
	
	// commandPositionAVG = (commandPosition00 + commandPosition01 + commandPosition02)/3;

	// if (commandPosition < player.posX-width/30){
	// 	player.floatLeft();
	// } else if (commandPositionAVG > player.posX+width/30) {
	// 	player.floatRight();
	// }
	
}