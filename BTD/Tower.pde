public class Tower {
  
  int cost;
  int damage;
  int range;
  int bulletVelocity;
  int splashRadius;
  int level;
  int sharpness;
  int upgradeCost;
  double speed;
  double timer;
  color c;
  int x, y;
  boolean canShoot;
  String name;
  
  Tower(int x, int y) {
    cost = 200;
    damage = 1;
    range = 175;
    speed = 0.9;
    timer = speed;
    bulletVelocity = 15;
    splashRadius = 1;
    level = 1;
    sharpness = 1;
    upgradeCost = 300;
    c = color(175, 100, 0);
    this.x = x * 50;
    this.y = y * 50;
    canShoot = true;
    name = "Dart Monkey";
  }
  
  void drag() {
    x = mouseX;
    y = mouseY;
  }
  
  void display() {
    //noStroke();
    stroke(0);
    smooth();
    fill(c);
    ellipse(x, y, 50, 50);
    noStroke();
  }

  void upgrade(){
    if (level == 1) {
      level = 2;
      sharpness++;
      range = 200;
      upgradeCost = 400;
    }
    else if (level == 2) {
      level = 3;
      sharpness++;
      range = 225;
      upgradeCost = 500;
    }
    else if (level == 3) {
      level = 4;
      sharpness++;
    }
  }

}
