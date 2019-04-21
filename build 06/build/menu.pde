// gameState range 10-19

PImage rocket;
PImage spacecraft;
PImage missionRing;
PImage defenseLabel;
PImage shooterLabel;
PImage attackLabel;
PImage checkmark;
PImage asteroid;

PImage intro01;
PImage intro01Success;
PImage intro02;

boolean box1 = false;
boolean box2 = false;
boolean box3 = false;
boolean box4 = false;

void menuTraining(){ // gameState 10

	imageMode(CORNERS);
	if (!box1 || !box2 || !box3 || !box4){ // if at least one box is not yet triggered
		image(intro01, 0, 0, width, height);
	} else {
		image(intro01Success, 0, 0, width, height);
	}

	noStroke();

	rectMode(CORNERS);
	if (box1) {
		fill(gameGreen);
		rect(width*.05,height*.05,width*.15,height*.15);
	} else if (!box1) {
		fill(gameOrange);
		rect(width*.05,height*.05,width*.15,height*.15);
	}

	if (box2) {
		fill(gameGreen);
		rect(width*.85,height*.05,width*.95,height*.15);
	} else if (!box2) {
		fill(gameOrange);
		rect(width*.85,height*.05,width*.95,height*.15);
	}

	if (box3) {
		fill(gameGreen);
		rect(width*.05,height*.85,width*.15,height*.95);
	} else if (!box3) {
		fill(gameOrange);
		rect(width*.05,height*.85,width*.15,height*.95);
	}

	if (box4) {
		fill(gameGreen);
		rect(width*.85,height*.85,width*.95,height*.95);
	} else if (!box4) {
		fill(gameOrange);
		rect(width*.85,height*.85,width*.95,height*.95);
	}

	if (commandPositionX > width*.05 && commandPositionX < width*.15 && commandPositionY > height*0.05 && commandPositionY < height*0.15){
		box1 = true;
	} else if (commandPositionX > width*.85 && commandPositionX < width*.95 && commandPositionY > height*0.05 && commandPositionY < height*0.15){
		box2 = true;
	} else if (commandPositionX > width*.05 && commandPositionX < width*.15 && commandPositionY > height*0.85 && commandPositionY < height*0.95){
		box3 = true;
	} else if (commandPositionX > width*.85 && commandPositionX < width*.95 && commandPositionY > height*0.85 && commandPositionY < height*0.95){
		box4 = true;
	}

	if (scene == 0) {
		// run everything above
	} else if (scene == 1) {
		gameState++;
		scene=0;
	}

	leapManager();
}

void menuMain() { // gameState 11
	
	imageMode(CORNERS);
	image(intro02, 0, 0, width, height);

	// MENU ITEMS (3 positions, Left-to-Right, 0-indexed)
	menuItemDraw(0, asteroid, gameRed, defenseWin, defenseLabel);
	menuItemDraw(1, spacecraft, gameOrange, shooterWin, shooterLabel);
	menuItemDraw(2, rocket, gamePink, attackWin, attackLabel);

	leapManager();
	
}

void menuStory(){ // gameState 11
	gameState = gameStateSelection; // go to selected game
}

void menuItemDraw(
	int thePosition, 
	PImage theIcon, 
	color theColor, 
	boolean theState, 
	PImage theName){

	// FUNCTION SETTINGS
	imageMode(CENTER);
	ellipseMode(CENTER); // this is the default but making explicit
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

	if( // do not draw the selection indicator of the level is completed
		commandPositionX > thePosition*width/3 // if mouse to the right of the left limit
		&& commandPositionX < (thePosition+1)*width/3){ // and if mouse to the left of the right limit
		// mouseX > thePosition*width/3 // if mouse to the right of the left limit
		// && mouseX < (thePosition+1)*width/3){ // and if mouse to the left of the right limit
		
		if(theState == false){ // and if the level has not been complete
			// LEVEL NAME
			tint(theColor);
			image(theName, width/2, height*2/5);

			// SELECTION INDICATOR
			fill(gameWhite);
			noStroke();
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
			gameStateSelection = 11; 
		}
	}
}

void userInputsMenu(){
	if (key == ' ') {
		if(gameState == 10 && scene == 1){
			gameState++;
			scene = 0;
			box1 = false;
			box2 = false;
			box3 = false;
			box4 = false;
		} else if (gameState == 11){
			gameState++;
		} else if (gameState == 12) {
			//no button needed
		} else {
			scene++;
		}
	}
}

void loadMenuImages(){
	missionRing = loadImage("../../data/mission ring.png");
	defenseLabel = loadImage("../../data/planet defense text.png");
	shooterLabel = loadImage("../../data/enemy encounter text.png");
	attackLabel = loadImage("../../data/base attack text.png");
	checkmark = loadImage("../../data/noun_Check_929005_FFFFFF.png");
	asteroid = loadImage("../../data/planet defense icon.png");
	rocket = loadImage("../../data/base attack icon.png");
	spacecraft = loadImage("../../data/enemy encounter icon.png");
	intro01 = loadImage("../../data/intro01.png");
	intro02 = loadImage("../../data/intro02.png");
	intro01Success = loadImage("../../data/intro01Success.png");
		
}