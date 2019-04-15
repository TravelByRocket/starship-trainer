float commandPositionX;
float commandPositionY;
float commandPositionZ;
float commandPositionIndexX;
float commandPositionIndexY;

PImage menuCursor;
PImage playerCursor;

void loadLeapImages(){
	menuCursor = loadImage("../../data/menuCursor.png");
	playerCursor = loadImage("../../data/playerCursor.png");
}

void leapManager(){
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

			if (gameState != 21 && gameState != 22){
				// stroke(gameGreen);
				// strokeWeight(3);
				// noFill();
				// ellipse(commandPositionX,commandPositionY,20,20);
				imageMode(CENTER);
				image(menuCursor,commandPositionX,commandPositionY,20,20);
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
			fill(#FF0000);
			textSize(24);
			textAlign(CENTER,BOTTOM);
			text("Left Hand Not Yet Supported", width/2, height/8);
		}

	}

	if (commandPositionX < 0){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nRight", width/4, height/2);
	}

	if (commandPositionX > width){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nLeft", width*3/4, height/2);
	}

	if (commandPositionY < 0){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nDown", width/2, height/4);
	}

	if (commandPositionY > height){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move\nUp", width/2, height*3/4);
	}

	if (commandPositionZ > 65){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move Hand\nToward You", width/2, height*3/4);
	}

	if (commandPositionZ < 30){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,CENTER);
		text("Move Hand\nAway from You", width/2, height*3/4);
	}

	if (handCount == 0){
		fill(#FF0000);
		textSize(24);
		textAlign(CENTER,BOTTOM);
		text("Hand Not Found", width/2, height/8);
		
		rectMode(CORNERS);
		stroke(#FF0000);
		strokeWeight(4);
		noFill();
		rect(width*.05,height*.05,width*.95,height*.95);
	}

}