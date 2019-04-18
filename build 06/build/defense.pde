// gameState range 20-29

PImage blast;
PImage defensePre00;
PImage defensePre01;
PImage defensePre02;
PImage defensePre03;
PImage defensePost00;

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

	tint(255);
	imageMode(CORNER);
	
	if (scene == 0) {	
		image(defensePre00,0,0,width,height);
	} else if (scene == 1) {
		image(defensePre01,0,0,width,height);
	} else if (scene == 2) {
		image(defensePre02,0,0,width,height);
	} else if (scene == 3) {
		image(defensePre03,0,0,width,height);
	} else {
		gameState++;
		scene = 0;
	}
}

void defenseTraining(){ // gameState 21
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
			if (as.posX >width*.9){
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
		asteroids.add(new Asteroid(width/3,height/2,1.5,0));
		blastZone = new BlastZone(width*2.5,height/2,width*1.7,width*1.9);
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

void defenseGame(){ //gameState 22

	imageMode(CORNER);
	image(defenseBackground,0,0,width,height);

	if (startupDefense){ // create on first loop 
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		// for (int k = 0; k < 5; k++){
		// 	asteroids.add(new Asteroid());
		// }
		asteroids.add(new Asteroid(width*1/6,height*.3,.5,1.1));
		asteroids.add(new Asteroid(width*2/6,height*.1,.55,.8));
		asteroids.add(new Asteroid(width*3/6,height*.2,.4,.6));
		asteroids.add(new Asteroid(width*4/6,height*.4,-.45,1.2));
		asteroids.add(new Asteroid(width*5/6,height*.2,-.39,.7));
		blastZone = new BlastZone(width*.5,height*1.1,1,width*.45);
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

void defenseStory(){ //gameState 23
	image(defensePost00,0,0,height,width);
	defenseWin = true;
	// miniGameWin();
	gameState = 60;

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
		posX = random(width*0.2,width*0.8);
		posY = random(height*0.1,height*0.7);
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

	void draw(){
		imageMode(CENTER);
		tint(255,255);
		noFill();
		if (type == 0){
			image(asteroid01, posX, posY, width*0.06, width*0.06);
		} else if (type == 1) {
			image(asteroid02, posX, posY, width*0.06, width*0.06);
		} else if (type == 2) {
			image(asteroid03, posX, posY, width*0.06, width*0.06);
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

	void draw(){
		for (Asteroid as : asteroids){
			if (as.destroyable == true){
				// println("asteroid destroyable at: "+millis());
				as.destroyed = true;
				tint(fader);
				imageMode(CENTER);
				image(blast, as.posX, as.posY, width*0.10, width*0.10);
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

	void draw(){
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

	void draw(){
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

void itemHandling(){

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

void loadDefenseImages(){
	asteroid01 = loadImage("../../data/asteroid01.png");
	asteroid02 = loadImage("../../data/asteroid02.png");
	asteroid03 = loadImage("../../data/asteroid03.png");

	defensePre00 = loadImage("../../data/defensePre00.png");
	defensePre01 = loadImage("../../data/defensePre01.png");
	defensePre02 = loadImage("../../data/defensePre02.png");
	defensePre03 = loadImage("../../data/defensePre03.png");
	defensePost00 = loadImage("../../data/defensePost00.png");

	defenseBackground = loadImage("../../data/Planet Defense Blank Screen-01.png");
	blast = loadImage("../../data/playerBlast.png");
}