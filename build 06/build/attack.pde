// gameState range 40-49

PImage AttackPost00;

boolean circs1 = false;
boolean circs2 = false;
boolean circs3 = false;
boolean circs4 = false;

float trainingCircleRadius = width*2;

void attackIntro(){ // gameState 40
	tint(255);
	textAlign(CENTER,CENTER);
	textSize(18);
	text("Learn how to play. Press SPACE.", width/2, height/2);

}

void attackTraining(){ // gameState 41
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

void attackGame(){ // gameState 42

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

void attackStory(){ // // gameState 43
	textAlign(CENTER,CENTER);
	text("Attack Game Win", width/2, height/2);
	attackWin = true;
	miniGameWin();
}

void userInputsAttack(){
	
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

void leapInputsAttack(){ //better to call userLeapShooter?

	
}

void loadAttackImages(){
	AttackPost00 = loadImage("../../data/AttackPost00.png");
}