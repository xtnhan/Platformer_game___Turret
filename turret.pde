class Turret {
  PVector position;
  PVector gun;

  float r;



  Turret (float xx, float yy) {

    position = new PVector(xx, yy);
    gun = new PVector (0, 0);


    r =15;
  }

  void draw () {

    if (p.hasTurret) {
      gun = new PVector (mouseX - position.x, mouseY - position.y);
      gun.normalize().mult(30);
    }

    fill(255, 255, 0);

    circle(position.x, position.y, r);

    strokeWeight(4);
    line(position.x, position.y, position.x + gun.x, position.y + gun.y);
    strokeWeight(1);


  }
}
