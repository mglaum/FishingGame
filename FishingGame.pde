PImage mainMenuBackground;

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
   
}

void draw() {
    drawMainMenu(); 
}

void drawMainMenu() {
  mainMenuBackground = loadImage("./images/MainMenuBackground.png");
  image(mainMenuBackground, 0, 0); 
}
