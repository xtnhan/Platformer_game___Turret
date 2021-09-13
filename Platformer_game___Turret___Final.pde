float gravity = 0.4;
float obspeedX = 7; //Speed of all the objects in this game
float BgQuantity = 1;
float BgX = 2404;
float w;

ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<EnemyBullet> ebullets = new ArrayList<EnemyBullet>();
ArrayList<TargetTurret> tt1 = new ArrayList<TargetTurret>();
ArrayList<Mushroom> mushrooms = new ArrayList<Mushroom> ();


ArrayList<BG1> bgr1 = new ArrayList<BG1> ();
ArrayList<BG1> bgrL = new ArrayList<BG1> ();
ArrayList<Mushroom> mushroomsL = new ArrayList<Mushroom> ();

ArrayList<BG1> bgrR = new ArrayList<BG1> ();
ArrayList<Mushroom> mushroomsR = new ArrayList<Mushroom> ();




PVector target;
PVector grav = new PVector (0, gravity);

Player p;
checkPoint c;

//Background Loading
loadBGTrigger triggerL;
loadBGTrigger triggerR;


PImage bg;
PImage bl;
PImage mushroom;


int material = 100;
int ammo = 400;

boolean runOutMaterial = false;
boolean runOutAmmo = false;
boolean mouseHold = false;

//Background Loading
float BGnumberLeft;
float BgLeftPos;
float BGnumberRight;
float BgRightPos;

void setup() {
  size(1920, 800);
  ellipseMode(RADIUS);
  rectMode(CENTER);

  bg = loadImage("bg.png");
  bl = loadImage("bl.jpg");
  mushroom = loadImage("mushroom.png");

  p = new Player (width/3, height -300);
  c = new checkPoint(0, 700);


  //Background Loading
  triggerL = new loadBGTrigger (width-10, 700, 255, 255, 0);
  triggerR = new loadBGTrigger (10, 700, 255, 0, 0);




  blocks.add(new Block (1900, height - 200, 50, 50, true));

  tt1.add(new TargetTurret (1800, 100));
  tt1.add(new TargetTurret (2600, 100));
  tt1.add(new TargetTurret (1900, 200));
  tt1.add(new TargetTurret (2500, 200));
  tt1.add(new TargetTurret (2000, 300));
  tt1.add(new TargetTurret (2400, 300));

  target = new PVector (width/2, height/2);


  bgr1.add(new BG1 (0)); //Original BG
}

void draw() {
  //background(255, 255, 255);
  //translate (width/3, height/3);
  //scale(0.3);



  if (mushrooms.size() <= 10) {
    for (int i = 0; i <= 2404; i+= random (100, 150)) {
      mushrooms.add(new Mushroom (i, random(600, 650)));
    }
  }

  //Background drawing

  for (BG1 bgr1 : bgr1) {//Original Background
    bgr1.draw();
  }

  for (BG1 bgrR : bgrR) {//Background Right
    bgrR.draw();
  }
  for (BG1 bgrL : bgrL) { //Background Left
    bgrL.draw();
  }



  //triggerL.draw();
  //triggerR.draw();
  //c.draw();



  //Mushroom drawing

  for (Mushroom mr : mushrooms) {
    mr.draw();
  }
  for (Mushroom mrL : mushroomsL) {
    mrL.draw();
  }

  for (Mushroom mrR : mushroomsR) {
    mrR.draw();
  }
  p.draw();
  p.update();
  p.updateTurret();
  for (Block b : blocks) {
    b.draw();
    b.update();
    b.interaction();
  }



  //Turret drawing
  for (TargetTurret tt : tt1) {
    tt.draw();
    tt.update();
    tt.PlayerDetected();
  }

  update();

  println("Player's bullets:" + bullets.size()
    + "|| Enemy's bullets: " + ebullets.size() + "|| Number of blocks: " + blocks.size()
    + "|| Left Backgrounds Created: " + bgrL.size()+ "|| Right Backgrounds Created: "
    + bgrR.size()+ "|| Mushrooms Created Left: " +mushroomsL.size()+ "|| Mushrooms Created Right: " +mushroomsR.size());
}




