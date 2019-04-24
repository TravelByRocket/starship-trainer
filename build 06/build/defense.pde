// gameState range 20-29

PImage blast;
PImage defensePre00;
PImage defensePre01;
PImage defensePre02;
PImage defensePre03;
PImage defensePre04;
PImage defensePre05;
PImage defensePre06;
PImage defensePre07;
PImage defensePre08;
PImage defensePost00;

PImage defenseBackground;
PImage asteroid01;

ArrayList<Asteroid> asteroids;
ArrayList<Blast> blasts;
ArrayList<ProgressMessage> progresses;

float planetCenterX;
float planetCenterY;
float planetRadius;

int planetHealth = 10;
int destroyCount = 0;

void defenseIntro(){ //gameState 20
	
	if (scene == 0) {	
		placeMenuImage(defensePre00);
		animationScreen = 0;
	} else if (scene == 1) {
		if (frameCount % 50 == 0){
			animationScreen++;
		}
		if (animationScreen == 0){
			placeMenuImage(defensePre01);
		} else if (animationScreen == 1) {
			placeMenuImage(defensePre02);
		} else if (animationScreen == 2) {
			placeMenuImage(defensePre04);
		} else if (animationScreen == 3) {
			placeMenuImage(defensePre05);
		} else if (animationScreen == 4) {
			placeMenuImage(defensePre06);
		} else if (animationScreen == 5) {
			placeMenuImage(defensePre07);
		} else {
			animationScreen = 0;
		}
	} else if (scene == 2) {
		placeMenuImage(defensePre08);
	} else {
		gameState++;
		scene = 0;
	}
}

void defenseTraining(){ // gameState 21

	placeMenuImage(defenseBackground);

	textSize(24);
	fill(255);
	textAlign(CENTER,CENTER);

	if (scene == 0){
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		asteroids.add(new Asteroid(width/2,height*2/5,"training"));
		asteroids.add(new Asteroid(width/3,height*3/5,"training"));
		asteroids.add(new Asteroid(width*2/3,height*3/5,"training"));
		scene++;
	} else if (scene == 1){
		if (asteroids.size() > 0){
			text("Destroy the asteroids\n by making a circle with your\nright index finger", width/2, height*2/3);
		} else {
			text("You're ready.\nPress button to play", width/2, height*2/3);
		}
	} else if (scene == 2){
		gameState++;
		scene = 0;
	}

	itemHandling();
	leapManager();
}

void defenseGame(){ //gameState 22

	placeMenuImage(defenseBackground);
	int numActiveAsteroids = 5;

	if (scene == 0){
		asteroids = new ArrayList<Asteroid>();
		blasts = new ArrayList<Blast>();
		progresses = new ArrayList<ProgressMessage>();
		for (int i = 0; i < numActiveAsteroids; i++){
			asteroids.add(new Asteroid());
		}
		planetCenterX = width/2;
		planetCenterY = height;
		planetRadius = width*.35;
		planetHealth = 10;
		destroyCount = 0;
		scene++;
	} else if (scene == 1){
		if (asteroids.size() < numActiveAsteroids){
			asteroids.add(new Asteroid());
		}
	}

	if (destroyCount >= 12){
		gameState++;
		scene = 0;
	} else if (planetHealth <= 0) {
		gameState = 61;
		scene = 0;
	}

	textSize(24);
	fill(gameOrange);
	textAlign(LEFT,TOP);
	text("Asteroids Destroyed:"+destroyCount+"of 12", 0, 0);

	ellipseMode(CENTER);
	strokeWeight(3);
	stroke(gameRed);
	noFill();
	ellipse(planetCenterX, planetCenterY, planetRadius*2, planetRadius*2);

	drawHealthBarPlanet(planetHealth);
	itemHandling();
	leapManager();
}

void defenseStory(){ //gameState 23
	if (scene == 0){
		placeMenuImage(defensePost00);
	} else if (scene == 1) {
		defenseWin = true;
		gameState = 60;
		scene = 0;			
	}
}

