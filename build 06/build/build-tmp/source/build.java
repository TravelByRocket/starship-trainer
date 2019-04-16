import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.voidplus.leapmotion.*; 

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
// Purpose           : Arcade game powered by LEAP Motion gestures
// Revision History  : 
// 20190311 -- beginning of code
// 20190317 -- Completed working menu in Build 00. Beginning mini games.
// 20190407 -- leaving the last user tested version as Build 03, preparing for next round of major edits
// 20190410 -- menu training and shooter training complete
//**********************************************************************

// import LEAP Motion library

LeapMotion leap;

// CHOOSE GAME DISPLAY MODE (select/deselect with comments)
int gameMode = 0; // window, 1 screen
// int gameMode = 1; // fullscreen, 1 screen
// int gameMode = 2; // 1 screen, window, testing
// int gameMode = 3; // 2 screen, span

// DISPLAY DEBUGGING VISUAL GUIDES (select/deselect with comments)
boolean planMode = true; // DO display guides
// boolean planMode = false; // do NOT display guides

// IMAGES (must be loaded in SETUP)

PImage missionSuccess;
PImage missionFail;
PImage bgStars;

//COLORS
int gameOrange = 0xffFF931E;
int gamePink = 0xffFF7BAC;
int gameRed = 0xffFF1D25;
int gameGreen = 0xff43C93E;
int gameWhite = color(255);
int gameInactiveGray = (100);

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
			// size(1008,630,P3D);
			size(1390,850,P3D);
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
	leap = new LeapMotion(this).allowGestures("circle");

	// IMAGES
	
	missionSuccess = loadImage("../../data/missionSuccess.png");
	missionFail = loadImage("../../data/missionFail.png");
	bgStars = loadImage("../../data/background.png");

	loadIntroImages();
	loadMenuImages();
	loadDefenseImages();
	loadShooterImages();
	loadAttackImages();
	loadFinaleImages();
	loadLeapImages();

}

public void draw() {
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
	}

	if(planMode){
		textSize(24);
		textAlign(LEFT, BOTTOM);
		fill(255,0,0);
		text("PLANNING MODE "+str(round(frameRate))+" fps", 10, height);
	}
}

public void miniGameWin(){
	if (defenseWin && shooterWin && attackWin) {
		gameState = 50;
		// scene = 0;
	} else {
		gameState = 11;
		// scene = 0;
	}
}

public void miniGameLoss(){
	gameState = 11;
	// scene = 0;
}

public void resetGame(){
	gameState = 0;
	scene = 0;
	defenseWin = false;
	shooterWin = false;
	attackWin = false;
}


