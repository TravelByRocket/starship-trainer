// gameState range 30-39

boolean startupShooter; // turns off after first/initialization loop
Player player;
ArrayList<MissilePlayer> missilesPlayer;
ArrayList<MissileEnemy> missilesEnemy;
ArrayList<Enemy> enemies;


void shooter_i(){ //gameState 30

	// textAlign(CENTER,CENTER);
	// text("Learn how to play. Press SPACE.", width/2, height/2);

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
	}
	
	startupShooter = true;

}

void shooter_ii(){ //gameState 31
	// textAlign(CENTER,CENTER);
	// text("Shooter Game Win", width/2, height/2);

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
			if (dist < width/30){
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

void shooter_iii(){ //gameState 32
	// could add a message about winning here
	shooterWin = true;
	miniGameWin();
}

void userInputsShooter(){ //better to call userKeysShooter?
	if (key == ' ') {
		if(gameState == 31){
			missilesPlayer.add(new MissilePlayer());
			for (Enemy en : enemies){
				missilesEnemy.add(new MissileEnemy(en.posX,en.posY));
			}
		} else if (gameState == 30){
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

void leapInputsShooter(){ //better to call userLeapShooter?
	float commandPositionAVG;
	float commandPosition00 = width/2;
	float commandPosition01 = width/2;
	float commandPosition02 = width/2;
	PVector handPosition;
	boolean handIsRight;

	for (Hand hand : leap.getHands()) {
		handPosition = hand.getStabilizedPosition();
		handIsRight = hand.isRight();
		if (handIsRight){
			commandPosition00 = map(handPosition.x,150,650,0,width);
		} 
	}

	commandPosition02 = commandPosition01;
	commandPosition01 = commandPosition00;
	
	commandPositionAVG = (commandPosition00 + commandPosition01 + commandPosition02)/3;

	if (commandPositionAVG < player.posX-width/30){
		player.floatLeft();
	} else if (commandPositionAVG > player.posX+width/30) {
		player.floatRight();
	}
	
}

class Player{
	// int hitsAllowed = 11;
	int health = 10;
	float posX = width/2;
	float posY = height*0.9;
	float leapFloatSpeed = width/80;
	float keyStepSize = width/30;

	float commandPositionAVG = width/2;
	float commandPosition00 = width/2;
	float commandPosition01 = width/2;
	float commandPosition02 = width/2;

	Player(){

	}

	void draw(){
		imageMode(CENTER);
		image(fighter, posX, posY, width/20, width/20);
		drawHealthBar();
		if (health <= 0) { // go back to menu if dead
			// player = null;
			// missiles = null;
			// enemies = null;
			miniGameLoss();
		}
	}

	void drawHealthBar(){
		imageMode(CENTER);
		if (health == 10) {
			image(status10,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 9) {
			image(status09,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 8) {
			image(status08,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 7) {
			image(status07,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 6) {
			image(status06,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 5) {
			image(status05,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 4) {
			image(status04,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 3) {
			image(status03,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 2) {
			image(status02,width*.90,height/2,width*0.2,height*0.9);
		} else if (health == 1) {
			image(status01,width*.90,height/2,width*0.2,height*0.9);
		}

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
		// commandPositionAVG = posX;
		// commandPosition00 = posX;
		// commandPosition01 = posX;
		// commandPosition02 = posX;
	}

	void stepRight(){
		posX += keyStepSize;
		if (posX > width-keyStepSize) {
			posX = width-keyStepSize;
		}
		// commandPositionAVG = posX;
		// commandPosition00 = posX;
		// commandPosition01 = posX;
		// commandPosition02 = posX;
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
	float velY = -height/50;

	MissilePlayer(){
		posX = player.posX;
		posY = player.posY;
		// println("missile created");
	}

	void draw(){
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

	void draw(){
		imageMode(CENTER);
		image(enemyFire, posX, posY, width/50, width/50);
		// image(enemyFire, posX, posY, width/100, width/100);
		posY += velY;
	}
}

class Enemy{
	float posX = random(width*0.1,width*0.9);
	float posY = random(height*0.1,height*0.5);
	boolean alive = true;

	Enemy(){
		
	}

	void draw(){
		imageMode(CENTER);
		image(enemy, posX, posY, width/20, width/20);
		// image(rocket, posX, posY, width/20, width/20);
	}

}