void update() {

  //INFINITE BACKGROUND & ITEMS LOADING

  if (triggerL.x > width) {//LEFT
    triggerL.x = 0;
    BGnumberLeft +=1;
    BgLeftPos += 2404;
    if (bgrL.size() <= BGnumberLeft) {
      bgrL.add(new BG1 (-(BgLeftPos-c.x)));

      for (float i = 0; i >= -(BgLeftPos-c.x); i-= random (50, 100)) {
        mushroomsL.add(new Mushroom (i, random(600, 650)));
      }
    }
  }


  //Clear mushrooms from previous Backgrounds
  if (BGnumberLeft >1) {
    mushroomsR.clear();
    ebullets.clear();
  }
  if (BGnumberRight >2) {
    mushroomsL.clear();
    ebullets.clear();
  }


  if (triggerL.x <0 && bgrL.size() >= 1) {
    triggerL.x = width;
    BGnumberLeft -=1;
    BgLeftPos -= 2404; //Reset to previous position
    bgrL.remove(bgrL.size()-1);
    //mushroomsL.clear();
  }



  if (triggerR.x < 0) {  //RIGHT

    triggerR.x = width;
    BGnumberRight +=1;
    BgRightPos -= 2404;

    if (bgrR.size() <= BGnumberRight) {
      bgrR.add(new BG1 (-(BgRightPos-c.x)));

      for (float i = 2404; i <= -(BgRightPos-c.x) + 2404; i+= random (100, 150)) {
        mushroomsR.add(new Mushroom (i, random(600, 650)));
      }
    }
  }

  if (triggerR.x > width && bgrR.size() >= 1) {
    triggerR.x = 0;
    BGnumberRight -=1;
    BgRightPos += 2404; //Reset to previous position
    bgrR.remove(bgrR.size()-1);
  }
  //END INFINITE BACKGROUND



  if (p.isAlive&& key =='d') {

    p.moveRight();
    p.checkWalls ();
  } else {
  }
  if (p.isAlive && key == 'a') {
    p.moveLeft();
    p.checkWalls ();
  } else {
  }



  //Remove Bullet - condition
  if (bullets.size() >= 400) { // Bug - Lag - Fixed
    removeBulletPlayer();
  }

  if (ebullets.size() >= 400) { // Bug - Lag - Fixed
    removeBulletEnemy();
  }

  //Remove blocks

  if (blocks.size()>=200) {
    blocks.remove(blocks.size()-199); //Remove the first item
  }

  //Information board
  if (p.hasTurret) {
    rectMode(CORNER);
    fill(0, 0, 0);
    rect(110, 20, w, 50);
    textSize(30);
    textMode(CORNER);
    fill(255, 255, 0);
    text ("Building material: " + material + "               Ammo: " + ammo, 110, 55);

    if (p.isAlive == false ) {
      textMode(CORNER);
      text ("Press 'R' to play again", 700, 55);
      w = 1000;
    } else {
      w = 550;
    }
  }
  if (material <=0 ) {
    runOutMaterial = true;
    material = 0;
  } else {
    runOutMaterial = false;
  }

  if (mouseHold && runOutAmmo == false) {
    p.shoot();
    ammo -=1;
  }

  if (ammo <=0 ) {
    runOutAmmo = true;
    ammo = 0;
  } else {
    runOutAmmo = false;
  }
}
//END information board

void keyPressed () {

  if (key == ' ' && p.isGround) { //Jump
    p.jumpUp();
  }

  if (key == 'c' && p.hasTurret) {
    for (Block b : blocks) {
      if (b.hitTop) {
        b.y += 20;
      }
    }
  }

  if (key == 'w' && p.hasTurret) {
    for (Block b : blocks) {
      if (b.hitTop) {
        b.y -= 10;
      }
    }
  }

  if (p.isAlive ==false &&key == 'r') {
    reset();
  }
}


void removeBulletPlayer() {
  for (int i = bullets.size()- 199; i >= 99; i-=1) { // Bug - Lag - Fixed
    bullets.remove(i);
  }
}
void removeBulletEnemy() {
  for (int i = ebullets.size()- 199; i >= 99; i-=1) { // Bug - Lag - Fixed
    ebullets.remove(i);
  }
}



void mousePressed () {

  for (Mushroom mr : mushrooms) {
    if (runOutAmmo && dist(p.x, p.y, mr.x, mr.y) < 100) {

      if (dist(mouseX, mouseY, mr.x, mr.y) < mr.r) {
        mr.isHit = true;
        mr.healthbar -= 1.5;
      }
    }
  }
  for (Mushroom mr : mushroomsL) {
    if (runOutAmmo && dist(p.x, p.y, mr.x, mr.y) < 100) {

      if (dist(mouseX, mouseY, mr.x, mr.y) < mr.r) {
        mr.isHit = true;
        mr.healthbar -= 1.5;
      }
    }
  }

  for (Mushroom mr : mushroomsR) {
    if (runOutAmmo && dist(p.x, p.y, mr.x, mr.y) < 100) {

      if (dist(mouseX, mouseY, mr.x, mr.y) < mr.r) {
        mr.isHit = true;
        mr.healthbar -= 1.5;
      }
    }
  }


  if (mouseButton == LEFT && p.hasTurret) {
    mouseHold = true;
  }

  if (mouseButton == RIGHT && p.hasTurret && runOutMaterial == false) {

    material -= 2;
  }


  if (mouseButton == RIGHT && mouseX > p.x && p.hasTurret && runOutMaterial == false) {
    for (int i = 50; i <=150; i+=50) {
      blocks.add(new Block (p.x + i, p.y, 50, 50, false));
    }
  }

  if (mouseButton == RIGHT && mouseX <  p.x && p.hasTurret && runOutMaterial == false) {
    for (int i = -50; i >=-150; i-=50) {
      blocks.add(new Block (p.x +  i, p.y, 50, 50, false));
    }
  }
}


void mouseReleased () {
  mouseHold = false;
}

void mouseWheel() { //Add walls

  if (p.hasTurret && runOutMaterial == false) {

    material -= 2;
  }

  for (int i = 0; i >=-100; i-=50) {
    if (mouseX > p.x && p.hasTurret && runOutMaterial == false) {
      blocks.add(new Block (p.x + 50, p.y  +  i, 50, 50, false));
    }

    if (mouseX < p.x && p.hasTurret && runOutMaterial == false) {
      blocks.add(new Block (p.x - 50, p.y  +  i, 50, 50, false));
    }
  }
}

void reset () {
  p.isAlive = true;
  p.healthbar = 50;
  p.speedY = 0;
  p.y = 500;
  material = 100;
  ammo = 30;
  bullets.clear();
  ebullets.clear();
}