public void keyPressed() {
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

public float mapLeapX(float thePosX){
	return map(thePosX,150,725,0,width);
}

public float mapLeapY(float thePosY){
	return map(thePosY,200,450,0,height);
}
// gameState range 40-49

PImage AttackPost00;

boolean circs1 = false;
boolean circs2 = false;
boolean circs3 = false;
boolean circs4 = false;

float trainingCircleRadius = width*2;

public void attackIntro(){ // gameState 40
	tint(255);
	textAlign(CENTER,CENTER);
	textSize(18);
	text("Learn how to play. Press SPACE.", width/2, height/2);

}

public void attackTraining(){ // gameState 41
	// imageMode(CORNER);
	// image(bgStars,0,0,width,height);

	leapManager();

	noStroke();

	ellipseMode(CENTER);
	if (circs1) {
		fill(gameGreen);
		ellipse(width/2+trainingCircleRadius*cos(radians(20)),height/2+trainingCircleRadius*sin(radians(20)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(200)),height/2+trainingCircleRadius*sin(radians(200)),40,40);
	} else if (!circs1) {
		fill(gameOrange);
		ellipse(width/2+trainingCircleRadius*cos(radians(20)),height/2+trainingCircleRadius*sin(radians(20)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(200)),height/2+trainingCircleRadius*sin(radians(200)),40,40);
	}

	if (circs2) {
		fill(gameGreen);
		ellipse(width/2+trainingCircleRadius*cos(radians(40)),height/2+trainingCircleRadius*sin(radians(40)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(220)),height/2+trainingCircleRadius*sin(radians(220)),40,40);
	} else if (!circs2) {
		fill(gameOrange);
		ellipse(width/2+trainingCircleRadius*cos(radians(40)),height/2+trainingCircleRadius*sin(radians(40)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(220)),height/2+trainingCircleRadius*sin(radians(220)),40,40);
	}

	if (circs3) {
		fill(gameGreen);
		ellipse(width/2+trainingCircleRadius*cos(radians(-20)),height/2+trainingCircleRadius*sin(radians(-20)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(-200)),height/2+trainingCircleRadius*sin(radians(-200)),40,40);
	} else if (!circs3) {
		fill(gameOrange);
		ellipse(width/2+trainingCircleRadius*cos(radians(-20)),height/2+trainingCircleRadius*sin(radians(-20)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(-200)),height/2+trainingCircleRadius*sin(radians(-200)),40,40);
	}

	if (circs4) {
		fill(gameGreen);
		ellipse(width/2+trainingCircleRadius*cos(radians(-40)),height/2+trainingCircleRadius*sin(radians(-40)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(-220)),height/2+trainingCircleRadius*sin(radians(-220)),40,40);
	} else if (!circs4) {
		fill(gameOrange);
		ellipse(width/2+trainingCircleRadius*cos(radians(-40)),height/2+trainingCircleRadius*sin(radians(-40)),40,40);
		ellipse(width/2+trainingCircleRadius*cos(radians(-220)),height/2+trainingCircleRadius*sin(radians(-220)),40,40);
	}

	stroke(255);
	line(width/2+trainingCircleRadius*cos(radians(handRoll)),height/2+trainingCircleRadius*sin(radians(handRoll)),
		width/2-trainingCircleRadius*cos(radians(handRoll)),height/2-trainingCircleRadius*sin(radians(handRoll))); // show hand roll

	if (handRoll > 17 && handRoll < 23){
		circs1 = true;
	} else if (handRoll > 37 && handRoll < 43){
		circs2 = true;
	} else if (handRoll < -17 && handRoll > -23){
		circs3 = true;
	} else if (handRoll < -37 && handRoll > -43){
		circs4 = true;
	}

	if (!circs1 || !circs2 || !circs3 || !circs4){ // if at least one box is not yet triggered
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("Roll hand\nCW and CCW\nto Highlight Circles", width/2, height/4);
	} else {
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("You got it!\nPress button to move on", width/2, height/4);
		if (scene == 0){
			scene++;
		}
	}

	if (scene == 2){
		gameState++;
		scene = 0;
	}
}

public void attackGame(){ // gameState 42

	lights();
	stroke(255);
	noFill();
	curve(0, -3000,    0, 0, height/2,    0, width, height/2,    0, width, -3000, 0);
	curve(0, -3000, -100, 0, height/2, -100, width, height/2, -100, width, -3000, -100);
	curve(0, -3000, -200, 0, height/2, -200, width, height/2, -200, width, -3000, -200);
	curve(0, -3000, -300, 0, height/2, -300, width, height/2, -300, width, -3000, -300);
	curve(0, -3000, -400, 0, height/2, -400, width, height/2, -400, width, -3000, -400);
	curve(0, -3000, -500, 0, height/2, -500, width, height/2, -500, width, -3000, -500);
	curve(0, -3000, -600, 0, height/2, -600, width, height/2, -600, width, -3000, -600);
	curve(0, -3000, -700, 0, height/2, -700, width, height/2, -700, width, -3000, -700);
	
	// curve(width/4, height/2, -200, width/2, height, -200, width*3/4, height/2, -200, width/2,0,-200);
	// curve(width/4, height/2, -300, width/2, height, -300, width*3/4, height/2, -300, width/2,0,-300);
	// curve(width/4, height/2, -400, width/2, height, -400, width*3/4, height/2, -400, width/2,0,-400);
	// curve(width/4, height/2, -500, width/2, height, -500, width*3/4, height/2, -500, width/2,0,-500);
	// curve(width/4, height/2, -600, width/2, height, -600, width*3/4, height/2, -600, width/2,0,-600);
	stroke(250, 0, 0);
	curve(0, -3000, -1000, 0, height/2, -1000, width, height/2, -1000, width, -3000, -1000);
	// curve(width/4, height/2, -700, width/2, height, -700, width*3/4, height/2, -700, width/2,0,0);
	
	pushMatrix();
	translate(width/2+400*cos(radians(handRoll+90)), height*4/5+400*sin(radians(handRoll+90)), -400);
	rotate(radians(handRoll));
	noStroke();
	fill(100);
	box(width/15,width/30,width/10);
	popMatrix();

	leapManager();


}

public void attackStory(){ // // gameState 43
	textAlign(CENTER,CENTER);
	text("Attack Game Win", width/2, height/2);
	attackWin = true;
	miniGameWin();
}

public void userInputsAttack(){
	
	if (key == ' ') {
		if(gameState == 40){
			gameState++;
		} else if (gameState == 41){
			scene++;
		} else if (gameState == 42) {
			gameState++;
		}
	}
	
}

public void leapInputsAttack(){ //better to call userLeapShooter?

	
}

public void loadAttackImages(){
	AttackPost00 = loadImage("../../data/AttackPost00.png");
}
// gameState range 20-29

PImage blast;
PImage DefensePre00;
PImage DefensePre01;
PImage DefensePost00;
PImage defenseScreen01;
PImage defenseBackground;
PImage asteroid01;
PImage asteroid02;
PImage asteroid03;

ArrayList<Asteroid> asteroids;
ArrayList<Blast> blasts;
ArrayList<ProgressMessage> progresses;
BlastZone blastZone;
boolean startupDefense; // turns off after first/initialization loop

public void defenseIntro(){ //gameState 20
	
	startupDefense = true;

	if (scene == 0) {
		tint(255);
		imageMode(CORNER);
		image(DefensePre00,0,0,width,height);
	} else if (scene == 1) {
		tint(255);
		imageMode(CORNER);
		image(DefensePre01,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
	}
}

public void defenseTraining(){ // gameState 21
	// make a circle with your right index finger
	imageMode(CORNER);
	image(bgStars,0,0,width,height);

	textSize(18);
	fill(255);
	textAlign(CENTER,CENTER);
	if (scene == 0){
		text("Destroy the asteroid\n by making a circle with your\nright index finger", width/2, height*2/3);
	} else if (scene == 1){
		text("That's it! Do it again when the asteroid\nis in the defense zone", width/2, height*2/3);
		for (Asteroid as : asteroids){
			if (as.posX >width*.9f){
				as.posX = width/4;
			}
		}
	} else if (scene == 2){
		text("You're ready.\nPress button to play", width/2, height/2);
	} else if (scene == 3){
		gameState++;
		scene = 0;
	}

	if (startupDefense && scene == 0){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		asteroids.add(new Asteroid(width/2,height/2));
		startupDefense = false; //don't run these initializations again
		blastZone = new BlastZone(width*2,0,1,2); // created off-screen
		// println("startup scene 0");
	} else if (startupDefense && scene == 1){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		asteroids.add(new Asteroid(width/3,height/2,1.5f,0));
		blastZone = new BlastZone(width*2.5f,height/2,width*1.7f,width*1.9f);
		startupDefense = false; //don't run these initializations again
		// println("startup scene 1");
	}

	if (scene == 0 && blasts.size() > 0){
		scene++;
		startupDefense = true;
	} else if (scene == 1 && asteroids.size() == 0){
		scene++;
		// for (Asteroid as : asteroids){
		// 	if ( {
		// 		scene++;
		// 		startupDefense = true;
		// 	} else if (as.posX > width*0.7){
		// 		as.posX = width/4;
		// 	}
	} else if (scene == 2){
	} else if (scene == 3) {
		startupDefense = true;
		scene = 0;
		gameState++;
	}

	itemHandling();
	leapManager();
}

public void defenseGame(){ //gameState 22

	imageMode(CORNER);
	image(defenseBackground,0,0,width,height);

	if (startupDefense){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		// for (int k = 0; k < 5; k++){
		// 	asteroids.add(new Asteroid());
		// }
		asteroids.add(new Asteroid(width*1/6,height*.3f,.5f,1.1f));
		asteroids.add(new Asteroid(width*2/6,height*.1f,.55f,.8f));
		asteroids.add(new Asteroid(width*3/6,height*.2f,.4f,.6f));
		asteroids.add(new Asteroid(width*4/6,height*.4f,-.45f,1.2f));
		asteroids.add(new Asteroid(width*5/6,height*.2f,-.39f,.7f));
		blastZone = new BlastZone(width*.5f,height*1.1f,1,width*.45f);
		// println("asteroids.size(): "+asteroids.size());
		startupDefense = false; //don't run these initializations again
		// println("defense game startup here");
	}


	// println("asteroids.size(): "+asteroids.size());
	// println("millis(): "+millis());
	if (asteroids.size() == 0){
		gameState++;
	}
	itemHandling();
	leapManager();
}

public void defenseStory(){ //gameState 23
	image(DefensePost00,0,0,height,width);
	defenseWin = true;
	miniGameWin();

}

public void userInputsDefense(){
	
	if (key == ' ') {
		if(gameState == 20){
			scene++;
		} else if (gameState == 21){
			scene++;
		} else if (gameState == 22) {
			//no button needed
		}	
	}
	
}

public void leapOnCircleGesture(CircleGesture g, int leapState){
	if (gameState == 21 || gameState == 22){
		if (leapState == 3){ // if in gameplay and if in the state marking end of gesture
			Finger finger = g.getFinger();
			if (finger.getId()%10 == 1){
				PVector positionCenter = g.getCenter();
				float progress = g.getProgress();
				if (progress > 0.99f){
					blasts.add(new Blast());
					progresses.add(new ProgressMessage("GOOD!"));
				} else {
					progresses.add(new ProgressMessage(round(progress*100),mapLeapX(positionCenter.x),mapLeapY(positionCenter.y)));
				}
			}
		
		}
	}
}

class Asteroid{
	int type;
	float posX;
	float posY;
	float velX;
	float velY;
	boolean destroyed = false;
	boolean destroyable = false;

	// int rotation = random(0, TWO_PI);
	Asteroid(){
		type = (int) floor(random(0,3));
		posX = random(width*0.2f,width*0.8f);
		posY = random(height*0.1f,height*0.7f);
		velX = 0;
		velY = 0;
	}

	Asteroid(float thePosX,float thePosY){
		type = (int) floor(random(0,3));
		posX = thePosX;
		posY = thePosY;
		velX = 0;
		velY = 0;
	}

	Asteroid(float thePosX,float thePosY, float theVelX, float theVelY){
		type = (int) floor(random(0,3));
		posX = thePosX;
		posY = thePosY;
		velX = theVelX;
		velY = theVelY;
	}

	public void draw(){
		imageMode(CENTER);
		tint(255,255);
		noFill();
		if (type == 0){
			image(asteroid01, posX, posY, width*0.06f, width*0.06f);
		} else if (type == 1) {
			image(asteroid02, posX, posY, width*0.06f, width*0.06f);
		} else if (type == 2) {
			image(asteroid03, posX, posY, width*0.06f, width*0.06f);
		}

		posX+= velX;
		posY+= velY;

	}

}

class Blast{
	float posX;
	float posY;
	int fader = 255;
	int frameLife = 12;
	int framesLived = 0;
	boolean expired = false;
	float distance;

	Blast(){

	}

	public void draw(){
		for (Asteroid as : asteroids){
			if (as.destroyable == true){
				// println("asteroid destroyable at: "+millis());
				as.destroyed = true;
				tint(fader);
				imageMode(CENTER);
				image(blast, as.posX, as.posY, width*0.10f, width*0.10f);
				tint(255);
				fader -=20;
			}
		framesLived++;
			if (framesLived >= frameLife){
				expired = true;
			}
		}
	}
}

class BlastZone{
	// String zoneType;
	float centerX;
	float centerY;
	float radiusInner;
	float radiusOuter;
	float distance;

	BlastZone(float theCenterX, float theCenterY, float theRadiusInner, float theRadiusOuter){
		centerX = theCenterX;
		centerY = theCenterY;
		radiusInner = theRadiusInner;
		radiusOuter = theRadiusOuter;
	}

	public void draw(){
		ellipseMode(CENTER);
		fill(gameRed,50);
		ellipse(centerX, centerY, radiusOuter*2, radiusOuter*2);
		fill(0);
		ellipse(centerX, centerY, radiusInner*2, radiusInner*2);
		for (Asteroid as : asteroids){
			// distance = dist(as.posX,centerX,as.posY,centerY);
			distance = sqrt(sq(as.posX-centerX)+sq(as.posY-centerY));
			// println("distance: "+distance);
			// println("radiusInner: "+radiusInner);
			// println("radiusOuter: "+radiusOuter);
			// println("distance > radiusInner: "+ (distance > radiusInner));
			// println("distance < radiusOuter: "+ (distance < radiusOuter));
			// println("millis(): "+millis());
			if (distance > radiusInner && distance < radiusOuter){
				as.destroyable = true;
				// println("as.destroyable: "+as.destroyable);
			} else {
				as.destroyable = false;
				// println("as.destroyable: "+as.destroyable);
			}
		}
	}
}

class ProgressMessage{
	float percentage;
	String message;
	String messageType;
	float posX;
	float posY;
	int fader = 255;
	int frameLife = 40;
	int framesLived = 0;
	boolean expired = false;

	ProgressMessage(String theMessage){
		message = theMessage;
		posX = width/2;
		posY = height/4;
		messageType = "string";
	}

	ProgressMessage(float theProgress, float theX, float theY){
		percentage = theProgress;
		// posX = theX;
		// posY = theY;
		posX = width/2;
		posY = height/4;
		messageType = "number";
	}

	public void draw(){
		fill(fader);
		textAlign(CENTER,CENTER);
		textSize(24);
		if (messageType == "string"){
			text(message,posX,posY);
		} else if (messageType == "number") {
			text(percentage + "%",posX,posY);
		}
		
		fader -=5;
		framesLived++;
		if (framesLived >= frameLife){
			expired = true;
		}
	}
}

public void itemHandling(){

	noStroke();
	blastZone.draw();

	// ASTEROID HANDLING
	for (int j = asteroids.size() - 1; j >= 0; j--) { // go backwards through ArrayList of asteroids
	 	Asteroid as = asteroids.get(j); // get the missile at current index
	 	if (as.destroyed) { // if it is expired
	 		asteroids.remove(j); // then remove it from the ArrayList
	 	} else if (as.posY>height){
	 		miniGameLoss();
	 	} else {
	 		as.draw();
	 	}
	}

	// BLAST HANDLING
	for (int i = blasts.size() - 1; i >= 0; i--) { // go backwards through ArrayList of blasts
	 	Blast bl = blasts.get(i); // get the missile at current index
	 	if (bl.expired) { // if it is expired
	 		blasts.remove(i); // then remove it from the ArrayList
	 	} else {
	 		bl.draw();
	 	}
	}

	// Progress Message HANDLING
	for (int i = progresses.size() - 1; i >= 0; i--) { 
	 	ProgressMessage pr = progresses.get(i);
	 	if (pr.expired) {
	 		progresses.remove(i);
	 	} else {
	 		pr.draw();
	 	}
	}

}

public void loadDefenseImages(){
	asteroid01 = loadImage("../../data/asteroid01.png");
	asteroid02 = loadImage("../../data/asteroid02.png");
	asteroid03 = loadImage("../../data/asteroid03.png");
	DefensePre00 = loadImage("../../data/DefensePre00.png");
	DefensePre01 = loadImage("../../data/DefensePre01.png");
	DefensePost00 = loadImage("../../data/DefensePost00.png");
	defenseScreen01 = loadImage("../../data/Planet defense instructions 1-01.png");
	defenseBackground = loadImage("../../data/Planet Defense Blank Screen-01.png");
	blast = loadImage("../../data/playerBlast.png");
}
// gameState range 50-59

PImage FinalePre00;
PImage FinalePre01;
PImage FinalePre02;
PImage FinalePre03;
PImage FinalePost00;
PImage FinalePost01;
PImage FinalePost02;

PImage finaleScreenAfter01;

public void finaleIntro(){ //gameState 50
	// tint(255);
	// imageMode(CORNER);
	// image(finaleScreenAfter01, 0, 0, width, height);

	tint(255);

	imageMode(CORNER);

	if (scene == 0) {
		image(FinalePre00,0,0,width,height);
	} else if (scene == 1) {
		image(FinalePre01,0,0,width,height);
	} else if (scene == 2) {
		image(FinalePre02,0,0,width,height);
	} else if (scene == 3) {
		image(FinalePre03,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
	}

}

public void finaleTraining(){ //gameState 51
	gameState++;
}

public void finaleGame(){ //gameState 52
	// textAlign(CENTER,CENTER);
	// text("Finale Win", width/2, height/2);
	gameState++;
}

public void finaleStory(){ // gameState 53
	if (scene == 0) {
		// image(FinalePost00,0,0,width,height);
		image(FinalePost01,0,0,width,height);
	} else if (scene == 1) {
		resetGame();
		// image(FinalePost01,0,0,width,height);
	} else if (scene == 2) {
		// image(FinalePost02,0,0,width,height);
	} else {
		// resetGame();
	}

	
}

public void userInputsFinale(){
	if(gameState == 50){
		scene++;
	} else if (gameState == 51){
		gameState++;
	} else if (gameState == 52) {
		gameState++;
	} else if (gameState == 53) {
		scene++;
	}
}

public void loadFinaleImages(){
	FinalePre00 = loadImage("../../data/FinalePre00.png");
	FinalePre01 = loadImage("../../data/FinalePre01.png");
	FinalePre02 = loadImage("../../data/FinalePre02.png");
	FinalePre03 = loadImage("../../data/FinalePre03.png");
	FinalePost00 = loadImage("../../data/FinalePost00.png");
	FinalePost01 = loadImage("../../data/FinalePost01.png");
	FinalePost02 = loadImage("../../data/FinalePost02.png");

	finaleScreenAfter01 = loadImage("../../data/End screen 2-01.png");

}
// gameState range 0-9


PImage Intro00;
PImage Intro01;

public void introMain() {
	
	imageMode(CORNER);

	if (scene == 0) {
		image(Intro00,0,0,width,height);
	} else if (scene == 1) {
		image(Intro01,0,0,width,height);
		leapManager();
	} else {
		gameState = 10;
		scene = 0;
	}

}

public void userInputsIntro(){
	if (key == ' ') {
		scene++;
	}

}

public void loadIntroImages(){
	Intro00 = loadImage("../../data/Intro00.png");
	Intro01 = loadImage("../../data/Intro01.png");
}
float commandPositionX;
float commandPositionY;
float commandPositionZ;
float commandPositionIndexX;
float commandPositionIndexY;

int handCount;

float handRoll;

PImage menuCursor;
PImage playerCursor;

public void loadLeapImages(){
	menuCursor = loadImage("../../data/menuCursor.png");
	playerCursor = loadImage("../../data/playerCursor.png");
}

public void leapManager(){
	commandPositionX = width/2;
	commandPositionY = height/2;
	commandPositionZ = 50;
	commandPositionIndexX = width/2;
	commandPositionIndexY = height/2;
	PVector handPosition;
	PVector fingerPosition;
	boolean handIsRight;
	handCount = leap.getHands().size();

	for (Hand hand : leap.getHands()) {
		handPosition = hand.getPosition();
		handIsRight = hand.isRight();
		if (handIsRight){
			commandPositionX = mapLeapX(handPosition.x);
			commandPositionY = mapLeapY(handPosition.y);
			commandPositionZ = handPosition.z;
			handRoll = hand.getRoll();

			if (gameState != 21 && gameState != 22){
				imageMode(CENTER);
				tint(255);
				image(menuCursor,commandPositionX,commandPositionY,40,40);
			}

			if (gameState == 21 || gameState == 22){
				Finger indexFinger = hand.getIndexFinger();
				fingerPosition = indexFinger.getPosition();
				commandPositionIndexX = mapLeapX(fingerPosition.x);
				commandPositionIndexY = mapLeapY(fingerPosition.y);
				stroke(gameOrange);
				strokeWeight(3);
				noFill();
				ellipse(commandPositionIndexX,commandPositionIndexY,15,15);
			}
			if(planMode){
				textSize(24);
				textAlign(RIGHT, BOTTOM);
				fill(255,0,0);
				text("handPosition: (" + 
					str(round(handPosition.x)) + "," + 
					str(round(handPosition.y)) + "," +
					str(round(handPosition.z)) + ")", width-10, height);
			}
		} else if (!handIsRight) {
			fill(0xffFF0000);
			textSize(24);
			textAlign(CENTER,BOTTOM);
			text("Left Hand Not Yet Supported", width/2, height/8);
		}

	}

	if (commandPositionX < 0){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nRight", width/4, height/2);
	}

	if (commandPositionX > width){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nLeft", width*3/4, height/2);
	}

	if (commandPositionY < 0){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nDown", width/2, height/4);
	}

	if (commandPositionY > height){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nUp", width/2, height*3/4);
	}

	if (commandPositionZ > 65){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move Hand\nToward You", width/2, height*3/4);
	}

	if (commandPositionZ < 30){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move Hand\nAway from You", width/2, height*3/4);
	}

	if (handCount == 0){
		fill(0xffFF0000);
		textSize(24);
		textAlign(CENTER,BOTTOM);
		text("Hand Not Found", width/2, height/8);
		
		rectMode(CORNERS);
		stroke(0xffFF0000);
		strokeWeight(4);
		noFill();
		rect(width*.05f,height*.05f,width*.95f,height*.95f);
	}

}
// gameState range 10-19


PImage rocket;
PImage spacecraft;
PImage missionRing;
PImage defenseLabel;
PImage shooterLabel;
PImage attackLabel;
PImage checkmark;
PImage asteroid;



boolean box1 = false;
boolean box2 = false;
boolean box3 = false;
boolean box4 = false;

public void menuTraining(){ // gameState 10

	leapManager();

	noStroke();

	rectMode(CORNERS);
	if (box1) {
		fill(gameGreen);
		rect(width*.05f,height*.05f,width*.15f,height*.15f);
	} else if (!box1) {
		fill(gameOrange);
		rect(width*.05f,height*.05f,width*.15f,height*.15f);
	}

	if (box2) {
		fill(gameGreen);
		rect(width*.85f,height*.05f,width*.95f,height*.15f);
	} else if (!box2) {
		fill(gameOrange);
		rect(width*.85f,height*.05f,width*.95f,height*.15f);
	}

	if (box3) {
		fill(gameGreen);
		rect(width*.05f,height*.85f,width*.15f,height*.95f);
	} else if (!box3) {
		fill(gameOrange);
		rect(width*.05f,height*.85f,width*.15f,height*.95f);
	}

	if (box4) {
		fill(gameGreen);
		rect(width*.85f,height*.85f,width*.95f,height*.95f);
	} else if (!box4) {
		fill(gameOrange);
		rect(width*.85f,height*.85f,width*.95f,height*.95f);
	}

	if (commandPositionX > width*.05f && commandPositionX < width*.15f && commandPositionY > height*0.05f && commandPositionY < height*0.15f){
		box1 = true;
	} else if (commandPositionX > width*.85f && commandPositionX < width*.95f && commandPositionY > height*0.05f && commandPositionY < height*0.15f){
		box2 = true;
	} else if (commandPositionX > width*.05f && commandPositionX < width*.15f && commandPositionY > height*0.85f && commandPositionY < height*0.95f){
		box3 = true;
	} else if (commandPositionX > width*.85f && commandPositionX < width*.95f && commandPositionY > height*0.85f && commandPositionY < height*0.95f){
		box4 = true;
	}


	if (!box1 || !box2 || !box3 || !box4){ // if at least one box is not yet triggered
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("Move Hand\nLeft, Right, Up, and Down\nto Highlight Boxes", width/2, height/2);
	} else {
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("You got it!\nPress button to move on", width/2, height/2);
		if (scene == 0){
			scene++;
		}
	}


	
}

public void menuMain() { // gameState 11
	
	fill(255);
	textSize(48);
	textAlign(CENTER,BOTTOM);
	text("Choose your training mission:", width/2, height/4);

	// MENU ITEMS (3 positions, Left-to-Right, 0-indexed)
	menuItemDraw(0, asteroid, gameRed, defenseWin, defenseLabel);
	menuItemDraw(1, spacecraft, gameOrange, shooterWin, shooterLabel);
	menuItemDraw(2, rocket, gamePink, attackWin, attackLabel);

	leapManager();
	
}

public void menuStory(){ // gameState 11
	gameState = gameStateSelection; // go to selected game
}

public void menuItemDraw(
	int thePosition, 
	PImage theIcon, 
	int theColor, 
	boolean theState, 
	PImage theName){

	// FUNCTION SETTINGS
	imageMode(CENTER);
	ellipseMode(CENTER); // this is the default but making explicit
	float itemPosX = thePosition*width/3 + width/6;
	float itemPosY = height*2/3;
	float ringDiamOutside = width*0.30f;
	// float ringDiamInside =  width*0.19;
	float iconHeight = width*0.35f;
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
			iconHeight*0.5f, 
			iconWidth*0.5f);
	}
	
	// DRAW SELECTION INDICATOR, DRAW LEVEL NAME, DETERMINE GAMESTATE IF SELECTED
	// float commandPosition = leapInputsMenu();

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


public void userInputsMenu(){
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
		}	
	}
}

