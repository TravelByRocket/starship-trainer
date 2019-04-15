// gameState range 20-29

ArrayList<Asteroid> asteroids;
ArrayList<Blast> blasts;
boolean startupDefense; // turns off after first/initialization loop

void defenseIntro(){ //gameState 20
	tint(255);
	imageMode(CORNER);
	image(defenseScreen01,0,0,width,height);
	startupDefense = true;
}

void defenseTraining(){ // gameState 21
	gameState++;
}

void defenseGame(){ //gameState 22

	if (startupDefense){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		for (int k = 0; k < 5; k++){
			asteroids.add(new Asteroid());
		}
		startupDefense = false; //don't run these initializations again
	}

	imageMode(CORNER);
	image(defenseBackground,0,0,width,height);

	for (Asteroid as : asteroids){
		as.draw();
	}

	for (Blast bl : blasts){
		bl.draw();
	}

	// BLAST HANDLING
	for (int i = blasts.size() - 1; i >= 0; i--) { // go backwards through ArrayList of blasts
	 	Blast bl = blasts.get(i); // get the missile at current index
	 	if (bl.expired) { // if it is expired
	 		blasts.remove(i); // then remove it from the ArrayList
	 	}
	}

	// ASTEROID HANDLING
	for (int j = asteroids.size() - 1; j >= 0; j--) { // go backwards through ArrayList of asteroids
	 	Asteroid as = asteroids.get(j); // get the missile at current index
	 	if (as.destroyed) { // if it is expired
	 		asteroids.remove(j); // then remove it from the ArrayList
	 	}
	}

	if (asteroids.size() == 0)
		gameState++;
	leapManager();
}

void defenseStory(){ //gameState 23
	defenseWin = true;
	miniGameWin();
}

void userInputsDefense(){
	
	if (key == ' ') {
		if(gameState == 20){
			gameState++;
		} else if (gameState == 21){
			gameState++;
		} else if (gameState == 22) {
			//no button needed
		}	
	}
	
}

void leapOnCircleGesture(CircleGesture g, int leapState){
	if (gameState == 21 && leapState == 3){ // if in gameplay and if in the state marking end of gesture
		Finger finger = g.getFinger();
		PVector positionCenter = g.getCenter();
		fill(gameRed);
		ellipse(positionCenter.x, positionCenter.y, 200, 200);
		delay(200);
		// text("x="+str(positionCenter.x)+"\ny="+str(positionCenter.y),width/2,height/2);
		// println("("+str(round(positionCenter.x))+","+str(round(positionCenter.y))+")");
		blasts.add(new Blast(positionCenter.x,positionCenter.y));
	}
}

class Asteroid{
	int type = (int) floor(random(0,3));
	float posX = random(width*0.2,width*0.8);
	float posY = random(height*0.1,height*0.7);
	boolean destroyed = false;
	boolean destroyable = false;

	// int rotation = random(0, TWO_PI);
	Asteroid(){

	}

	void draw(){
		imageMode(CENTER);
		if (type == 0){
			image(asteroid1, posX, posY, width*0.10, width*0.10);
		} else if (type == 1) {
			image(asteroid2, posX, posY, width*0.10, width*0.10);
		} else if (type == 2) {
			image(asteroid3, posX, posY, width*0.10, width*0.10);
		}

		posY = posY + 5;

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

	Blast(float posX_, float posY_){
		posX = posX_;
		posY = posY_;
		for (Asteroid as : asteroids){
			distance = sqrt(sq(posX-as.posX)+sq(posY-as.posY));
			if (distance < width*0.1){
				as.destroyed = true;
			}
		}
	}

	void draw(){
		tint(fader);
		imageMode(CENTER);
		image(blast, posX, posY, width*0.10, width*0.10);
		tint(255);
		fader -=20;
		framesLived++;
		if (framesLived >= frameLife){
			expired = true;
		}
	}

}