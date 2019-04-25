//**********************************************************************
// Program name      : .pde
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 20190311
// Purpose           : Arcade game powered by LEAP Motion gestures
// Revision History  : 
// 20190311 -- beginning of code
// 20190317 -- Completed working menu in Build 00. Beginning mini games.
// 20190407 -- leaving the last user tested version as Build 03, preparing for next round of major edits
// 20190410 -- menu training and shooter training complete
//**********************************************************************

// Arcade screen dimensions 768x1366 (portrait orientation)
// aspect ratio of 0.562 or 1.779, which is 16:9

// import LEAP Motion library
import de.voidplus.leapmotion.*;
LeapMotion leap;

// CHOOSE GAME DISPLAY MODE (select/deselect with comments)
// int gameMode = 0; // window, 1 screen
// int gameMode = 1; // ATLAS EPO PRODUCTION fullscreen, external monitor
// int gameMode = 2; // window, square, 1:1
int gameMode = 3; // ATLAS EXPO PREP fullscreen, laptop monitor
// int gameMode = 4; // 1 screen, 1 window, split window

// DISPLAY DEBUGGING VISUAL GUIDES (select/deselect with comments)
// boolean planMode = true; // DO display guides
boolean planMode = false; // do NOT display guides

// IMAGES (must be loaded in SETUP)

PImage missionFail;
PImage firstPost00;
PImage firstPost01;
PImage secondPost00;
PImage secondPost01;

//COLORS
color gameOrange = #FF931E;
color gamePink = #FF7BAC;
color gameRed = #FF1D25;
color gameGreen = #43C93E;
color gameWhite = color(255);
color gameInactiveGray = color(100);

// STATE VARIABLES
int gameState = 0; // which phase is current, like intro, game 1, game 2, ending, etc
// game state values: 0 intro, 10 menu, 20 defense, 30 shooter, 40 attack, 50 finale
int scene = 0; // use to move between single steps within gameState

int gameStateSelection = 10; // hold the selected game value to be called on click
// (abve) default to 10 prevent game restart before mouse move on menu screen
// gameTime; // increments every time the game function in called
boolean defenseWin = false;
boolean shooterWin = false;
boolean attackWin = false;

int gHeightWindow; // game window height
int gWidthWindow; // game window width
int bHeightWindow; // background window height
int bWidthWindow; // background window width
int gHeightScreen; // game screen height
int gWidthScreen; // game screen width
int bHeightScreen; // background screen height
int bWidthScreen; // background screen width

int smallestDimension;

boolean peppersGhostOrientation = false;
// boolean peppersGhostOrientation = true;

void settings() {
	// pixelDensity(1);
	switch(gameMode) {
		case 0:
			// size(1008,630,P3D);
			float screenScale = 0.62;
			size(int(floor(768*screenScale)),int(floor(768*screenScale)),P3D);
			break;
		case 1:
			fullScreen(P3D);
			// surface.setSize(700,700);
			smallestDimension = min(width,height);
			gHeightWindow = 1080; // game window height
			gWidthWindow = 1080; // game window width
			bHeightWindow = 1080; // background window height
			bWidthWindow = 1080; // background window width
			// gHeightScreen = height; // game screen height
			// gWidthScreen = width; // game screen width
			// bHeightScreen = height; // background screen height
			// bWidthScreen = width; // background screen width
			break;
		case 2:
			size(768,768,P3D);
			break;
		case 3:
			fullScreen(P3D);
			// surface.setSize(700,700);
			smallestDimension = min(width,height);
			gHeightWindow = 800; // game window height
			gWidthWindow = 800; // game window width
			bHeightWindow = 800; // background window height
			bWidthWindow = 800; // background window width
			break;
		case 4:
			size(500, 700, P3D);
			smallestDimension = min(width,height);
			gHeightWindow = smallestDimension; // game window height
			gWidthWindow = smallestDimension; // game window width
			bHeightWindow = smallestDimension; // background window height
			bWidthWindow = smallestDimension; // background window width
			gHeightScreen = smallestDimension; // game screen height
			gWidthScreen = smallestDimension; // game screen width
			bHeightScreen = smallestDimension; // background screen height
			bWidthScreen = smallestDimension; // background screen width
			break;
	}
}

void setup() {
	leap = new LeapMotion(this).allowGestures("circle");



	// IMAGES
	missionFail = requestImage("../../data/missionFail.png");
	firstPost00 = requestImage("../../data/firstPost00.png");
	firstPost01 = requestImage("../../data/firstPost01.png");
	secondPost00 = requestImage("../../data/secondPost00.png");
	secondPost01 = requestImage("../../data/secondPost01.png");

	loadIntroImages();
	loadMenuImages();
	loadDefenseImages();
	loadShooterImages();
	loadAttackImages();
	loadFinaleImages();
	loadLeapImages();

}

