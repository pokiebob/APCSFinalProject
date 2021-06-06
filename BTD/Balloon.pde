public class Balloon {
  
  int health;
  int curX, curY;
  double speed;
  color c;
  //ArrayList<int[]> visitedPatches = new ArrayList<int[]>();
  
  Balloon(int health, double curX, double curY){
    this.health = health;
    this.curX = (int) (curX * 50);
    this.curY = (int) (curY * 50);
    if (health==1){
      c = color(255,0,0);
      speed = 1;
    }
    else if (health==2){
      c = color(0,0,255); 
      speed = 1.4;
    }
    else if (health==3){
      c = color(0,255,0); 
      speed = 1.8;
    }
    //c = color(0,0,255);
  }
  
  void move(int x, int y){
    curX += x * speed;
    curY += y * speed;
  }
  
  //void patchVisited(int[] arr) {
  //  visitedPatches.add(arr);
  //}
  
  void decreaseHealth(int towerDamage){
     health -= towerDamage;
  }
  
  void display(){
    smooth();
    stroke(0);
    fill(c);
    ellipse(curX, curY, 30, 40);
    noStroke();
  }
  
}
