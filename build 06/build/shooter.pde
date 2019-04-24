// gameState range 30-39

PImage statusShip10;
PImage statusShip09;
PImage statusShip08;
PImage statusShip07;
PImage statusShip06;
PImage statusShip05;
PImage statusShip04;
PImage statusShip03;
PImage statusShip02;
PImage statusShip01;

PImage fighter;
PImage fighterFire;
PImage enemy;
PImage enemyFire;

PImage shooterPre00;
PImage shooterPre01;
PImage shooterPre02;
PImage shooterPre03;
PImage shooterPre04;
PImage shooterPre05;
PImage shooterPost00;

boolean startupShooter; // turns off after first/initialization loop
Player player;
ArrayList<MissilePlayer> missilesPlayer;
ArrayList<MissileEnemy> missilesEnemy;
ArrayList<Enemy> enemies;
boolean rect1 = false;
boolean rect2 = false;

int animationScreen = 0;

void shooterIntro(){ //gameState 30
	tint(255);

	imageMode(CORNER);

	if (scene == 0) {
		placeMenuImage(shooterPre00);
		animationScreen = 0;
	} else if (scene == 1) {
		if (frameCount % 50 == 0){
			animationScreen++;
		}
		if (animationScreen == 0){
			placeMenuImage(shooterPre01);
		} else if (animationScreen == 1) {
			placeMenuImage(shooterPre02);
		} else if (animationScreen == 2) {
			placeMenuImage(shooterPre03);
		} else if (animationScreen == 3) {
			placeMenuImage(shooterPre04);
		} else {
			animationScreen = 0;
		}
	} else if (scene == 2) {
		placeMenuImage(shooterPre05);
	} else {
		gameState++;
		scene = 0;
		startupShooter = true;
	}
}

