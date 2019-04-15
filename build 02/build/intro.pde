// gameState range 0-9
void intro_i() {

	// fill(200);
	// textSize(40);
	// textAlign(CENTER,BOTTOM);
	// text("Welcome cadet,\n\nThere’s much to learn, and not much time.\nLet’s get started.",
	// 	width/2, height/2);
	// textSize(32);
	// text("Press SPACE to continue...",width/2, height*2/3);
	
	imageMode(CORNER);

	if (scene == 0) {
		image(introScreen01,0,0,width,height);
	} else if (scene == 1) {
		image(introScreen02,0,0,width,height);
	} else {
		gameState = 10;
		scene = 0;
	}

}

void userInputsIntro(){
	if (key == ' ') {
		scene++;
	}

}

// void intro_ii(){
// 	fill(200);
// 	textSize(40);
// 	textAlign(CENTER,CENTER);
// 	text("We didn’t see them coming.\n\nThey attacked our planet, and destroyed our\nspace fleet.\n\nWe will have no defenses left and no way to\nprotect our planet...unless you can complete the\ntraining to become a space pilot.",
// 		width/2, height/2);	
// }

// void intro_iii(){
// 	gameState = 10;
// }