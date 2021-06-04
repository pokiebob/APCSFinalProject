public class Tower {
  
  int cost;
  int damage;
  int range;
  double speed;
  double timer;
  color c;
  int x, y;
  boolean canShoot;
  
  Tower(int x, int y) {
    cost = 200;
    damage = 1;
    range = 175;
    speed = 0.45;
    timer = speed;
    c = color(175, 100, 0);
    this.x = x * 50;
    this.y = y * 50;
    canShoot = true;
  }
  
  void drag() {
    x = mouseX;
    y = mouseY;
  }
  
  void display() {
    //noStroke();
    smooth();
    fill(c);
    ellipse(x, y, 50, 50);
  }

  

}