void shooterTraining(){ // gameState 31

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
		rect(width*.1,height*.85,width*.3,height*.95);
	} else if (!rect1) {
		fill(gameOrange);
		rect(width*.1,height*.85,width*.3,height*.95);
	}

	if (rect2) {
		fill(gameGreen);
		rect(width*.7,height*.85,width*.9,height*.95);
	} else if (!rect2) {
		fill(gameOrange);
		rect(width*.7,height*.85,width*.9,height*.95);
	}

	if (player.posX > width*.1 && player.posX < width*.3){
		rect1 = true;
	} else if (player.posX > width*.7 && player.posX < width*.9){
		rect2 = true;
	}

	if (!rect1 || !rect2){ // if at least one box is not yet triggered
		textSize(24);
		fill(255);
		textAlign(CENTER,CENTER);
		text("Move Hand\nLeft and Right\nto Move Craft", width/2, height/2);
	} else if (rect1 && rect2 && scene == 0){
		textSize(24);
		fill(255);
		textAlign(CENTER,CENTER);
		text("Press button to fire", width/2, height/2);
	} else if (rect1 && rect2 && scene == 1){
		textSize(24);
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

void shooterGame(){ //gameState 32
	
	if (startupShooter){ // create on first loop 
		player = new Player();
		missilesPlayer = new ArrayList<MissilePlayer>();
		missilesEnemy = new ArrayList<MissileEnemy>();
		enemies = new ArrayList<Enemy>();
		for (int k = 0; k < 15; k++){
			enemies.add(new Enemy());
		}
		startupShooter = false; //don't run these initializations again
	}

	
	player.draw();
	
	// ENEMY DESTRUCTION
	for (Enemy en : enemies) {
		for (MissilePlayer mi : missilesPlayer){
			float dist = sqrt(sq(en.posX-mi.posX)+sq(en.posY-mi.posY));
			if (dist < craftSize*.7){
				en.alive = false;
				mi.posY = -50; // move missile off screen to be deleted
			}
		}
	}

	// PLAYER DAMAGE
	for (MissileEnemy mi : missilesEnemy){
		float dist = sqrt(sq(player.posX-mi.posX)+sq(player.posY-mi.posY));
		if (dist < craftSize*0.7){
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
		scene = 0;
		gameState++;
		shooterWin = true;
	}
	 if (player.health == 0){
	 	gameState = 61;
	 	scene = 0;
	 }

	leapInputsShooter();
}

void shooterStory(){ //gameState 33

	if (scene == 0){
		placeMenuImage(shooterPost00);
	} else if (scene == 1) {
		scene = 0;
		gameState = 60;
	}
}

void userInputsShooter(){ //better to call userKeysShooter?
	if (key == ' ') {
		if(gameState == 32){
			missilesPlayer.add(new MissilePlayer());
			// for (Enemy en : enemies){
			// 	missilesEnemy.add(new MissileEnemy(en.posX,en.posY));
			// }
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
		} else if (gameState == 33) {
			scene++;
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

void leapInputsShooter(){
	leapManager();
	if (commandPositionX < player.posX-width/40){
		player.floatLeft();
	} else if (commandPositionX > player.posX+width/40) {
		player.floatRight();
	}
	
}

float missileSpeed = height/20;
float missileSize = width/2;
float craftSize = width/2;

class Player{
	int health = 10;
	float posX = width/2;
	float posY = height*0.9;
	float leapFloatSpeed = width/80;
	float keyStepSize = width/30;

	Player(){

	}

	void draw(){
		imageMode(CENTER);
		image(fighter, posX, posY, craftSize, craftSize);
		drawHealthBar();
		if (health <= 0) { // go back to menu if dead
			miniGameLoss();
		}
	}

	void drawHealthBar(){
		if (health == 9) {
			placeMenuImage(statusShip10);
		} else if (health == 8) {
			placeMenuImage(statusShip09);
		} else if (health == 7) {
			placeMenuImage(statusShip08);
		} else if (health == 6) {
			placeMenuImage(statusShip07);
		} else if (health == 5) {
			placeMenuImage(statusShip06);
		} else if (health == 4) {
			placeMenuImage(statusShip05);
		} else if (health == 3) {
			placeMenuImage(statusShip04);
		} else if (health == 2) {
			placeMenuImage(statusShip03);
		} else if (health == 1) {
			placeMenuImage(statusShip02);
		} 
		// else if (health == 1) {
		// 	placeMenuImage(statusShip01);
		// }
	}

	void floatLeft(){
		posX -=leapFloatSpeed;
		if (posX < 0) {
			posX = 0;
		} 
	}

	void floatRight(){
		posX += leapFloatSpeed;
		if (posX > width) {
			posX = width;
		}
	}

	void stepLeft(){
		posX -= keyStepSize;
		if (posX < 0) {
			posX = 0;
		}
	}

	void stepRight(){
		posX += keyStepSize;
		if (posX > width-keyStepSize) {
			posX = width-keyStepSize;
		}
	}

	void healthUp(){
		health++;
	}

	void healthDown(){
		health--;
	}
}

class MissilePlayer{
	boolean active = true;
	float posX;
	float posY;
	float velY = -missileSpeed;

	MissilePlayer(){
		posX = player.posX;
		posY = player.posY;
	}

	void draw(){
		imageMode(CENTER);
		image(fighterFire, posX, posY, missileSize, missileSize);
		posY += velY;
	}

}

class MissileEnemy{
	boolean active = true;
	float posX;
	float posY;
	float velY = missileSpeed;

	MissileEnemy(float posX_, float posY_){
		posX = posX_;
		posY = posY_;
	}

	void draw(){
		imageMode(CENTER);
		image(enemyFire, posX, posY, missileSize, missileSize);
		posY += velY;
	}
}

class Enemy{
	float posX = random(width*0.1,width*0.8);
	float posY = random(height*0.1,height*0.5);
	boolean alive = true;
	int shotInterval = int(random(5,30));
	int shotOffset = int(random(0,120));

	Enemy(){
		
	}

	void draw(){
		if ((frameCount + shotOffset) % (shotInterval*enemies.size() + 20) == 0){ // increases fire rate as enemies are destroyed
			missilesEnemy.add(new MissileEnemy(posX,posY));	
		}
		
		imageMode(CENTER);
		image(enemy, posX, posY, craftSize, craftSize);
	}

}

void loadShooterImages(){
	statusShip10 = requestImage("../../data/lifeStatus/statusShip10.png");
	statusShip09 = requestImage("../../data/lifeStatus/statusShip09.png");
	statusShip08 = requestImage("../../data/lifeStatus/statusShip08.png");
	statusShip07 = requestImage("../../data/lifeStatus/statusShip07.png");
	statusShip06 = requestImage("../../data/lifeStatus/statusShip06.png");
	statusShip05 = requestImage("../../data/lifeStatus/statusShip05.png");
	statusShip04 = requestImage("../../data/lifeStatus/statusShip04.png");
	statusShip03 = requestImage("../../data/lifeStatus/statusShip03.png");
	statusShip02 = requestImage("../../data/lifeStatus/statusShip02.png");
	// status01 = requestImage("../../data/lifeStatus/statusShip01.png");

	enemy = requestImage("../../data/enemy.png");
	enemyFire = requestImage("../../data/enemyFire.png");
	fighter = requestImage("../../data/fighter.png");
	fighterFire = requestImage("../../data/fighterFire.png");

	shooterPre00 = requestImage("../../data/shooterPre00.png");
	shooterPre01 = requestImage("../../data/shooterPre01.png");
	shooterPre02 = requestImage("../../data/shooterPre02.png");
	shooterPre03 = requestImage("../../data/shooterPre03.png");
	shooterPre04 = requestImage("../../data/shooterPre04.png");
	shooterPre05 = requestImage("../../data/shooterPre05.png");
	shooterPost00 = requestImage("../../data/shooterPost00.png");

}