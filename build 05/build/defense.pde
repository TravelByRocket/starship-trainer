// gameState range 20-29

PImage blast;
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

void defenseIntro(){ //gameState 20
	
	startupDefense = true;

	if (scene == 0) {
		tint(255);
		imageMode(CORNER);
		image(defenseScreen01,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
	}
}

void defenseTraining(){ // gameState 21
	// make a circle with your right index finger

	textSize(18);
	fill(255);
	textAlign(CENTER,CENTER);
	if (scene == 0){
		text("Destroy the asteroid\n by making a circle with your\nright index finger", width/2, height*2/3);
	} else if (scene == 1){
		text("That's it! Do it again when the astreoid\nis in the defense zone", width/2, height*2/3);
		rectMode(CENTER);
		fill(gameRed,50);
		rect(width/2,height/2,height*.8,width*.2);
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
		println("startup scene 0");
	} else if (startupDefense && scene == 1){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		asteroids.add(new Asteroid(width/4,height/2,2,0));
		blastZone = new BlastZone(width*2.5,height/2,width*1.8,width*1.9);
		startupDefense = false; //don't run these initializations again
		println("startup scene 1");
	}

	if (scene == 0 && blasts.size() > 0){
		scene++;
		startupDefense = true;
	} else if (scene == 1){
		for (Asteroid as : asteroids){
			if (blasts.size() > 0 && as.posX > width*0.45 || as.posX < width*0.55) {
				scene++;
				startupDefense = true;
			} else if (as.posX > width*0.7){
				as.posX = width/4;
			}
		}
	}

	itemHandling();
	leapManager();
}

void defenseGame(){ //gameState 22

	if (startupDefense){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		for (int k = 0; k < 5; k++){
			asteroids.add(new Asteroid());
		}
		startupDefense = false; //don't run these initializations again
	}

	imageMode(CORNER);
	image(defenseBackground,0,0,width,height);


	if (asteroids.size() == 0){
		gameState++;
	}
	leapManager();
}

void defenseStory(){ //gameState 23
	image(DefensePost00,0,0,height,width);
	defenseWin = true;
	miniGameWin();

}

void userInputsDefense(){
	
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

void leapOnCircleGesture(CircleGesture g, int leapState){
	if (gameState == 21 || gameState == 22){
		if (leapState == 3){ // if in gameplay and if in the state marking end of gesture
			Finger finger = g.getFinger();
			if (finger.getId()%10 == 1){
				PVector positionCenter = g.getCenter();
				float progress = g.getProgress();
				if (progress > 0.99){
					blasts.add(new Blast(mapLeapX(positionCenter.x),mapLeapY(positionCenter.y)));

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
		posX = random(width*0.2,width*0.8);
		posY = random(height*0.1,height*0.7);
		velX = 0;
		velY = 0;
	}

	Asteroid(float thePosX,float thePosY){
		posX = thePosX;
		posY = thePosY;
		velX = 0;
		velY = 0;
	}

	Asteroid(float thePosX,float thePosY, float theVelX, float theVelY){
		posX = thePosX;
		posY = thePosY;
		velX = theVelX;
		velY = theVelY;
	}

	void draw(){
		imageMode(CENTER);
		if (type == 0){
			image(asteroid01, posX, posY, width*0.10, width*0.10);
		} else if (type == 1) {
			image(asteroid02, posX, posY, width*0.10, width*0.10);
		} else if (type == 2) {
			image(asteroid03, posX, posY, width*0.10, width*0.10);
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

	void draw(){
		ellipseMode(CENTER);
		fill(gameRed,50);
		ellipse(centerX, centerY, radiusOuter*2, radiusOuter*2);
		fill(0);
		ellipse(centerX, centerY, radiusInner*2, radiusInner*2);
		for (Asteroid as : asteroids){
			distance = dist(as.posX,centerX,as.posY,centerY);
			if (distance > radiusInner && distance < radiusOuter){
				as.destroyable = true;
			} else {
				as.destroyable = false;
			}
		}
	}
}

class ProgressMessage{
	float percentage;
	float posX;
	float posY;
	int fader = 255;
	int frameLife = 20;
	int framesLived = 0;
	boolean expired = false;

	ProgressMessage(float theProgress, float theX, float theY){
		percentage = theProgress;
		posX = theX;
		posY = theY;
	}

	void draw(){
		fill(fader);
		textAlign(CENTER,CENTER);
		textSize(24);
		text(percentage + "%",posX,posY);
		// fill(255);
		fader -=10;
		framesLived++;
		if (framesLived >= frameLife){
			expired = true;
		}
	}
}

void itemHandling(){

	noStroke();
	blastZone.draw();

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

	// ASTEROID HANDLING
	for (int j = asteroids.size() - 1; j >= 0; j--) { // go backwards through ArrayList of asteroids
	 	Asteroid as = asteroids.get(j); // get the missile at current index
	 	if (as.destroyed) { // if it is expired
	 		asteroids.remove(j); // then remove it from the ArrayList
	 	} else {
	 		as.draw();
	 	}
	}

}

void loadDefenseImages(){
	asteroid01 = loadImage("../../data/asteroid01.png");
	asteroid02 = loadImage("../../data/asteroid02.png");
	asteroid03 = loadImage("../../data/asteroid03.png");
	DefensePost00 = loadImage("../../data/DefensePost00.png");
	defenseScreen01 = loadImage("../../data/Planet defense instructions 1-01.png");
	defenseBackground = loadImage("../../data/Planet Defense Blank Screen-01.png");
	blast = loadImage("../../data/playerBlast.png");
}