import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

//**********************************************************************
// Program name      : .pde
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 20190311
// Purpose           : 
// Revision History  : 
// 20190311 --  
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

//COLORS
int gameOrange = 0xffFC9A31;
int gamePink = 0xffFD7DAC;
int gameRed = 0xffFC2230;
int gameWhite = color(255);
int gameInactiveGray = (150);

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

public void settings() {
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

public void setup() {

	// IMAGES
	asteroid = loadImage("../../data/noun_asteroid_1827775_FFFFFF.png");
	rocket = loadImage("../../data/noun_Rocket_2275999_FFFFFF.png");
	spacecraft = loadImage("../../data/noun_spacecraft_854228_FFFFFF.png");
}

public void draw() {
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

public void miniGameWin(){
	if (defenseWin && shooterWin && attackWin) {
		gameState = 50;
		scene = 0;
	} else {
		gameState = 10;
		scene = 0;
	}
}

public void miniGameLoss(){
	gameState = 10;
	scene = 0;
}

public void resetGame(){
	gameState = 0;
	scene = 0;
	defenseWin = false;
	shooterWin = false;
	attackWin = false;
}

public void keyPressed() {
	// ADVANCE GAMESTATE WITH SPACEBAR
	if (key == ' '){
		if (gameState >= 20 && gameState <= 29) {
			actionButtonDefense();
		} else if (gameState >= 30 && gameState < 39) {
			actionButtonShooter();
		} else if (gameState >= 40 && gameState < 49) {
			actionButtonAttack();
		} else if (gameState >= 50 && gameState < 59) {
			actionButtonFinale();
		} else {
			gameState++;
		}
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
// gameState range 40-49
public void attack_i(){

	textAlign(CENTER,CENTER);
	text("Learn how to play. Press SPACE.", width/2, height/2);

}

public void attack_ii(){
	textAlign(CENTER,CENTER);
	text("Attack Game Win", width/2, height/2);
	attackWin = true;
}

public void attack_iii(){
	miniGameWin();
}

public void actionButtonAttack(){
	if(gameState == 40){
		gameState++;
	} else if (gameState == 41){
		gameState++;
	} else if (gameState == 42) {
		//no button needed
	}
}
// gameState range 20-29
public void defense_i(){ //gameState 20

	textAlign(CENTER,CENTER);
	text("Learn how to play. Press SPACE.", width/2, height/2);
	defenseWin = true;

}

public void defense_ii(){ //gameState 21
	textAlign(CENTER,CENTER);
	text("Defense Game Win", width/2, height/2);
	defenseWin = true;
}

public void defense_iii(){ //gameState 22
	miniGameWin();
}

public void actionButtonDefense(){
	if(gameState == 20){
		gameState++;
	} else if (gameState == 21){
		gameState++;
	} else if (gameState == 22) {
		//no button needed
	}
}

// if you lose the mini game then go back to menu
// if you win the mini game and if all others have been won then go to finale
// gameState range 50-59
public void finale_i(){ //gameState 50

	textAlign(CENTER,CENTER);
	text("FINALE\nPress SPACE.", width/2, height/2);

}

public void finale_ii(){ //gameState 51
	textAlign(CENTER,CENTER);
	text("Finale Win", width/2, height/2);
}

public void finale_iii(){ //gameState 52
	resetGame();
}

public void actionButtonFinale(){
	if(gameState == 50){
		gameState++;
	} else if (gameState == 51){
		gameState++;
	} else if (gameState == 52) {
		//no button needed
	}
}
public void inputManager(){
	
	

}
// gameState range 0-9
public void intro_i() {

	fill(200);
	textSize(40);
	textAlign(CENTER,BOTTOM);
	text("Welcome cadet,\n\nThere’s much to learn, and not much time.\nLet’s get started.",
		width/2, height/2);
	textSize(32);
	text("Press SPACE to continue...",width/2, height*2/3);
	
}

public void intro_ii(){
	fill(200);
	textSize(40);
	textAlign(CENTER,CENTER);
	text("We didn’t see them coming.\n\nThey attacked our planet, and destroyed our\nspace fleet.\n\nWe will have no defenses left and no way to\nprotect our planet...unless you can complete the\ntraining to become a space pilot.",
		width/2, height/2);	
}

public void intro_iii(){
	gameState = 10;
}
// gameState range 10-19
public void menu_i() {
	
	fill(255);
	textSize(48);
	textAlign(CENTER,BOTTOM);
	text("Choose your training mission:", width/2, height/4);

	// MENU ITEMS (3 positions, Left-to-Right, 0-indexed)
	menuItemDraw(0, asteroid, gameRed, defenseWin, "Planet Defense");
	menuItemDraw(1, spacecraft, gameOrange, shooterWin, "Enemy Encounter");
	menuItemDraw(2, rocket, gamePink, attackWin, "Base Attack");
}

public void menu_ii(){
	gameState = gameStateSelection; // go to selected game
}

// actionButtonMenu(){ // this game active/static conflict
	// if (gameState == 10) { 
	// 	gameState = gameStateSelection; // go to selected game
	// }
// }

public void menuItemDraw(
	int thePosition, 
	PImage theIcon, 
	int theColor, 
	boolean theState, 
	String theDescription){

	// FUNCTION SETTINGS
	imageMode(CENTER);
	ellipseMode(CENTER); // this is the default but making eplicit
	float itemPosX = thePosition*width/3 + width/6;
	float itemPozY = height*2/3;
	float ringDiamOutside = width*0.20f;
	float ringDiamInside =  width*0.19f;
	float iconHeight = width*0.15f;
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
// gameState range 30-39
public void shooter_i(){ //gameState 30

	textAlign(CENTER,CENTER);
	text("Learn how to play. Press SPACE.", width/2, height/2);
}

public void shooter_ii(){ //gameState 31
	textAlign(CENTER,CENTER);
	text("Shooter Game Win", width/2, height/2);
	shooterWin = true;
}

public void shooter_iii(){ //gameState 32
	miniGameWin();
}

public void actionButtonShooter(){
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
