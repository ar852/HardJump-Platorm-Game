 static final int numTokens = 13;
//YOU CAN CHANGE THIS IF YOU WANT
public static final int  rowCol = 6; //number of rows and columns
// YOU CAN CHANGE THIS FOR HARDER OR EASIER GAMEPLAY; HIGHER NUMBER = EASIER

// Player 1 and 2 Image paths (Add to Data folder)
String img1_path = "steve.png";
String img2_path = "girl.png";


Characters a = new Characters (20, height-20, 0, 0, 0, false);
CharacterB b = new CharacterB (710, height-20, 0, 0, 0, false);

import ddf.minim.*;
Minim minim;
AudioPlayer tokenSound, jumpSound, hitSound, backgroundMusic, playingMusic;

int numplatforms;
Platform[] Platforms = new Platform[numplatforms];
PImage img1;
PImage img2;
PImage img3;

boolean onHomeScreen = true;
int playing = 0;
boolean finished = false;
boolean alreadyFormatted = false;
PFont Font;
String begin = "BEGIN!";
boolean was2player = false;

boolean tie;
char winner;
char loser;
color winnerColor;
color loserColor;


int pixAddY;
int pixAddX;

int tokenSize = 20;
Token[] manyTokens = new Token[numTokens];

void setupTokens(){
  int randPlat; //random platform
  
  for(int i=0; i<manyTokens.length; i++){
    randPlat = (int) random(0,Platforms.length);
    manyTokens[i] = new Token(0, 0, tokenSize, 'T');
    manyTokens[i].beOnPlat(Platforms[randPlat]);
    
    while(
    Platforms[randPlat].hasToken == true //if the platform is already full or token is on screen
    ||
    Platforms[randPlat].yTopLeft-30 < 0
    || 
    manyTokens[i].xPos > width
    ||
    manyTokens[i].yPos > height
    )
    {
      randPlat = (int) random(0,Platforms.length);
      manyTokens[i].beOnPlat(Platforms[randPlat]); //make token on a different radnom platform until its valid
      println("overlap"); 
    } 
    Platforms[randPlat].hasToken = true;    
    println("(" + manyTokens[i].xPos + "," + manyTokens[i].yPos + ")");
    
  }   
}
  
void displayTokens(){
  for(int i=0; i<manyTokens.length; i++){
    manyTokens[i].display();
  }
}

boolean tokenLimitReached(){
  return (a.tokenCounter + b.tokenCounter == numTokens);
}


void setup ()
{
  pixAddX = width/rowCol;  //pixels wide per grid
  pixAddY = height/rowCol;  //pixels high per grid
  numplatforms = rowCol * rowCol;
  Platforms = new Platform[numplatforms];
  size (750,750);
  Platforms[0] = new Platform(10, width+200, height+200);
  Platforms[0].gridSetup(pixAddX, pixAddY); //doesnt matter since it sets up all
  setupTokens();
  img1= loadImage(img1_path);
  img2 = loadImage(img2_path); 
  img3 = loadImage("Homescreen.png");
  
  minim = new Minim(this);
  tokenSound = minim.loadFile("Coin.wav");
  jumpSound = minim.loadFile("jumping.wav");
  backgroundMusic = minim.loadFile("BackgroundMusic.mp3");
  playingMusic = minim.loadFile("playingMusic405.mp3");
  
  backgroundMusic.setGain(-10);
  tokenSound.setGain(1);
  jumpSound.setGain(1);
  
  System.out.println(backgroundMusic.getGain());
  System.out.println(tokenSound.getGain());
  System.out.println(jumpSound.getGain());
  
  Font = createFont("GenghisKhan.otf", 100);
  
  
}


void keyPressed()
{ 
  if (a.onplatformornot())
  {
    if (key == 'w')
    {
      a.upbooleantrue();
    }
    if (key == 'a')
    {
      a.leftbooleantrue();
    }  
    if (key == 'd')
    {
      a.rightbooleantrue();
    }
  }
  if (b.onplatformornot())
  {
    if (keyCode == UP)
    {
      b.upbooleantrue();
    }
    if (keyCode == LEFT)
    {
      b.leftbooleantrue();
    }  
    if (keyCode == RIGHT)
    {
      b.rightbooleantrue();
    }
  }
  
  if (onHomeScreen && keyCode == '1'){ //1 player mode
    onHomeScreen = false;
    playing = 1;
    was2player = false;
    finished = false;
  }
  
  if (onHomeScreen && key == '2'){ //2 player mode
    onHomeScreen = false;
    playing = 2;
    was2player = true;
    finished = false;
  }
  
  if((playing == 1 || playing ==2 ) && (key == 'f' || key == 'F')){
    playing = 0;
    onHomeScreen = false;
    finished = true;
  }
  if(key =='r' || key == 'R'){
    playing = 0;
    finished = false;
    onHomeScreen = true;
    alreadyFormatted = false;
  }
}