void draw() {
	// println("width: "+width);
	// println("height: "+height);
	if (gameMode == 1){
		surface.setSize(1080,1080);
		surface.setLocation(-1080,200);
	} else if (gameMode == 3) {
		surface.setSize(800,800);
		surface.setLocation(200,50);
	}

	if (peppersGhostOrientation){
		pushMatrix();
		// rotate(PI/4);
		scale(1,-1,1);
		translate(0, -height, 0);
	}

	background(0); // draw a black backround all the time

	switch(gameState) {
		case 0: // intro
			introMain();
			break;
		case 10: // menu
			menuTraining();
			break;
		case 11: // menu
			menuMain();
			break;
		case 12: // menu
			menuStory();
			break;
		case 20: // defense
			defenseIntro();
			break;
		case 21: // defense
			defenseTraining();
			break;
		case 22: // defense
			defenseGame();
			break;
		case 23: // defense
			defenseStory();
			break;
		case 30: // shooter
			shooterIntro();
			break;
		case 31: // shooter
			shooterTraining();
			break;
		case 32: // shooter
			shooterGame();
			break;
		case 33: // shooter
			shooterStory();
			break;
		case 40: // attack
			attackIntro();
			break;
		case 41: // attack
			attackTraining();
			break;
		case 42: // attack
			attackGame();
			break;
		case 43: // attack
			attackStory();
			break;
		case 50: // finale
			finaleIntro();
			break;
		case 51: // finale
			finaleTraining();
			break;
		case 52: // finale
			finaleGame();
			break;
		case 53: // finale
			finaleStory();
			break;
		case 60: // miniGameWin
			miniGameWin();
			break;
		case 61: // miniGameWin
			miniGameLoss();
			break;
	}

	if(planMode){
		textSize(24);
		textAlign(LEFT, BOTTOM);
		fill(255,0,0);
		text("PLANNING MODE "+str(round(frameRate))+" fps", 10, height);
	}

	if (peppersGhostOrientation){
		popMatrix();
	}
}

int numGameWins = 0;

void miniGameWin(){ //gamestate 60

	if (scene == 0){
		numGameWins++;
		scene++;
	}

	if (numGameWins == 1) {
		if (scene == 1) {
			placeMenuImage(firstPost00);
		} else if (scene == 2) {
			placeMenuImage(firstPost01);
		} else if (scene == 3) {
			scene = 0;
			gameState = 11;
		}
	} else if (numGameWins == 2) {
		if (scene == 1) {
			placeMenuImage(secondPost00);
		} else if (scene == 2) {
			placeMenuImage(secondPost01);
		} else if (scene == 3) {
			scene = 0;
			gameState = 11;
		}
	} else if (numGameWins == 3) {
		scene = 0;
		gameState = 50;
	}
}

void miniGameLoss(){ //gamestate 61
	if (scene == 0) {
		placeMenuImage(missionFail);
	} else if (scene == 1) {
		gameState = 11;
		scene = 0;
	}
}

void resetGame(){
	gameState = 0;
	scene = 0;
	defenseWin = false;
	shooterWin = false;
	attackWin = false;
	numGameWins = 0;
}


void keyPressed() {
	// SEND ALL BUTTON PRESSES TO CURRENT MINI GAME
	if (gameState >=0 && gameState <9) {
		userInputsIntro();
	} else if (gameState >= 10 && gameState <= 19) {
		userInputsMenu();
	} else if (gameState >= 20 && gameState <= 29) {
		userInputsDefense();
	} else if (gameState >= 30 && gameState < 39) {
		userInputsShooter();
	} else if (gameState >= 40 && gameState < 49) {
		userInputsAttack();
	} else if (gameState >= 50 && gameState < 59) {
		userInputsFinale();
	} else if (gameState >= 60 && gameState < 69) {
		scene++;
	} else if (key == ' ') { // catch the remaining spacebar presses
		gameState++;
	}

	// JUMP TO GAME SECTIONS
	if (key == '0'){ // intro
		gameState = 0;
		scene = 0;
	} else if (key == '1'){ // menu
		gameState = 10;
		scene = 0;
	} else if (key == '2'){ // defense
		gameState = 20;
		scene = 0;
	} else if (key == '3'){ // shooter
		gameState = 30;
		scene = 0;
	} else if (key == '4'){ // attack
		gameState = 40;
		scene = 0;
	} else if (key == '5'){ // finale
		gameState = 50;
		scene = 0;
	} else if (key == 'r'){ // finale
		resetGame();
	}

	if (key == 'w'){
		println("gameState: "+gameState);
		println("scene: "+scene);
	}
}

void drawBackground(){

}

void placeMenuImage(PImage theImage){
	tint(255,255);
	imageMode(CENTER);
	// image(theImage, gWidthScreen/2, gHeightScreen/2, gWidthWindow, gHeightWindow);
	image(theImage, gWidthWindow/2, gHeightWindow/2, gWidthWindow, gHeightWindow);
}