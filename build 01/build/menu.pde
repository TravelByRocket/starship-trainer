// gameState range 10-19
void menu_i() {
	
	fill(255);
	textSize(48);
	textAlign(CENTER,BOTTOM);
	text("Choose your training mission:", width/2, height/4);

	// MENU ITEMS (3 positions, Left-to-Right, 0-indexed)
	menuItemDraw(0, asteroid, gameRed, defenseWin, "Planet Defense");
	menuItemDraw(1, spacecraft, gameOrange, shooterWin, "Enemy Encounter");
	menuItemDraw(2, rocket, gamePink, attackWin, "Base Attack");
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
	String theDescription){

	// FUNCTION SETTINGS
	imageMode(CENTER);
	ellipseMode(CENTER); // this is the default but making eplicit
	float itemPosX = thePosition*width/3 + width/6;
	float itemPozY = height*2/3;
	float ringDiamOutside = width*0.20;
	float ringDiamInside =  width*0.19;
	float iconHeight = width*0.15;
	float iconWidth = iconHeight;

	// DEACTIVATE COMPLETED LEVELS
	if (theState) { // if the level has been beaten
		fill(gameInactiveGray); // set the color to gray
	} else { // if it has not been beaten
		fill(theColor); // use the color assigned
	}

	// DRAW MENU RINGS
	ellipse( // outside of the icon ring
		itemPosX, // horizontal position, center of each of 3 columns
		itemPozY, // vertical position
		ringDiamOutside, // responsive width
		ringDiamOutside); // repsonsive height
	fill(0); //change to black for inside of ring
	ellipse( // black inside of ring
		itemPosX, // match center position of outside circle
		itemPozY, // see above
		ringDiamInside, // determines thickness of ring
		ringDiamInside); // see above
	if(theState){
		tint(gameInactiveGray);
	} else {
		tint(gameWhite);
	}

	// DRAW THE ICON
	image(theIcon, 
		itemPosX, 
		itemPozY, 
		iconHeight, 
		iconWidth);

	// DRAW CHECKMARK IF COMPLETED
	if (theState) {
		tint(gameGreen);
		image(checkmark, 
			itemPosX, 
			itemPozY, 
			iconHeight, 
			iconWidth);
	}
	
	// DRAW SELECTION INDICATOR, DRAW LEVEL NAME, DETERMINE GAMESTATE IF SELECTED
	if( // do not draw the selection indicator of the level is completed
		mouseX > thePosition*width/3 // if mouse to the right of the left limit
		&& mouseX < (thePosition+1)*width/3){ // and if mouse to the left of the right limit
		
		if(theState == false){ // and if the level has not been complete
			// LEVEL NAME
			fill(theColor);
			textSize(40);
			textAlign(CENTER,BOTTOM);
			text(theDescription, width/2, height*2/5);

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