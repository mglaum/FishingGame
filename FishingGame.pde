import processing.sound.*;
SoundFile click;
// Array of all fish in the game
Fish[] fish = new Fish[6]; // Update size as fish are added
ArrayList<Fish> fishInTheSea = new ArrayList<Fish>(); // array for random generation of fish
Game game = new Game();
Player player = new Player(); 

PFont titleFont;
PFont casualFont;
PImage mainMenuBackground;
PImage plankButton;
PImage cloud1;
PImage cloud2;
PImage cloud3;
PImage cloud4;
PImage cloud5;
PImage cloud6;
PImage fishingBackground;
PImage marketBackground; 
PImage joe; 
PImage miniGameBackground;
PImage miniGameBall;
PImage backgroundForDisplay;
PImage butt; 

// Class to handle game states
class Game {
  int difficulty; // 1 = Normal, 2 = Hard
  boolean isMainMenu1; // game state 1: start or quit
  boolean isMainMenu2; // game state 2: select difficulty
  boolean isPrologue; // game state 3: prologue
  boolean isFishing; // game state 4: fishing
  boolean isMiniGame; // game state 5: mini game to catch a fish after nibble
  boolean isShopping; // game state 6: shopping in market
  boolean isVictorious; // game state 7: end credits
  Game() {
    isMainMenu1 = true;
    isMainMenu2 = false;
    isPrologue = false;
    isFishing = false;
    isMiniGame = false;
    isShopping = false;
    isVictorious = false;
  }
}

class Fish {
  int value; 
  String name; 
  PImage sprite;
  float rarity; 
  Fish(int val, String n, PImage img, float r) {
    value = val; 
    name = n; 
    sprite = img; 
    rarity = r; // i.e. Most common: 20, Least common: 1
  }
}
class Player {
  boolean cast; // True if casting or line is in the water; false if resting/reeled in
  boolean nibble; 
  boolean caught;
  int x; 
  int y; 
  int money; 
  ArrayList<Fish> inventory = new ArrayList<Fish>(); // dynamic array
  Player() {
    cast = false; 
    caught = false;
    x = 0; 
    y = 0; 
    money = 0; 
    nibble = false; 
  }
}

class FishingRod {
  PImage sprite; 
  String name; 
  Upgrade[] upgrades; 
}

class Upgrade {
  String name; 
}

class Market {
  Upgrade[] upgrades;
  FishingRod[] rods; 
  void drawMarket() {
    return;
  }
}

void setup() {
    size(600,600);
    titleFont = createFont("./fonts/PIXEL-LI.TTF", 100);
    casualFont = createFont("./fonts/dogicabold.otf", 35);
    mainMenuBackground = loadImage("./images/MainMenuBackground.png");
    fishingBackground = loadImage("./images/FishingBackground.png");
    fishingBackground.resize(600, 0);
    plankButton = loadImage("./images/button.PNG");
    plankButton.resize(300, 0);
    marketBackground = loadImage("./images/market.PNG"); 
    joe = loadImage("./images/joe.PNG"); 
    miniGameBackground = loadImage("./images/miniGameFrame.png"); // pixels: from (150, 150) to (450, 450)
    miniGameBackground.resize(300, 0);
    miniGameBall = loadImage("./images/miniGameBall.png");
    miniGameBall.resize(16, 0);
    backgroundForDisplay = loadImage("./images/backgroundForDisplay.png");
    backgroundForDisplay.resize(300, 0);
    loadClouds();
    loadFish();
    click = new SoundFile(this, "./audio/button_sound.mov");
    //TODO: remove after testing
    //  game.isFishing = true;
    //  game.isMainMenu1 = false;
}



void draw() {
  if (game.isMainMenu1 || game.isMainMenu2) {
    drawMainMenu(); 
  } else if (game.isPrologue) {
    drawPrologue(); 
  } else if (game.isFishing) {
    drawFishing(); 
    if (game.isShopping) {
      drawMarket(); 
    }
  } else if (game.isMiniGame) {
    drawMiniGame();
    if (player.caught) {
      displayFish();
    } else {

    }
  } else if (game.isVictorious) {

  }
}

// Variables for moving x-coords of clouds and fish
int x1 = 50;
int x2 = 175;
int x3 = 350;
int x4 = 420;
int x5 = 20;
int x6 = 520;
int fish1 = 100;
int fish2 = 500;
int fish3 = 300;

