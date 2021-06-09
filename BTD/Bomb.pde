public class Bomb extends Bullet {
 
  Bomb(int damage, int speed, int range, int curX, int curY, int direction) {
    super(damage, speed, range, curX, curY, direction);
  }
  
  void display() {
    fill(255);
    stroke(255,0,0);
    ellipse(curX, curY, 30, 30);
    noStroke();
  }
  
}