public void loadMenuImages(){
	missionRing = loadImage("../../data/mission ring.png");
	defenseLabel = loadImage("../../data/planet defense text.png");
	shooterLabel = loadImage("../../data/enemy encounter text.png");
	attackLabel = loadImage("../../data/base attack text.png");
	checkmark = loadImage("../../data/noun_Check_929005_FFFFFF.png");
	asteroid = loadImage("../../data/planet defense icon.png");
	rocket = loadImage("../../data/base attack icon.png");
	spacecraft = loadImage("../../data/enemy encounter icon.png");
		
}
// gameState range 30-39

PImage status10;
PImage status09;
PImage status08;
PImage status07;
PImage status06;
PImage status05;
PImage status04;
PImage status03;
PImage status02;
PImage status01;

PImage fighter;
PImage fighterFire;
PImage enemy;
PImage enemyFire;

PImage shooterScreen01;
PImage shooterScreen02;
PImage shooterScreen03;

PImage ShooterPost00;

boolean startupShooter; // turns off after first/initialization loop
Player player;
ArrayList<MissilePlayer> missilesPlayer;
ArrayList<MissileEnemy> missilesEnemy;
ArrayList<Enemy> enemies;
boolean rect1 = false;
boolean rect2 = false;

public void shooterIntro(){ //gameState 30
	tint(255);

	imageMode(CORNER);

	if (scene == 0) {
		image(shooterScreen01,0,0,width,height);
	} else if (scene == 1) {
		image(shooterScreen02,0,0,width,height);
	} else if (scene == 2) {
		image(shooterScreen03,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
		startupShooter = true;
	}
}

public void shooterTraining(){ // gameState 31
	imageMode(CORNER);
	image(bgStars,0,0,width,height);

	if (startupShooter){ // create on first loop 
		player = new Player();
		missilesPlayer = new ArrayList<MissilePlayer>();
		startupShooter = false; //don't run these initializations again
	}

	leapInputsShooter();
	
	// move left and right
	rectMode(CORNERS);
	noStroke();
	if (rect1) {
		fill(gameGreen);
		rect(width*.2f,height*.85f,width*.4f,height*.95f);
	} else if (!rect1) {
		fill(gameOrange);
		rect(width*.2f,height*.85f,width*.4f,height*.95f);
	}

	if (rect2) {
		fill(gameGreen);
		rect(width*.6f,height*.85f,width*.8f,height*.95f);
	} else if (!box2) {
		fill(gameOrange);
		rect(width*.6f,height*.85f,width*.8f,height*.95f);
	}

	if (player.posX > width*.2f && player.posX < width*.4f){
		rect1 = true;
	} else if (player.posX > width*.6f && player.posX < width*.8f){
		rect2 = true;
	}

	if (!rect1 || !rect2){ // if at least one box is not yet triggered
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("Move Hand\nLeft and Right\nto Move Craft", width/2, height/2);
	} else if (rect1 && rect2 && scene == 0){
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("Press button to fire", width/2, height/2);
	} else if (rect1 && rect2 && scene == 1){
		textSize(18);
		fill(255);
		textAlign(CENTER,CENTER);
		text("You got it!\nPress button to play!", width/2, height/2);
	}

	// PLAYER MISSILE TRAVEL
	for (int i = missilesPlayer.size() - 1; i >= 0; i--) { // go backwards through ArrayList of missiles
	 	MissilePlayer mi = missilesPlayer.get(i); // get the missile at current index
	 	if (mi.posY > 0) { // if it is on the screen
	 		mi.draw(); // then draw it
	 	} else { // if it is not on the screen
	 		missilesPlayer.remove(i); // then remove it from the ArrayList
	 	}
	}

	player.draw();

}

public void shooterGame(){ //gameState 32
	imageMode(CORNER);
	image(bgStars,0,0,width,height);
	
	if (startupShooter){ // create on first loop 
		player = new Player();
		missilesPlayer = new ArrayList<MissilePlayer>();
		missilesEnemy = new ArrayList<MissileEnemy>();
		enemies = new ArrayList<Enemy>();
		for (int k = 0; k < 5; k++){
			enemies.add(new Enemy());
		}
		startupShooter = false; //don't run these initializations again
	}

	leapInputsShooter();
	player.draw();
	
	// ENEMY DESTRUCTION
	for (Enemy en : enemies) {
		for (MissilePlayer mi : missilesPlayer){
			float dist = sqrt(sq(en.posX-mi.posX)+sq(en.posY-mi.posY));
			if (dist < width/40){
				en.alive = false;
				mi.posY = -50; // move missile off screen to be deleted
			}
		}
	}

	// PLAYER DAMAGE
	for (MissileEnemy mi : missilesEnemy){
		float dist = sqrt(sq(player.posX-mi.posX)+sq(player.posY-mi.posY));
		if (dist < width/30){
			player.health--; // hit the player, cause damage
			mi.posY = height+50; // move missile off screen to be deleted
		}
	}

	// PLAYER MISSILE TRAVEL
	for (int i = missilesPlayer.size() - 1; i >= 0; i--) { // go backwards through ArrayList of missiles
	 	MissilePlayer mi = missilesPlayer.get(i); // get the missile at current index
	 	if (mi.posY > 0) { // if it is on the screen
	 		mi.draw(); // then draw it
	 	} else { // if it is not on the screen
	 		missilesPlayer.remove(i); // then remove it from the ArrayList
	 	}
	}

	// ENEMY MISSILE TRAVEL
	for (int k = missilesEnemy.size() - 1; k >= 0; k--) { // go backwards through ArrayList of missiles
	 	MissileEnemy mi = missilesEnemy.get(k); // get the missile at current index
	 	if (mi.posY < height) { // if it is on the screen
	 		mi.draw(); // then draw it
	 	} else { // if it is not on the screen
	 		missilesEnemy.remove(k); // then remove it from the ArrayList
	 	}
	}

 	// ENEMY HANDLING
	for (int j = enemies.size() - 1; j >= 0; j--) { // go backwards through ArrayList of enemies
	 	Enemy en = enemies.get(j); // get the enemy at current index
	 	if (en.alive) { // if it is alive
	 		en.draw(); // then draw it
	 	} else { // otherwise it is dead
	 		enemies.remove(j); // so remove it from the ArrayList
	 	}
	}

	if (enemies.size() == 0){
		gameState++;
	}

}

public void shooterStory(){ //gameState 33
	shooterWin = true;
	miniGameWin();
}

public void userInputsShooter(){ //better to call userKeysShooter?
	if (key == ' ') {
		if(gameState == 32){
			missilesPlayer.add(new MissilePlayer());
			for (Enemy en : enemies){
				missilesEnemy.add(new MissileEnemy(en.posX,en.posY));
			}
		} else if (gameState == 30){
			scene++;
		} else if (gameState == 31 && scene == 0){
			missilesPlayer.add(new MissilePlayer());
			scene++;
		} else if (gameState == 31 && scene == 1){
			gameState++;
			scene = 0;
			rect1 = false;
			rect2 = false;
			startupShooter = true;
		} else {
			gameState++;
		}
	} else if (keyCode == LEFT) {
		player.stepLeft();
	} else if (keyCode == RIGHT) {
		player.stepRight();
	} else if (keyCode == UP) {
		player.healthUp();
	} else if (keyCode == DOWN) {
		player.healthDown();
	}
}

public void leapInputsShooter(){
	leapManager();
	if (commandPositionX < player.posX-width/40){
		player.floatLeft();
	} else if (commandPositionX > player.posX+width/40) {
		player.floatRight();
	}
	
}

class Player{
	int health = 10;
	float posX = width/2;
	float posY = height*0.9f;
	float leapFloatSpeed = width/80;
	float keyStepSize = width/30;

	// float commandPositionAVG = width/2;
	// float commandPosition00 = width/2;
	// float commandPosition01 = width/2;
	// float commandPosition02 = width/2;

	Player(){

	}

	public void draw(){
		imageMode(CENTER);
		image(fighter, posX, posY, width/20, width/20);
		drawHealthBar();
		if (health <= 0) { // go back to menu if dead
			miniGameLoss();
		}
	}

	public void drawHealthBar(){
		imageMode(CENTER);
		if (health == 10) {
			image(status10,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 9) {
			image(status09,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 8) {
			image(status08,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 7) {
			image(status07,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 6) {
			image(status06,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 5) {
			image(status05,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 4) {
			image(status04,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 3) {
			image(status03,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 2) {
			image(status02,width*.90f,height/2,width*0.2f,height*0.9f);
		} else if (health == 1) {
			image(status01,width*.90f,height/2,width*0.2f,height*0.9f);
		}

	}

	public void floatLeft(){
		posX -=leapFloatSpeed;
		if (posX < 0) {
			posX = 0;
		} 
	}

	public void floatRight(){
		posX += leapFloatSpeed;
		if (posX > width) {
			posX = width;
		}
	}

	public void stepLeft(){
		posX -= keyStepSize;
		if (posX < 0) {
			posX = 0;
		}
	}

	public void stepRight(){
		posX += keyStepSize;
		if (posX > width-keyStepSize) {
			posX = width-keyStepSize;
		}
	}

	public void healthUp(){
		health++;
	}

	public void healthDown(){
		health--;
	}
}

class MissilePlayer{
	boolean active = true;
	float posX;
	float posY;
	float velY = -height/50;

	MissilePlayer(){
		posX = player.posX;
		posY = player.posY;
	}

	public void draw(){
		imageMode(CENTER);
		image(fighterFire, posX, posY, width/50, width/50);
		posY += velY;
	}

}

class MissileEnemy{
	boolean active = true;
	float posX;
	float posY;
	float velY = height/80;

	MissileEnemy(float posX_, float posY_){
		posX = posX_;
		posY = posY_;
	}

	public void draw(){
		imageMode(CENTER);
		image(enemyFire, posX, posY, width/50, width/50);
		posY += velY;
	}
}

class Enemy{
	float posX = random(width*0.1f,width*0.8f);
	float posY = random(height*0.1f,height*0.5f);
	boolean alive = true;

	Enemy(){
		
	}

	public void draw(){
		imageMode(CENTER);
		image(enemy, posX, posY, width/20, width/20);
	}

}

public void loadShooterImages(){
	status10 = loadImage("../../data/lifeStatus/status10.png");
	status09 = loadImage("../../data/lifeStatus/status09.png");
	status08 = loadImage("../../data/lifeStatus/status08.png");
	status07 = loadImage("../../data/lifeStatus/status07.png");
	status06 = loadImage("../../data/lifeStatus/status06.png");
	status05 = loadImage("../../data/lifeStatus/status05.png");
	status04 = loadImage("../../data/lifeStatus/status04.png");
	status03 = loadImage("../../data/lifeStatus/status03.png");
	status02 = loadImage("../../data/lifeStatus/status02.png");
	status01 = loadImage("../../data/lifeStatus/status01.png");

	enemy = loadImage("../../data/enemy.png");
	enemyFire = loadImage("../../data/enemyFire.png");
	fighter = loadImage("../../data/fighter.png");
	fighterFire = loadImage("../../data/fighterFire.png");

	shooterScreen01 = loadImage("../../data/Galaga Introduction Narrative-01.png");
	shooterScreen02 = loadImage("../../data/Galaga Instructions 1-01.png");
	shooterScreen03 = loadImage("../../data/Galaga instructions 2-01.png");
	ShooterPost00 = loadImage("../../data/ShooterPost00.png");
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
