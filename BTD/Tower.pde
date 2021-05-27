public class Tower {
  
  int cost;
  int damage;
  int range;
  int speed;
  color c;
  float x, y;
  
  Tower(int x, int y) {
    cost = 200;
    damage = 1;
    range = 124;
    c = color(175, 100, 0);
    this.x = x * 50;
    this.y = y * 50;
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
