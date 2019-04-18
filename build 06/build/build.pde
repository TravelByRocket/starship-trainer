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
int gameMode = 0; // window, 1 screen
// int gameMode = 1; // fullscreen, 1 screen
// int gameMode = 2; // window, 1 screen, external monitor
// int gameMode = 3; // 2 screen, span

// DISPLAY DEBUGGING VISUAL GUIDES (select/deselect with comments)
boolean planMode = true; // DO display guides
// boolean planMode = false; // do NOT display guides

// IMAGES (must be loaded in SETUP)

PImage missionSuccess;
PImage missionFail;
PImage bgStars;
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
color gameInactiveGray = (100);

// STATE VARIABLES
int gameState = 0; // which phase is current, like intro, game 1, game 2, ending, etc
// game state values: 0 intro, 10 menu, 20 defense, 30 shooter, 40 attack, 50 finale
int scene = 0; // use to move between single steps within gameState

int gameStateSelection = 10; // hold the selected game value to be called on click
// (abve) default to 10 prevent game restart before mouse move on menu screen
// int gameTime; // increments every time the game function in called
boolean defenseWin = false;
boolean shooterWin = false;
boolean attackWin = false;



void settings() {
	switch(gameMode) {
		case 0:
			// size(1008,630,P3D);
			float screenScale = 0.62;
			size(int(floor(768*screenScale)),int(floor(1366*screenScale)),P3D);
			break;
		case 1:
			fullScreen();
			break;
		case 2:
			size(800,600);
			break;
		case 3:
			fullScreen(SPAN);
			break;
	}
}

void setup() {
	leap = new LeapMotion(this).allowGestures("circle");

	// IMAGES
	missionSuccess = loadImage("../../data/missionSuccess.png");
	missionFail = loadImage("../../data/missionFail.png");
	bgStars = loadImage("../../data/background.png");
	firstPost00 = loadImage("../../data/firstPost00.png");
	firstPost01 = loadImage("../../data/firstPost01.png");
	secondPost00 = loadImage("../../data/secondPost00.png");
	secondPost01 = loadImage("../../data/secondPost01.png");

	loadIntroImages();
	loadMenuImages();
	loadDefenseImages();
	loadShooterImages();
	loadAttackImages();
	loadFinaleImages();
	loadLeapImages();

}

void draw() {
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
	}

	if(planMode){
		textSize(24);
		textAlign(LEFT, BOTTOM);
		fill(255,0,0);
		text("PLANNING MODE "+str(round(frameRate))+" fps", 10, height);
	}
}

int numGameWins = 0;

void miniGameWin(){ //gamestate 60

	imageMode(CORNERS);
	if (scene == 0){
		numGameWins++;
		scene++;
	}

	if (numGameWins == 1) {
		if (scene == 1) {
			image(firstPost00, 0, 0, width, height);
		} else if (scene == 2) {
			image(firstPost01, 0, 0, width, height);
		} else if (scene == 3) {
			scene = 0;
			gameState = 11;
		}
	} else if (numGameWins == 2) {
		if (scene == 1) {
			image(secondPost00, 0, 0, width, height);
		} else if (scene == 2) {
			image(secondPost01, 0, 0, width, height);
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
	imageMode(CORNERS);
	if (scene == 0) {
		image(missionFail, 0, 0, width, height);
	} else if (scene == 1) {
		scene = 0;
		gameState = 11;
	}
}

void resetGame(){
	gameState = 0;
	scene = 0;
	defenseWin = false;
	shooterWin = false;
	attackWin = false;
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
	}
}

