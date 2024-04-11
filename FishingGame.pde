import processing.sound.*;
SoundFile click;
// Array of all fish in the game
Fish[] fish = new Fish[6]; // Update size as fish are added
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

// Class to handle game statesa
class Game {
  int difficulty; // 1 = Normal, 2 = Hard
  boolean isMainMenu1; // game state 1: start or quit
  boolean isMainMenu2; // game state 2: select difficulty
  boolean isPrologue; // game state 3: prologue
  boolean isFishing; // game state 4: fishing
  boolean isShopping; // game state 5: shopping in market
  boolean isVictorious; // game state 6: end credits
  Game() {
    isMainMenu1 = true;
    isMainMenu2 = false;
    isPrologue = false;
    isFishing = false;
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
    rarity = r; 
  }
}
class Player {
  boolean cast; 
  int x; 
  int y; 
  Player() {
    cast = false; 
    x = 0; 
    y = 0; 
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
    loadClouds();
    loadFish();
     click = new SoundFile(this, "./audio/button_sound.mov");
}

void draw() {
  println("x: " + mouseX); 
  println("y: " + mouseY); 
  if (game.isMainMenu1 || game.isMainMenu2) {
    drawMainMenu(); 
  } else if (game.isPrologue) {
    drawPrologue(); 

  } else if (game.isFishing) {
    drawFishing();
  } else if (game.isShopping) {

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
  
  // TODO: use random int to select a fish from the fish array
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
  for (int i = 1; i <= fish.length; i++) {
    String name = "./images/fish/" + str(i) + ".PNG";
    PImage fishImage = loadImage(name);
    fishImage.resize(64, 0);
    fish[i-1] = new Fish(3, "Temp Name", fishImage, 0.10);
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
  }
  if (game.isPrologue) {
    if (mouseX > 510 && mouseX < 587 && mouseY > 32 && mouseY < 52) {
      game.isPrologue = false; 
      game.isFishing = true; 
    }
  }
  if (game.isFishing) {
    if (player.cast) {
      startCastAnimation(); 
      player.cast = false; 
    }
    else {
      player.cast = true; 
    }
    updatePlayer(); 
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
  //image(plankButton, 400, 10);
  textSize(20); 
  
  text("skip", width - 50, 50); 
}

// Declare variables to keep track of time
int castStartTime = 0;
int castDuration = 1000; // 1 second in milliseconds

void updatePlayer() {
  PImage cast = loadImage("images/Cast.PNG"); 
  PImage idle = loadImage("images/fishing1.PNG"); 
  PImage rest = loadImage("images/resting.PNG"); 
  cast.resize(600, 0);
  rest.resize(600, 0);
  idle.resize(600, 0); 

  if (player.cast) {
    // Check if the cast animation has just started
    if (millis() - castStartTime < castDuration) {
      image(cast, player.x, player.y); 
    } else {
      // If more than 1 second has passed, switch to idle animation
      image(idle, player.x, player.y);
    }
  }
  else {
    image(rest, player.x, player.y); 
  }
}

// Call this function when starting the cast animation
void startCastAnimation() {
  castStartTime = millis(); 
  player.cast = true; // Assuming player.cast is a boolean variable indicating if the player is casting
}
