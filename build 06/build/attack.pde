// gameState range 40-49

PImage attackPost00;
PImage attackPre00;
PImage attackPre01;
PImage attackPre02;
PImage attackPre03;

boolean circs1 = false;
boolean circs2 = false;
boolean circs3 = false;
boolean circs4 = false;

PShape spacecraft3d;

float trainingCircleRadius = width*2;

ArrayList<Ring> rings;
ArrayList<Barrier> barriers;
Slot slot;

float velZ = 20;

void attackIntro(){ // gameState 40
	
	if (scene == 0) {
		placeMenuImage(attackPre00);
		animationScreen = 0;
	} else if (scene == 1){
		if (frameCount % 50 == 0){
			animationScreen++;
		}
		if (animationScreen == 0){
			placeMenuImage(attackPre01);
		} else if (animationScreen == 1) {
			placeMenuImage(attackPre02);
		} else {
			animationScreen = 0;
		}
	} else if (scene == 2){
		placeMenuImage(attackPre03);
	} else if (scene == 3) {
		gameState++;
		scene = 0;
	}
}

void attackTraining(){ // gameState 41

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

	if (scene == 0){
		textSize(24);
		fill(255);
		textAlign(CENTER,CENTER);
		if (circs1 && circs2 && circs3 && circs4){
			text("You got it!\nPress button to move on", width/2, height/4);
		} else {
			text("Roll hand\nCW and CCW\nto Highlight Circles", width/2, height/4);	
		}
	} else if (scene == 1) {
		circs1 = false;
		circs2 = false;
		circs3 = false;
		circs4 = false;
		gameState++;
		scene = 0;
	}
}

int barrierCount = 0;

void attackGame(){ // gameState 42

	lights();

	// add and place spacecraft
	pushMatrix();
	translate(width/2, height*3/4, 0);
	rotateZ(PI+radians(handRoll));
	rotateY(PI);
	shape(spacecraft3d,0,-80,width*2/3,width/10);
	popMatrix();

	if (scene == 0){
		rings = new ArrayList<Ring>();
		barriers = new ArrayList<Barrier>();
		scene++;
	} else if (scene == 1){
		if (frameCount%15 == 0){
			rings.add(new Ring());
		}
		if (frameCount%60 == 0){
			if (barrierCount <= 2){
				barriers.add(new Barrier());
				barrierCount++;
				velZ++;
			} else {
				slot = new Slot();
				scene++;
			}	
		}
	} else if (scene == 2) {
		
	} else if (scene == 3) {
		gameState++;
		scene = 0;
		barrierCount = 0;
	}
	
	itemHandlingAttack();
	leapManager();
}

void attackStory(){ // // gameState 43
	
	imageMode(CORNERS);
	if (scene == 0){
		placeMenuImage(attackPost00);
		attackWin = true;
	} else if (scene == 1) {
		gameState = 60;
		scene = 0;	
	}
}

void userInputsAttack(){
	
	if (key == ' ') {
		scene++;
	}
	
}

void leapInputsAttack(){ //better to call userLeapShooter?

	
}

void loadAttackImages(){
	attackPost00 = requestImage("../../data/attackPost00.png");
	attackPre00 = requestImage("../../data/attackPre00.png");
	attackPre01 = requestImage("../../data/attackPre01.png");
	attackPre02 = requestImage("../../data/attackPre02.png");
	attackPre03 = requestImage("../../data/attackPre03.png");
	spacecraft3d = loadShape("../../data/spacecraft.obj");
}

class Ring{
	float startingDepth = -2000; // more negative is into the distance
	float radius = width/2;
	float centerX = width/2;
	float centerY = height*3/4;
	float posZ = startingDepth;
	boolean expired = false;
	// float velZ = 20;
	private int fader;

	Ring(){
		fader = 0;
	}

	Ring(float thePosZ){
		posZ = thePosZ;
		fader = 0;
	}

	void draw(){
		// background(0);
		ellipseMode(CENTER);
		pushMatrix();
		translate(0, 0, posZ);
		noFill();
		stroke(fader);
		ellipse(centerX, centerY, radius*2, radius*2);
		popMatrix();
		posZ += velZ;
		if (posZ > 1000){
			expired = true;
		}

		fader += 1;
		if (fader > 100){
			fader = 100;
		}
		
	}
}

class Barrier{
	float startingDepth = -2000; // more negative is into the distance
	float radius = width/2;
	float centerX = width/2;
	float centerY = height*3/4;
	float posZ = startingDepth;
	boolean expired = false;
	// float velZ = 20;
	int fader;
	float rotation = random(-50,50);

	Barrier(){
		fader = 0;
	}

	Barrier(float thePosZ){
		posZ = thePosZ;
		fader = 0;
	}

	void draw(){
		ellipseMode(CENTER);
		pushMatrix();
		translate(0, 0, posZ);
		noStroke();
		fill(fader);
		arc(centerX, centerY, radius*2, radius*2,radians(rotation+10),radians(rotation+180-10),CHORD);
		popMatrix();
		posZ += velZ;
		if (posZ > 1000){
			expired = true;
		}

		fader += 1;
		if (fader > 100){
			fader = 100;
		}
		
	}
}

class Slot{
	float startingDepth = -2000; // more negative is into the distance
	float radius = width/2;
	float centerX = width/2;
	float centerY = height*3/4;
	float posZ = startingDepth;
	boolean expired = false;
	// float velZ = 20;
	int fader;
	float rotation = 0;

	Slot(){
		fader = 0;
	}

	void draw(){
		ellipseMode(CENTER);
		pushMatrix();
		translate(0, 0, posZ);
		// noStroke();
		stroke(fader);
		// fill(fader);
		noFill();
		rectMode(CENTER);
		rect(centerX, centerY, radius*1.5, radius/4);
		// ellipse(centerX, centerY, radius*2, radius*2);
		// fill(0);
		// ellipse(centerX, centerY, radius, radius/4);
		popMatrix();
		posZ += velZ;
		if (posZ > 1000){
			expired = true;
		}

		fader += 1;
		if (fader > 100){
			fader = 100;
		}
		
	}
}

void itemHandlingAttack(){
	for (int i = rings.size() - 1; i >= 0; i--) { // go backwards through ArrayList of blasts
	 	Ring ri = rings.get(i); // get the missile at current index
	 	if (ri.expired) { // if it is expired
	 		rings.remove(i); // then remove it from the ArrayList
	 	} else {
	 		ri.draw();
	 	}
	}

	for (int i = barriers.size() - 1; i >= 0; i--) { // go backwards through ArrayList of blasts
	 	Barrier ba = barriers.get(i); // get the missile at current index
	 	if (ba.expired) { // if it is expired
	 		barriers.remove(i); // then remove it from the ArrayList
	 	} else {
	 		ba.draw();
	 	}
	}

	if (slot != null){
		slot.draw();
	}
}
