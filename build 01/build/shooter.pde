// gameState range 30-39

boolean startupShooter; // turns off after first/initialization loop
Player player;
ArrayList<MissilePlayer> missilesPlayer;
ArrayList<MissileEnemy> missilesEnemy;
ArrayList<Enemy> enemies;


void shooter_i(){ //gameState 30

	textAlign(CENTER,CENTER);
	text("Learn how to play. Press SPACE.", width/2, height/2);
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

void userInputsShooter(){
	if (key == ' ') {
		if(gameState == 31){
			missilesPlayer.add(new MissilePlayer());
			for (Enemy en : enemies){
				missilesEnemy.add(new MissileEnemy(en.posX,en.posY));
			}
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

class Player{
	int hitsAllowed = 3;
	int health = hitsAllowed;
	float posX = width/2;
	float posY = height*0.9;
	float keyStepSize = width/30;

	Player(){

	}

	void draw(){
		imageMode(CENTER);
		image(spacecraft, posX, posY, width/20, width/20);
		drawHealthBar();
		if (health <= 0) { // go back to menu if dead
			// player = null;
			// missiles = null;
			// enemies = null;
			miniGameLoss();
		}
	}

	void drawHealthBar(){
		fill(250,200,50);
		rectMode(CORNER);
		rect(0,0,width*health/hitsAllowed,height/40);
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
	float velY = -height/50;

	MissilePlayer(){
		posX = player.posX;
		posY = player.posY;
		// println("missile created");
	}

	void draw(){
		fill(200);
		ellipseMode(CENTER);
		ellipse(posX, posY, width/150, width/150);
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
		fill(100,180,230);
		ellipseMode(CENTER);
		ellipse(posX, posY, width/150, width/150);
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
		image(rocket, posX, posY, width/20, width/20);
	}

}