void keyReleased()
{
  if (key == 'w')
  {
    a.upbooleanfalse();
  }
  if (key == 'a')
  {
    a.leftbooleanfalse();
  }
  if (key == 'd')
  {
    a.rightbooleanfalse();
  }
  if (keyCode == UP)
  {
    b.upbooleanfalse();
  }
  if (keyCode == LEFT)
  {
    b.leftbooleanfalse();
  }
  if (keyCode == RIGHT)
  {
    b.rightbooleanfalse();
  }

}


void draw ()
{

  
  //while on homescreen, display a certain text and a start game button
  if(onHomeScreen){
    backgroundMusic.setGain(-10);
    if(!backgroundMusic.isPlaying()){
      backgroundMusic.loop();
    }
    backgroundMusic.play();
    if(! alreadyFormatted){
      Platforms[0].gridSetup(pixAddX, pixAddY); //it doesnt matteer which platform its called for since the method sets up all
      setupTokens();
      a.x = 20;
      b.x = 710;
      a.y = 720;
      b.y = 720;
      a.tokenCounter = 0;
      b.tokenCounter = 0;
      alreadyFormatted = true;
    }
    image(img3, 0, 0, width, height);
    
    fill(#0000FF, 30);
    rect(0, 0, width/2, height);
    fill(#FF0000, 30);
    rect(width/2, 0, width/2, height);
    
    fill(#6D0FF3);
    textAlign(CENTER, CENTER);
    textFont(Font);
    textSize(100);
    text("HardJump", width/2, 150);
    strokeWeight(7);
    
    line(width/2 - 200, 150+50, width/2 + 180, 150+50);
    textSize(90); 
    text("WELCOME", width/2, height/2);
    textSize(25);
    text("Press 1 for one player and 2 for two player mode", width/2, height/2+120);
    strokeWeight(1);
    
  }
  
  
  //Meat of the game 2 player mode
  if(playing == 2){
    //backgroundMusic.shiftGain(backgroundMusic.getGain(),-50, 700);
    backgroundMusic.shiftGain(backgroundMusic.getGain(), -46, 1000);

    background(255);
    
    for (int i=0; i<Platforms.length; i++)
    {
      Platforms[i].display();
    }
    displayTokens();
    a.exist();
    b.exist();
    a.overlappingb();
    
    if(tokenLimitReached()){
      playing = 0;
      finished = true;
    }
  }
  
  if(playing == 1){ //meat of the game single player
    backgroundMusic.shiftGain(backgroundMusic.getGain(),-40, 1000);
    background(255);
    
    for (int i=0; i<Platforms.length; i++)
    {
      Platforms[i].display();
    }
    displayTokens();
    a.exist();
    
    if(tokenLimitReached()){
      playing = 0;
      finished = true;
    }
  }
  
  //EndSCREEN stuff
  if(finished){
    if(!backgroundMusic.isPlaying()){
      backgroundMusic.loop();
    }
    backgroundMusic.shiftGain(backgroundMusic.getGain(),-10, 210);
    background(255);
    textSize(100);
    fill(0);
    text("GAME OVER!", width/2, 125);
    if(was2player){
      if(a.tokenCounter > b.tokenCounter){
        winner = 'A';
        loser = 'B';
        winnerColor = #0000FF;
        loserColor = #FF0000;
        tie = false;
      }
      if(a.tokenCounter == b.tokenCounter){
        tie = true;
      }
      if (b.tokenCounter > a.tokenCounter){
        winner = 'B';
        loser = 'A';
        winnerColor = #FF0000;
        loserColor = #0000FF;
        tie = false;
      }
      if (!tie){
        textSize(40);
        fill(winnerColor);
        text("The Winner is Player: "+winner, width/2, height/2-100);
        fill(loserColor);
        text("The Loser is Player: "+loser, width/2, height/2+75);
      }
      else{
      textSize(40);
        fill(#FF00FF);
        text("It was a Tie!", width/2, height/2-100);
        fill(loserColor);
      }  
      fill(0);
      text("Press R to Restart", width/2, height-200);
    }
    else{ //if it was 1 player
      backgroundMusic.shiftGain(backgroundMusic.getGain(),-10, 210);
      background(255);
      textSize(100);
      fill(0);
      text("GAME OVER!", width/2, 125);
      textSize(40);
      fill(#0000FF);
      text("You Scored: " + a.tokenCounter, width/2, height/2-100);
      fill(0);
      text("Press R to Restart", width/2, height-200);
    }
  }
  

  

  
}
