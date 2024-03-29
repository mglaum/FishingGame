// Array of all fish in the game
Fish[] fish = new Fish[3]; // Update size as fish are added

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
    plankButton = loadImage("./images/button.PNG");
    plankButton.resize(300, 0);
    loadClouds();
    loadFish();
}

void draw() {
    drawMainMenu(); 
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
  imageMode(CORNER);
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
  text("Start", 300, 285);
  text("Quit", 300, 410);

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
