public class Balloon {
  
  int health;
  int curX, curY;
  int speed;
  color c;
  //ArrayList<int[]> visitedPatches = new ArrayList<int[]>();
  
  Balloon(int health, double curX, double curY){
    this.health = health;
    this.curX = (int) (curX * 50);
    this.curY = (int) (curY * 50);
    c = color(255,0,0);
    speed = 2;
  }
  
  void move(int x, int y){
    curX += x * speed;
    curY += y * speed;
  }
  
  //void patchVisited(int[] arr) {
  //  visitedPatches.add(arr);
  //}
  
  void display(){
    smooth();
    fill(c);
    ellipse(curX, curY, 30, 40);
  }
  
}
