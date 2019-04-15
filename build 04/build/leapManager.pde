float commandPositionX;
float commandPositionY;
float commandPositionZ;

void leapManager(){
	commandPositionX = width/2;
	commandPositionY = height/2;
	commandPositionZ = 50;
	PVector handPosition;
	boolean handIsRight;
	handCount = leap.getHands().size();

	for (Hand hand : leap.getHands()) {
		handPosition = hand.getPosition();
		handIsRight = hand.isRight();
		if (handIsRight){
			commandPositionX = map(handPosition.x,150,725,0,width);
			commandPositionY = map(handPosition.y,200,450,0,height);
			commandPositionZ = handPosition.z;
			stroke(gameGreen);
			strokeWeight(3);
			noFill();
			ellipse(commandPositionX,commandPositionY,20,20);
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