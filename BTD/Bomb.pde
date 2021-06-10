public class Bomb extends Bullet {

  Bomb(int damage, int speed, int range, int curX, int curY, int direction, int splashRadius) {
    super(damage, speed, range, curX, curY, direction, 1);
    name = "bomb";
    this.splashRadius = splashRadius;
  }
  
  void display() {
    fill(0);
    stroke(255,0,0);
    ellipse(curX, curY, 30, 30);
    noStroke();
  }
  
}
