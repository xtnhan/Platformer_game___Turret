class EnemyBullet {
  float s;

  PVector direction;


  PVector position;
  PVector velocity;
  PVector speedY;


  boolean isHitBlock;


  float blockDamage;
  float playerDamage;


  EnemyBullet (PVector pos, PVector vel, PVector speedYY) {
    position = pos;
    velocity = vel;
    speedY = speedYY;
    isHitBlock = false;


    s = 5;
  }


  EnemyBullet (PVector pos, PVector vel) {
    position = pos;
    velocity = vel;
    speedY = new PVector (0, 0);
    s = 6;

    blockDamage = 1;
    //playerDamage = 2.5;
    direction = new PVector (0, 0);
  }

  void draw () {
    fill(255, 0, 0);
    strokeWeight(0);

    circle(position.x, position.y, s);
  }

  void update () {
    position.add(velocity);

    if (isHitBlock) {
      //Add gravity
      speedY.add(grav).div(70);
      velocity.add(speedY);
    }


    if (position.y > height - s - 100) {
      position.x = 999999;  //Hide bullet when getting out of the screen
    }
  }
  void interaction () {
    
    
    //Player
    if (dist (position.x, position.y, p.x, p.y)<= p.r) {
      p.healthbar -= playerDamage;
      position.x = 9999999; //Hide bullets when player is hit
    }

//BLocks
    //Add bounce back left
    for (Block bl : blocks) {

      if (position.x + s >= bl.x - bl.w/2 && position.x - s <= bl.x + bl.w/2 && position.y + s >= bl.y - bl.h/2 && position.y - s <= bl.y + bl.h/2) {//HIT BLOCk
        isHitBlock = true;
        if (bl.hasTurret ==false) {
          bl.healthbar -= blockDamage;
        }
        if (position.y - s <= bl.y - bl.h/2 - s) {//Hit Top
          position.y = bl.y - s - bl.h/2;
          velocity.y = -velocity.y/1.5;
        }

        if (position.y + s >= bl.y + bl.h/2 + s) {//Hit Bottom
          position.y = bl.y + s + bl.h/2;
          velocity.y = -velocity.y/1.5;
        }

        if (position.x + s >= bl.x + bl.w/2 && position.y - s >= bl.y - bl.h/2 - s) {//Hit Right
          position.x = bl.x + bl.w/2 + s + 10;
          velocity.x = -velocity.x/1.5;
        }

        if ( position.x - s <= bl.x - bl.w/2 && position.y - s >= bl.y - bl.h/2 - s) {//Hit Left
          position.x = bl.x - bl.w/2 - s - 10;
          velocity.x = -velocity.x/1.5;
        }
      }
    }
  }


  void move (float dx, float dy) {
    position.x = position.x + dx;
    position.y = position.y + dy;
  }
}