void userInputsDefense(){
	if (key == ' ') {
		if(gameState == 20){
			scene++;
		} else if (gameState == 21){
			scene++;
		} else if (gameState == 22) {
			//no button needed
		} else if (gameState == 23) {
			scene++;
		}
	} else if (keyCode == DOWN) {
		planetHealth--;
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
	float posX;
	float posY;
	float velX;
	float velY;
	boolean destroyed = false;
	boolean destroyable = false;
	String mode = "normal";
	float fader = 255;
	float fadeSpeed = 25;
	float spinSpeedFactor = 0.4; // 1 -> 2.8 rev/sec; 0.5 -> 1.4 rev/sec
	float rotationOffset = 0;
	float illumOffset;

	Asteroid(){
		posX = random(width*0.2,width*0.8);
		posY = random(-50,-300);
		velX = random(-.5,.5);
		velY = random(0.5,2);
	}

	Asteroid(float thePosX,float thePosY){
		posX = thePosX;
		posY = thePosY;
		velX = 0;
		velY = 0;
	}

	Asteroid(float thePosX,float thePosY,String theMode){
		posX = thePosX;
		posY = thePosY;
		velX = 0;
		velY = 0;
		mode = "training";
		rotationOffset = random(360);
		illumOffset = random(1000);
	}

	Asteroid(float thePosX,float thePosY, float theVelX, float theVelY){
		posX = thePosX;
		posY = thePosY;
		velX = theVelX;
		velY = theVelY;
	}

	void draw(){
		imageMode(CENTER);
		tint(255,255);
		noFill();
		image(asteroid01, posX, posY, width*0.06, width*0.06);

		if (mode == "training"){
			ellipseMode(CENTER);
			if ((millis() + illumOffset) % 2000 < 1000){
				fader += fadeSpeed;
			} else {
				fader -= fadeSpeed;
			}

			if (fader < 0){
				fader = 0;
			} else if (fader > 255) {
				fader = 255;
			}

			stroke(gameOrange, fader);
			strokeWeight(3);
			noFill();
			ellipse(posX+width/10*cos(radians((millis()*spinSpeedFactor)%360+rotationOffset)),
				posY+width/10*sin(radians((millis()*spinSpeedFactor)%360+rotationOffset)),
				15,15);
		}
		posX+= velX;
		posY+= velY;

		collisionCheck();

	}

	void collisionCheck(){
		if (dist(planetCenterX,planetCenterY,posX,posY)<planetRadius){
			destroyed = true;
			planetHealth--;
		}
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

	Blast(float thePosX, float thePosY){
		posX = thePosX;
		posY = thePosY;
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
		for (Asteroid as : asteroids){
			if (dist(posX, posY, as.posX, as.posY) < width*0.1){
				as.destroyed = true;
				destroyCount++;
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
		posX = theX;
		posY = theY;
		// posX = width/2;
		// posY = height/4;
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
	// blastZone.draw();

	// ASTEROID HANDLING
	for (int j = asteroids.size() - 1; j >= 0; j--) { // go backwards through ArrayList of asteroids
	 	Asteroid as = asteroids.get(j); // get the missile at current index
	 	if (as.destroyed || as.posY > height || as.posX < 0 || as.posX > width) { // if it is expired
	 		asteroids.remove(j); // then remove it from the ArrayList
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
	asteroid01 = requestImage("../../data/asteroid01.png");

	defensePre00 = requestImage("../../data/defensePre00.png");
	defensePre01 = requestImage("../../data/defensePre01.png");
	defensePre02 = requestImage("../../data/defensePre02.png");
	defensePre03 = requestImage("../../data/defensePre03.png");
	defensePre04 = requestImage("../../data/defensePre04.png");
	defensePre05 = requestImage("../../data/defensePre05.png");
	defensePre06 = requestImage("../../data/defensePre06.png");
	defensePre07 = requestImage("../../data/defensePre07.png");
	defensePre08 = requestImage("../../data/defensePre08.png");
	defensePost00 = requestImage("../../data/defensePost00.png");

	defenseBackground = requestImage("../../data/Planet Defense Blank Screen-01.png");
	blast = requestImage("../../data/playerBlast.png");
}

void drawHealthBarPlanet(int theHealth){
	if (theHealth == 10) {
		placeMenuImage(status10);
	} else if (theHealth == 9) {
		placeMenuImage(status09);
	} else if (theHealth == 8) {
		placeMenuImage(status08);
	} else if (theHealth == 7) {
		placeMenuImage(status07);
	} else if (theHealth == 6) {
		placeMenuImage(status06);
	} else if (theHealth == 5) {
		placeMenuImage(status05);
	} else if (theHealth == 4) {
		placeMenuImage(status04);
	} else if (theHealth == 3) {
		placeMenuImage(status03);
	} else if (theHealth == 2) {
		placeMenuImage(status02);
	} else if (theHealth == 1) {
		placeMenuImage(status01);
	}
}