void drawMainMenu() {
  // drawing images: background, clouds, fish, buttons
  image(mainMenuBackground, 0, 0);
  image(cloud1, x1--, 75);
  image(cloud2, x2--, 10);
  image(cloud3, x3--, 85);
  image(cloud4, x4--, 15);
  image(cloud5, x5--, 25);
  image(cloud6, x6--, 95);
  
  image(fish[0].sprite, fish1++, 500);
  image(fish[1].sprite, fish2++, 180);
  image(fish[2].sprite, fish3++, 300);
  
  imageMode(CENTER);
  image(plankButton, 300, 275);
  image(plankButton, 300, 400);
  
  checkBounds();
    
  // writing all text to the main menu screen
  textAlign(CENTER);

  fill(#044d57);
  textFont(titleFont);
  text("Fishing Game", 300, 105);
  textFont(casualFont);
  if (mouseX > 160 && mouseX < 430 && mouseY > 242 && mouseY < 314) {
    fill(255); 
  }
  else {
    fill(#044d57);
  }
  if (game.isMainMenu1) {
    text("Start", 300, 285);
  }
  else {
    text("Normal", 300, 285);
  }
  
  if (mouseX > 160 && mouseX < 430 && mouseY > 370 && mouseY < 430) {
    fill(255); 
  }
  else {
    fill(#044d57);
  }
  if (game.isMainMenu1) {
    text("Quit", 300, 410);
  }
  else {
    text("Hard", 300, 410);
  }
  imageMode(CORNER);
}

void loadClouds() {
  cloud1 = loadImage("./images/pixelcloud_1.png");
  cloud1.resize(128, 0);
  cloud2 = loadImage("./images/pixelcloud_2.png");
  cloud2.resize(90, 0);
  cloud3 = loadImage("./images/pixelcloud_3.png");
  cloud3.resize(80, 0);
  cloud4 = loadImage("./images/pixelcloud_4.png");
  cloud4.resize(110, 0);
  cloud5 = loadImage("./images/pixelcloud_3.png");
  cloud5.resize(60, 0);
  cloud6 = loadImage("./images/pixelcloud_3.png");
  cloud6.resize(60, 0);
}

void loadFish() {
  // Fish 1: Clownfish
  PImage fishImage = loadImage("./images/fish/1.PNG");
  fishImage.resize(64, 0);
  fish[0] = new Fish(5, "Clownfish", fishImage, 15);

  // Fish 2: Salmon
  fishImage = loadImage("./images/fish/2.PNG");
  fishImage.resize(64, 0);
  fish[1] = new Fish(10, "Salmon", fishImage, 5);

  // Fish 3: Blue tang
  fishImage = loadImage("./images/fish/3.PNG");
  fishImage.resize(64, 0);
  fish[2] = new Fish(5, "Blue tang", fishImage, 10);

  // Fish 4: Eel
  fishImage = loadImage("./images/fish/4.PNG");
  fishImage.resize(64, 0);
  fish[3] = new Fish(10, "Eel", fishImage, 5);

  // Fish 5: Catfish
  fishImage = loadImage("./images/fish/5.PNG");
  fishImage.resize(64, 0);
  fish[4] = new Fish(8, "Catfish", fishImage, 10);

  // Fish 6: Shrimp
  fishImage = loadImage("./images/fish/6.PNG");
  fishImage.resize(64, 0);
  fish[5] = new Fish(3, "Shrimp", fishImage, 10);

  // for each fish in fish array, add r fish (r=rarity count) to fishInTheSea
  for (int i = 0; i < fish.length; i++) {
    for (int j = 0; j < fish[i].rarity; j++) {
      fishInTheSea.add(fish[i]);
    }
  }
}

void checkBounds() {
  // move clouds/fish to opposite side of the screen once they move out of the window
  if (x1 < -128)
    x1 = 600;
  if (x2 < -128)
    x2 = 600;
  if (x3 < -128)
    x3 = 600;
  if (x4 < -128)
    x4 = 600;
  if (x5 < -128)
    x5 = 600;
  if (x6 < -128)
    x6 = 600;
  if (fish1 > 600)
    fish1 = -64;
  if (fish2 > 600)
    fish2 = -64;
  if (fish3 > 600)
    fish3 = -64;
}

void mousePressed() {
  // lower button: main menu 1 -> quit, main menu 2 -> hard difficulty
  if (game.isMainMenu1 || game.isMainMenu2) {
    if (mouseX > 160 && mouseX < 430 && mouseY > 370 && mouseY < 430) {
      click.play(); 
      if (game.isMainMenu1) {
        exit(); 
      } else if (game.isMainMenu2) {
        game.difficulty = 2;
        game.isMainMenu2 = false;
        game.isPrologue = true;
      }
     }
     // upper button: main menu 1 -> start, main menu 2 -> normal difficulty
     if (mouseX > 160 && mouseX < 430 && mouseY > 242 && mouseY < 314) {
       click.play(); 
       if (game.isMainMenu1) {
         game.isMainMenu1 = false;
         game.isMainMenu2 = true;
       } else if (game.isMainMenu2) {
        game.difficulty = 1;
        game.isMainMenu2 = false;
        game.isPrologue = true; 
       }
     }
     return;
  }
  if (game.isPrologue) {
    if (mouseX > 510 && mouseX < 587 && mouseY > 32 && mouseY < 52) {
      game.isPrologue = false; 
      game.isFishing = true; 
    }
    return;
  }
  if (game.isFishing) {
    if (player.cast == false) {
      startCastAnimation(); 
      player.cast = true; 
    }
    else {
      player.cast = false; 
      // Trigger mini game to catch the fish:
      game.isMiniGame = true;
      game.isFishing = false;

    }
    updatePlayer(); 
    return;
  }
  if (game.isMiniGame) {
    if (player.caught == true) {
      // If player selects continue after catching a fish
      if (mouseX >= 219 && mouseY >= 379 && mouseX <= 379 && mouseY <= 419) {
        game.isMiniGame = false;
        player.caught = false; 
      }

    }
    if (ballX >= 250 && ballY >= 270 && ballX <= 350 && ballY <= 330) {
      print("Success");
      generateFish();
      player.caught = true;
      displayFish();
    } else {
      print("Failed");
      game.isMiniGame = false;
      game.isFishing = true;
    }
  }
}

void drawFishing() {
  image(fishingBackground, 0, 0);
  updatePlayer(); 
}

void drawPrologue() {
  background(255); 
  text("Prologue here", width/2, height/2);
  imageMode(CORNER); 
  textSize(20); 
  text("skip", width - 50, 50); 
}

// Declare variables to keep track of time
int castStartTime = 0;
int castDuration = 800; // 800 milliseconds
int waterDriftDuration;
boolean driftBool = true;
int bite = castStartTime + (int)random(2000, 10000);

void updatePlayer() {
  PImage cast = loadImage("images/Cast.PNG"); 
  PImage idle = loadImage("images/fishing1.PNG"); 
  PImage idle2 = loadImage("images/fishing2.PNG");
  PImage rest = loadImage("images/resting.PNG"); 
  PImage nibble = loadImage("images/nibble.PNG"); 
  cast.resize(600, 0);
  rest.resize(600, 0);
  idle.resize(600, 0); 
  idle2.resize(600, 0); 
  nibble.resize(600, 0); 

  if (player.cast) {
    
    // Check if the cast animation has just started
    if (millis() - castStartTime < castDuration) {
      image(cast, player.x, player.y); 
    } else {
      // If more than 1 second has passed, switch to idle animation
      // Nibble can occur randomly now
       
      println("bite: " + bite); 
      if (millis() == bite || ((millis() > bite) && (millis() < bite+1000))) {
        player.nibble = true; 
        image(nibble, player.x, player.y); 
      }
      else {
        player.nibble = false; 
        if (millis() > waterDriftDuration) {
          driftBool = !driftBool;
          waterDriftDuration = millis() + 1000;
        }
        if (driftBool) {
          image(idle, player.x, player.y);
        } else {
          image(idle2, player.x, player.y);
        }
      }
    }
  }
  
  else {
    image(rest, player.x, player.y); 
  }
}

// Call this function when starting the cast animation
void startCastAnimation() {
  castStartTime = millis();
  bite = castStartTime + (int)random(2000, 10000);
  
}

void keyPressed() {
  if (key == 'M' || key == 'm') {
    println("m pressed");
    println(game.isShopping); 
    if (game.isShopping) {
      game.isShopping = false; 
    }
    else {
      game.isShopping = true; 
    }
  }
}

int ballX = (int)random(150, 435);
int ballY = (int)random(150, 435);
boolean NE, NW, SW = false; // Directions: Northeast, Northwest, etc.
boolean SE = true;

void drawMiniGame() {
  image(miniGameBackground, 150, 150);
  image(miniGameBall, ballX, ballY);

  if (SE) {
   ballX++;
    ballY += 2;
    if (ballY >= 433) {
      SE = false;
      NE = true;
    } else if (ballX >= 433) {
      SE = false;
      SW = true;
    }
  } else if (NE) {
    ballX++;
    ballY -= 2;
    if (ballX >= 433) {
      NE = false;
      NW = true;
    } else if (ballY <= 151) { 
      NE = false;
      SE = true;
    }
  } else if (NW) {
    ballX--;
    ballY -= 2;
    if (ballY <= 151) {
      NW = false;
      SW = true;
    } else if (ballX <= 151) {
      NW = false;
      NE = true;
    }
  } else if (SW) {
    ballX--;
    ballY += 2;
    if (ballX <= 151) {
      SW = false;
      SE = true;
    } else if (ballY >= 433) {
      SW = false;
      NW = true;
    }
  } 
}

void drawMarket() {
  image(marketBackground, 0, 0); 
  joe.resize(200, 0); 
  image(joe, 380, 177); 
}

PImage currCatch;
String currName;
// Only generate the fish once
void generateFish() {
  int fishNum = (int)random(0, fishInTheSea.size());
  Fish caughtFish = fishInTheSea.get(fishNum);
  PImage img = caughtFish.sprite;
  img.resize(128, 128);
  currCatch = img;
  currName = caughtFish.name;
  print("Caught: " + caughtFish.name);
  player.inventory.add(caughtFish);
}

// Generate and display random fish, add to the inventory
void displayFish() {
  image(backgroundForDisplay, 150, 150);

  imageMode(CENTER);
  image(currCatch, 300, 300);
  PImage button = plankButton;
  button.resize(175, 0);
  image(plankButton, 300, 400);

  fill(#044d57);
  textFont(casualFont);
  textSize(10);
  textAlign(CENTER);
  text("You caught a " + currName + "!", 300, 250);
  if (mouseX >= 219 && mouseY >= 379 && mouseX <= 379 && mouseY <= 419) {
    fill(255); 
  }
  textSize(14);
  text("Continue", 300, 405);
  imageMode(CORNER);
}
