public class Balloon {
  
  int health;
  int curX, curY;
  color c;
  
  Balloon(int health, int curX, int curY){
    this.health = health;
    this.curX = curX * 50;
    this.curY = curY * 50;
    c = color(255,0,0);
  }
  
  void display(){
    smooth();
    fill(c);
    ellipse(curX, curY, 30, 40);
  }
  
}
