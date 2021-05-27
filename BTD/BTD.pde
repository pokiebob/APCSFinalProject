//Balloon Tower Defense
     
int colPatch = 16;
int rowPatch = 15;
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Balloon> balloons = new ArrayList<Balloon>();
int[][] background = pumpkinPatch();

boolean towerSelected = false;
Tower curTower;

void setup(){
  size(1200,750);
  setBackground(); 
}

void setBackground() {
  background(200);
  /* Creates 15 x 16 (grid) */
  for(int i = 0; i < rowPatch; i++){
    for(int j = 0; j < colPatch; j++){
      if (background[i][j]==1){
        fill(255);
        rect(j*50,i*50,50,50);
      }
      else{
        fill(0);
        rect(j*50,i*50,50,50);
      }
    }
  }
}

void draw(){

  setBackground();
  Tower dartMonkey = new Tower(20, 4);
  dartMonkey.display();
  
  
  makeBalloon();
  moveBalloons();
  
  for (Tower t : towers) {
    t.display();
  }
  
   if (towerSelected) {
     //System.out.println("towerSelected");
     if (mousePressed) {
       //System.out.print(" and mouse pressed \n");
       cursor(HAND);
       curTower.drag();
       curTower.display();
     } else {
       cursor(ARROW);
       towerSelected = false;
       
       //if legal tower placement
       if (isLegalTowerPlacement()) {
         //System.out.println("legal tower placement");
         towers.add(curTower);
       }
       //System.out.println(locatePatch()[0] + " " + locatePatch()[1]);
     }
   }
   else if (dist(1000, 200, mouseX, mouseY) < 25) {
      //System.out.println("tower not selected");
      cursor(HAND);
      if (mousePressed) {
        Tower newDartMonkey = new Tower(20, 4);
        curTower = newDartMonkey;
        towerSelected = true;
      } else {
        strokeWeight(5);
      }
   } else {
     //System.out.println("tower not in range");
     cursor(ARROW);
     noStroke();
   }
}

void makeBalloon(){
  Balloon bloon = new Balloon(100, 15.5, 1.5);
  balloons.add(bloon);  
}

void moveBalloons(){
  //
  for (Balloon b : balloons) {    
     b.display();
     //double[] patch = locatePatch(b.curX, b.curY);
     
     if(b.curX <= 75){
       if (b.curY < 275 || (b.curY >= 475 && b.curY < 675)) {
         //Move down (first move down)
         b.move(0,1);
       }
       else {
         //Move right
         b.move(1,0);
       }
     }
     else if (b.curY == 75 || b.curY == 475){
       //Moves left
       b.move(-1, 0);
     }
     else if (b.curX == 725 && b.curY < 525){
       //Move down (right side move down)
       b.move(0, 1);
     }
     else {
       //Move right (last row)
       print(b.curX + "," + b.curY);
       b.move(1, 0);
     }
     
  }
}

void keyPressed(){
  if (key == 32){
    towers.clear(); 
  }
}

int[] locatePatch() {
  return new int[] { (int) mouseX / 50, (int) mouseY / 50 };
}

double[] locatePatch(int x, int y) {
  return new double[] { x / 50, y / 50};
}

boolean isLegalTowerPlacement() {
  if (mouseX > 800) {
    return false;
  }
  int[] patch = locatePatch();
  return background[patch[1]][patch[0]] == 0;
}

int[][] pumpkinPatch(){
    return new int[][] { 
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},  
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0}, 
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0}, 
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0}, 
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
}
