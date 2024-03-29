PImage mainMenuBackground;

void setup() {
    size(600,600);
    mainMenuBackground = loadImage("./images/MainMenuBackground.png");
}

void draw() {
    image(mainMenuBackground, 0, 0);
}
