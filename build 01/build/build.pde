//**********************************************************************
// Program name      : .pde
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 20190311
// Purpose           : Arcade game powered by LEAP Motion gestures
// Revision History  : 
// 20190311 -- beginning of code
// 20190317 -- Completed working menu in Build 00. Beginning mini games.
//**********************************************************************

// CHOOSE GAME DISPLAY MODE (select/deselect with comments)
int gameMode = 0; // window, 1 screen
// int gameMode = 1; // fullscreen, 1 screen
// int gameMode = 2; // 1 screen, window, testing
// int gameMode = 3; // 2 screen, span

// DISPLAY DEBUGGING VISUAL GUIDES (select/deselect with comments)
boolean planMode = true; // do NOT display guides
// int planMode = 1; // DO display guides

// IMAGES (must be loaded in SETUP)
PImage asteroid;
PImage rocket;
PImage spacecraft;
PImage checkmark;

//COLORS
color gameOrange = #FC9A31;
color gamePink = #FD7DAC;
color gameRed = #FC2230;
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
			size(900,700);
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

	// IMAGES
	asteroid = loadImage("../../data/noun_asteroid_1827775_FFFFFF.png");
	rocket = loadImage("../../data/noun_Rocket_2275999_FFFFFF.png");
	spacecraft = loadImage("../../data/noun_spacecraft_854228_FFFFFF.png");
	checkmark = loadImage("../../data/noun_Check_929005_FFFFFF.png");
}

void draw() {
	background(0); // draw a black backround all the time
	inputManager(); // read and handle user inputs

	// println("gameState: "+gameState);
	switch(gameState) {
		case 0: // intro
			intro_i();
			break;
		case 1: // intro
			intro_ii();
			break;
		case 2: // intro
			intro_iii();
			break;
		case 10: // menu
			menu_i();
			break;
		case 11: // menu
			menu_ii();
			break;
		case 20: // defense
			defense_i();
			break;
		case 21: // defense
			defense_ii();
			break;
		case 22: // defense
			defense_iii();
			break;
		case 30: // shooter
			shooter_i();
			break;
		case 31: // shooter
			shooter_ii();
			break;
		case 32: // shooter
			shooter_iii();
			break;
		case 40: // attack
			attack_i();
			break;
		case 41: // attack
			attack_ii();
			break;
		case 42: // attack
			attack_iii();
			break;
		case 50: // finale
			finale_i();
			break;
		case 51: // finale
			finale_ii();
			break;
		case 52: // finale
			finale_iii();
			break;
	}

	if(planMode){
		textSize(24);
		textAlign(LEFT, BOTTOM);
		fill(255,0,0);
		text("PLANNING MODE "+str(round(frameRate))+" fps", 10, height);

		// ADD ANOTHER FOR SECOND SCREEEN
		// MAKE IT FLASH ON AND OFF
	}
}

void miniGameWin(){
	if (defenseWin && shooterWin && attackWin) {
		gameState = 50;
		// scene = 0;
	} else {
		gameState = 10;
		// scene = 0;
	}
}

void miniGameLoss(){
	gameState = 10;
	// scene = 0;
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
	if (gameState >= 20 && gameState <= 29) {
		userInputsDefense();
	} else if (gameState >= 30 && gameState < 39) {
		userInputsShooter();
	} else if (gameState >= 40 && gameState < 49) {
		userInputsAttack();
	} else if (gameState >= 50 && gameState < 59) {
		userInputsFinale();
	} else if (key == ' ') { // catch the remaining spacebar presses
		gameState++;
	}

	// JUMP TO GAME SECTIONS
	if (key == '0'){
		gameState = 0;
		scene = 0;
	} else if (key == '1'){
		gameState = 10;
		scene = 0;
	} else if (key == '2'){
		gameState = 20;
		scene = 0;
	} else if (key == '3'){
		gameState = 30;
		scene = 0;
	} else if (key == '4'){
		gameState = 40;
		scene = 0;
	} else if (key == '5'){
		gameState = 50;
		scene = 0;
	}
}

// input timeout
// Inputs from LEAP Motion, Keyboard, and external buttons
