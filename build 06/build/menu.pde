// gameState range 10-19

PImage menu00;
PImage menu01;
PImage menu02;

boolean box1 = false;
boolean box2 = false;
boolean box3 = false;
boolean box4 = false;

PImage attackIncomplete;
PImage attackSelected;
PImage defenseIncomplete;
PImage defenseSelected;
PImage shooterIncomplete;
PImage shooterSelected;

void menuTraining(){ // gameState 10

	imageMode(CORNERS);
	if (!box1 || !box2 || !box3 || !box4){ // if at least one box is not yet triggered
		placeMenuImage(menu00);
	} else {
		placeMenuImage(menu01);
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
		box1 = false;
		box2 = false;
		box3 = false;
		box4 = false;
		gameState++;
		scene=0;
	}

	leapManager();
}

void menuMain() { // gameState 11
	
	placeMenuImage(menu02);

	menuItemDraw(0, shooterWin);
	menuItemDraw(1, attackWin);
	menuItemDraw(2, defenseWin);

	leapManager();
	
}

void menuStory(){ // gameState 11
	gameState = gameStateSelection; // go to selected game
}

void menuItemDraw(int thePosition, boolean theState){

	imageMode(CORNERS);

	if(theState){
		// do nothing because the level is beaten and the background has inactive state
	} else if (!theState) {
		if (thePosition == 0){
			placeMenuImage(shooterIncomplete);
		} else if (thePosition == 1) {
			placeMenuImage(attackIncomplete);
		} else if (thePosition == 2) {
			placeMenuImage(defenseIncomplete);
		}
	}

	if(commandPositionX >= thePosition*width/3 
		&& commandPositionX < (thePosition+1)*width/3){ // if the cursor is in the correct third
		if(!theState){ // and if the level has not been completed
			gameStateSelection = (thePosition+2)*10; // target cases 20, 30, & 40 from positions 0,1,2
			if (thePosition == 0){
				placeMenuImage(shooterSelected);
				gameStateSelection = 30;
			} else if (thePosition == 1) {
				placeMenuImage(attackSelected);
				gameStateSelection = 40;
			} else if (thePosition == 2) {
				placeMenuImage(defenseSelected);
				gameStateSelection = 20;
			}
		} else {
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
	menu00 = requestImage("../../data/menu00.png");
	menu01 = requestImage("../../data/menu01.png");
	menu02 = requestImage("../../data/menu02.png");
	attackIncomplete = requestImage("../../data/attackIncomplete.png");
	attackSelected = requestImage("../../data/attackSelected.png");
	defenseIncomplete = requestImage("../../data/defenseIncomplete.png");
	defenseSelected = requestImage("../../data/defenseSelected.png");
	shooterIncomplete = requestImage("../../data/shooterIncomplete.png");
	shooterSelected = requestImage("../../data/shooterSelected.png");
		
}