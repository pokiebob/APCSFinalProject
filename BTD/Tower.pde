public class Tower {
  
  int cost;
  int damage;
  int range;
  int bulletVelocity;
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

  

}
