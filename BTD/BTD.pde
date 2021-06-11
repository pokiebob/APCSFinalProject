//Balloon Tower Defense
import java.util.Arrays;   
import processing.sound.*;
     
int[][] background = pumpkinPatch();

int colPatch;
int rowPatch;
int bank;

int income; 
int ticks;
int lives;
int level;
int round;

ArrayList<Tower> towers;
ArrayList<Balloon> balloons;
ArrayList<Bullet> bullets; 

boolean hasStarted;
boolean hasLost;
boolean hasWon;
boolean draggingTower;
boolean selectingTower;

Tower curTower, selectedTower;
Timer time;
Button start = new Button("Start", 600, 712, 1200, 75);
SoundFile song;
SoundFile pop;
PImage dmonkey, smonkey, btower, startScreen, victoryScreen, defeatScreen;

void setup(){
  colPatch = 16;
  rowPatch = 15;
  bank = 650;
  income = 100;
  ticks = 0;
  lives = 150;
  level = 1;
  round = 0;
  
  towers = new ArrayList<Tower>();
  balloons = new ArrayList<Balloon>();
  bullets = new ArrayList<Bullet>();
  
  hasStarted = false;
  hasLost = false;
  hasWon = false;
  draggingTower = false;
  selectingTower = false;
    
  size(1200,750);
  //setBackground();
  startScreen = loadImage("StartScreen.jpg");
  startScreen.resize(1200, 0);
  image(startScreen, 0, 0);
  stroke(0);
  strokeWeight(15);
  line(725, 75, 615, 215);
  //line(615, 75, 725, 215);
  strokeWeight(1);
  start.display();
  time = new Timer(0);
  dmonkey = loadImage("DartMonkey.png");
  smonkey = loadImage("SniperMonkey.png");
  btower = loadImage("BombTower.png");
  victoryScreen = loadImage("VictoryScreen.jpg");
  defeatScreen = loadImage("DefeatScreen.jpg");
  song = new SoundFile(this, "BTDsong.mp3");
  pop = new SoundFile(this, "Pop.mp3");
  //song.loop();
}

void draw(){
  if (!song.isPlaying()){
      song.play();
    }
  if (hasStarted){ 
    
    noStroke();
    //time = millis() * 1000;
    //print(time + "\n");
    setBackground();
    //if (lives == 50){
    //  print(time.getTime() + "\n"); 
    //}
    
    Tower dartMonkey = new Tower(18, 6);
    dartMonkey.display();
    
    Tower sniperMonkey = new Sniper(20, 6);
    sniperMonkey.display();
    
    Tower bombTower = new BombTower(22, 6);
    bombTower.display();
    
    spawnBalloon();
    moveBalloons();
    moveBullets();
    detectBalloon();
    reloadTowers();
    
    for (Tower t : towers) {
      t.display();
    }
    
    dragTower();
    selectTower();
    lifeBar();
    displayStats();
    displayTowerStats();
    
    time.countUp();
    
    if (ticks <= 0 && balloons.size()==0){
      round++;
      setTicks();
    }
    if (lives <= 0) {
      hasLost = true;
    }
    if (round > 12) {
      hasWon = true;
    }
    
    ticks--;
    if (hasLost || hasWon) hasStarted = false;
  }
  if (hasLost || hasWon) {
    //song.stop();
    imageMode(CENTER);
    if (hasLost) {
      defeatScreen.resize(0, 750);
      //for (int i = 0; i < defeatScreen.width; i++){
      //  for (int j = 0; j < defeatScreen.height; j++){
      //    if (defeatScreen.get(i,j) == color(50,255,14)){
      //      defeatScreen.set(0,0,0);
      //    }
      //  }
      //}
      image(defeatScreen, 600, 375);   
    } else {
      victoryScreen.resize(0, 750);
      image(victoryScreen, 600, 375);
    }
    imageMode(CORNER);
    Button restart = new Button("Restart", 125, 100, 150, 100);
    restart.display();
    if (mousePressed && restart.mouseIsOver()) {
      restart();
    }
  }
}

void restart() {
  song.stop();
  setup();
}

void spawnBalloon() {
  if (ticks >= 0) {
    //round 1 = 20 red
    if (round == 1) {
      if (ticks < 200) {
        if(ticks % 10 == 0) makeBalloon(1);
      }
    }
    //round 2 = 35 red
    else if (round == 2) {
      if (ticks < 350) {
        if(ticks % 10 == 0) makeBalloon(1);
      }
    }
    //round 3 = 25 red, 10 blue
    //300 ticks
    else if (round == 3) {
      if (ticks < 300){
        if (ticks >= 50 && ticks % 10 == 0) makeBalloon(1);
        if (ticks < 100 && ticks % 10 == 0) makeBalloon(2);
      }
    }
    //round 4 = 35 red, 28 blue
    //350 ticks
    else if (round == 4) {
      if (ticks < 350) {
        if (ticks % 10 == 0) makeBalloon(1);
        if (ticks < 252 && ticks % 9 == 0) makeBalloon(2);
        
      }
    }
    //round 5 = 5 red, 35 blue, 5 green
    //450
    else if (round == 5) {
      if (ticks < 450) {
        if (ticks < 400) {
          if (ticks % 10 == 0) {
            if ((ticks / 10) % 5 < 4) makeBalloon(2);
            else makeBalloon(3);
          }
        }
        else if (ticks % 10 == 0) makeBalloon(1);
      }
    }
    //round 6 = 15 red, 15 blue, 10 green
    //340 ticks
    else if (round == 6) {
      if (ticks < 340){
        if (ticks >= 115 && ticks % 15 == 0) makeBalloon(1);
        if (ticks < 200 && ticks % 20 == 0) makeBalloon(3);
        if (ticks >= 40 && (ticks + 10) % 20 == 0) makeBalloon(2);
      }
    }
    //round 7 = 20 red, 20 blue, 20 green
    //600
    else if (round == 7) {
      if (ticks < 600){
        if (ticks % 30 == 0) makeBalloon(1);
        if ((ticks + 10) % 30 == 0) makeBalloon(3);
        if ((ticks + 20) % 30 == 0) makeBalloon(2);
      }
    }
    //round 8 = 50 red, 20 blue, 30 green, 5 yellow
    // ticks = 500
    else if (round == 8) {
      if (ticks < 440){
       if ((ticks + 5) % 10 == 0) makeBalloon(1);
       if (ticks % 10 == 0) {
          if ((ticks / 10) % 5 < 3) makeBalloon(3);
          else makeBalloon(2);
        }
       if (ticks < 300 && ticks >= 250 && ticks % 10 == 0) makeBalloon(4);
       
      }
    }
    //round 9 = 50 green, 15 yellow, 30 blue
    // 950 ticks
    else if (round == 9) {
      if (ticks < 950){
        if (ticks >= 150) {
          if (ticks % 10 == 0) {
            if ((ticks / 10) % 8 < 3) makeBalloon(2);
            else makeBalloon(3);
          }
        }
        else if(ticks % 10 == 0) makeBalloon(4);
      }
    }
    //round 10 = 200 red, 70 blue, 30 green, 15 yellow, 5 pink
    // 1000 ticks
    else if (round == 10) {
      if (ticks < 1000){
        if (ticks % 5 == 0) makeBalloon(1);
        if (ticks < 100 && ticks % 20 == 0) makeBalloon(5);
        if (ticks % 10 == 0) {
          if ((ticks / 10) % 10 < 3) makeBalloon(3);
          else makeBalloon(2);
          
          //yellow walls
          if (ticks >= 800 && ticks < 850) makeBalloon(4);
          if (ticks >= 400 && ticks < 450) makeBalloon(4);
          if (ticks < 50) makeBalloon(4);
        }
      }
    }
    //round 11 = 400 red, 100 blue, 50 green, 30 yellow, 10 black
    //2000 ticks
    else if (round == 11) {
      if (ticks < 2000){
        //red
        if (ticks % 5 == 0) makeBalloon(1);
        
        //blue and green
        if (ticks % 10 == 0) {
          if ((ticks / 10) % 3 < 2) makeBalloon(2);
          else makeBalloon(3);
          
          //yellow 
          if (ticks >= 1800 && ticks < 1850) makeBalloon(4);
          if (ticks >= 1000 && ticks < 1050) makeBalloon(4);
          if (ticks >= 600 && ticks < 650) makeBalloon(4);
          if (ticks < 150) makeBalloon(4);
          
          //black
          if (ticks >= 150 && ticks < 250) makeBalloon(6);
        }
      }
    }
    //round 12 = 1000 red, 300 blue, 200 green, 100 yellow, 100 pink, 50 black, 20 white
    //5000 ticks
    else if (round == 12) {
      if (ticks < 5000){
        //red
        if (ticks % 5 == 0) makeBalloon(1);
        
        //pink and yellow
        if (ticks % 50 == 0) {
          makeBalloon(5);
          makeBalloon(4);
        }
        
        //blue and green
        if (ticks % 10 == 0) {
          if ((ticks / 10) % 5 < 3) makeBalloon(2);
          else makeBalloon(3);
          
          
          //black
          if (ticks >= 4800 && ticks < 4700) makeBalloon(6); //10
          if (ticks >= 4000 && ticks < 4050) makeBalloon(6); //5
          if (ticks >= 3500 && ticks < 3550) makeBalloon(6); //5
          if (ticks >= 3000 && ticks < 3050) makeBalloon(6); //5
          if (ticks >= 2500 && ticks < 2550) makeBalloon(6); //5
          if (ticks >= 2000 && ticks < 2050) makeBalloon(6); //5
          if (ticks >= 850 && ticks < 1000) makeBalloon(6); //15
          
          //white
          if (ticks >= 4200 && ticks < 4250) makeBalloon(9);
          if (ticks >= 2750 && ticks < 2800) makeBalloon(9);
          if (ticks >= 150 && ticks < 250) makeBalloon(9);
        }
      }
    }
  
  }
  
}

void setTicks(){
  if (round == 1) {
    ticks = 200;
  }
  else if (round == 2){
    ticks = 350;
  }
  else if (round == 3){
    ticks = 300;
  }
  else if (round == 4){
    ticks = 350;
  }
  else if (round == 5){
    ticks = 450;
  }
  else if (round == 6){
    ticks = 340;
  }
  else if (round == 7){
    ticks = 600;
  }
  else if (round == 8){
    ticks = 500;
  }
  else if (round == 9){
    ticks = 950;
  }
  else if (round == 10){
    ticks = 1000;
  }
  else if (round == 11){
    ticks = 2000;
  }
  else if (round == 12){
    ticks = 5000;
  }
  ticks += 200;
  if (round > 1) bank += income;
}

void displayTowerStats() {
  if (selectingTower) {
    stroke(0);
    fill(255);
    rect(850, 400, 300, 300);
    
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text(selectedTower.name, 1000, 425);
    textSize(12);
    text("Level: " + selectedTower.level, 1000, 450);
    
    imageMode(CENTER);
    if (selectedTower.name.equals("Dart Monkey")) {
      dmonkey.resize(0, 125);
      image(dmonkey, 1000, 525);
    }
    else if (selectedTower.name.equals("Sniper Monkey")) {
      smonkey.resize(0, 125);
      image(smonkey, 1000, 525);
    }
    else if (selectedTower.name.equals("Bomb Tower")) {
      btower.resize(0, 125);
      image(btower, 1000, 525);
    }
    
    Button upgradeTower = new Button("Upgrade", 1075, 645, 100, 50);
    if (selectedTower.upgradeCost > bank || selectedTower.level == 4) {
      upgradeTower.activated = false;
    }
    upgradeTower.display();
    
    if (mousePressed && upgradeTower.mouseIsOver()) {
      bank -= selectedTower.upgradeCost;
      selectedTower.upgrade();
      selectingTower = false;
    }
    
    if (selectedTower.level < 4) text("Upgrade Cost: " + selectedTower.upgradeCost, 1075, 685);
    
    textAlign(CORNER);
   
    text("Cost: " + selectedTower.cost, 875, 625);
    text("Damage: " + selectedTower.damage, 875, 645);
    text("Range: " + selectedTower.range, 875, 665);
    text("Sharpness: " + selectedTower.sharpness, 875, 685);
    //text("Reload: " + (double) (int) ((selectedTower.speed) * 10 + 0.5) / 10, 875, 685);
  }
}

void displayStats(){
  textSize(32);
  textAlign(CENTER);
  text("Round: " + round + "/12", 1000, 50);
  text("Towers", 1000, 250);
  textSize(20);
  text("Bank: " + bank, 1000, 100); 
  text("Income: " + income, 1000, 125); 
  text("Time Elapsed: " + (int) time.getTime(), 1000, 150);
  textAlign(LEFT);
}

void setBackground() {
  background(200);
  /* Creates 15 x 16 (grid) */
  for(int i = 0; i < rowPatch; i++){
    for(int j = 0; j < colPatch; j++){
      if (background[i][j]==1){
        fill(215,140,65);
        rect(j*50,i*50,50,50);
      }
      else{
        fill(170,80,40);
        rect(j*50,i*50,50,50);
      }
    }
  }
}

void mousePressed(){
  if (!hasStarted) {
    if (start.mouseIsOver()){
      hasStarted = true; 
    }
  }
}

void reloadTowers() {
  for (Tower t : towers) {
    if (! t.canShoot) {
      if (t.timer <= 0) {
        t.canShoot = true;
        t.timer = t.speed;
      }
      t.timer -= 1.0 / 60;
    }
  }
}

void detectBalloon() {
  for (Tower t : towers) {
    int i = 0;
    while (t.canShoot && i < balloons.size()) {
      Balloon balloon = balloons.get(i);
        if (isInRange(balloon, t)) {
          //int direction = (t.y - balloon.curY) / (t.x - balloon.curX) * 360;
          int direction = 180 - (int) degrees(atan2((float) (t.y - balloon.curY), (float) (t.x - balloon.curX)));
          Bullet b;
          if (t.name.equals("Dart Monkey")) {  
            //Triple shot function
            if (t.level == 4) {
              Bullet b1 = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction + 25, t.sharpness); 
              Bullet b2 = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction - 25, t.sharpness); 
              bullets.add(b1);
              bullets.add(b2);
              //print("triple shot");
            }
            b = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction, t.sharpness); 
          } else if (t.name.equals("Bomb Tower")) {
            b = new Bomb(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction, t.splashRadius);
          } else {
            b = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction, t.sharpness); 
          }
          b.display();
          bullets.add(b);
          t.canShoot = false;
      }
      i++;
    }
  }
}

boolean isInRange(Balloon b, Tower t) {
  return (dist(b.curX, b.curY, t.x, t.y) <= t.range);
}

void moveBullets(){
  for (int i = bullets.size() - 1; i >= 0; i--){
    Bullet b = bullets.get(i);
    int j = 0;
    while (!b.hitBalloon && j < balloons.size()) {
      Balloon balloon = balloons.get(j);
      if (b.visitedBalloons.contains(balloon)){
        //print("already visited");
        j++; 
      }
      else {
        if (dist(b.curX, b.curY, balloon.curX, balloon.curY) <= 40) {
          if (b.name.equals("bomb")) {
            for (int k = balloons.size() - 1; k >= 0; k--) {
              Balloon surroundingBalloon = balloons.get(k);
              if (surroundingBalloon.health != 6
              && dist(b.curX, b.curY, surroundingBalloon.curX, surroundingBalloon.curY) <= b.splashRadius) {
                int initial = surroundingBalloon.health;
                surroundingBalloon.decreaseHealth(b.damage);
                if (surroundingBalloon.health <= 0) {
                  income += initial;
                  balloons.remove(k);
                  if (!pop.isPlaying()){
                    pop.play();
                  }
                }
                else {
                  if (initial > 5 && surroundingBalloon.health < 5) {
                    Balloon newBalloon = new Balloon(surroundingBalloon.health, surroundingBalloon.curX / 50 + 0.5, surroundingBalloon.curY / 50 + 0.5);
                    balloons.add(newBalloon);  
                  }
                  income += b.damage;
                }
              }
            }
          }
          else {
            int initial = balloon.health;
            balloon.decreaseHealth(b.damage);
            if (balloon.health <= 0) {
              income += initial;
              balloons.remove(j);
              if (!pop.isPlaying()){
                pop.play();
              }
            }
            else {
              if (initial > 5 && balloon.health <= 5) {
                Balloon newBalloon = new Balloon(balloon.health, balloon.curX / 50 + 0.5, balloon.curY / 50 + 0.5);
                balloons.add(newBalloon);  
              }
              income += b.damage;
              b.hitBalloon(balloon);
            }
          }
         
          b.sharpness--;
          if (b.sharpness <= 0){
            bullets.remove(i);
            b.hitBalloon = true;
          }
      }
      j++;
      }
      
    }
    try {
      if (bullets.size() > 0 && b.range <= 0){
        bullets.remove(i); 
      }
      else {
        b.display();
        b.move();
      }
    }
    catch (IndexOutOfBoundsException e){

      //print("hi");
      continue;
    }
  }
}

void lifeBar() {
  fill(255, 0, 0);
  rect(0, 0, 800, 25);
  fill(0,255,0);
  rect(0, 0, lives * 16 / 3, 25);
  
  fill(0);
  textSize(20);
  text("" + lives, 12.5, 20);
}

void selectTower() {
  if (!selectingTower) {
    for (Tower t : towers) {
      //if user clicks on a tower
      if (dist(t.x, t.y, mouseX, mouseY) < 25) {
        if (mousePressed) {
          selectingTower = true;
          selectedTower = t;
        }
      }
    }
  }
  else {
    fill(255, 255, 255, 50);
    ellipse(selectedTower.x, selectedTower.y, selectedTower.range * 2, selectedTower.range * 2);
    if (mousePressed && mouseX < 800 && ! (dist(selectedTower.x, selectedTower.y, mouseX, mouseY) < 25)) {
      selectingTower = false;
    }
  }
}

void dragTower() {
  if (draggingTower) {
     if (mousePressed && (mouseButton == LEFT)) {
       //currently dragging tower
       selectingTower = true;
       selectedTower = curTower;
       curTower.drag();
       curTower.display();
       //Range
       if (isLegalTowerPlacement()) {
         fill(255, 255, 255, 50);
       } else {
         fill(255, 0, 0, 50);
       }

       ellipse(curTower.x, curTower.y,curTower.range * 2, curTower.range * 2); 
     } else {
       //you let go of tower
       draggingTower = false;
       selectingTower = false;
       //if legal tower placement
       if (isLegalTowerPlacement()) {
         //System.out.println("legal tower placement");
         towers.add(curTower);
         bank -= curTower.cost;
         //income -= (int) (curTower.cost * 0.07);
       }
       curTower = null;
       selectedTower = null;
       //System.out.println(locatePatch()[0] + " " + locatePatch()[1]);
     }
   }
   else if (!selectingTower) {
     if (dist(900, 300, mouseX, mouseY) < 25) {
        //System.out.println("tower not selected");
        if (mousePressed) {
          Tower newDartMonkey = new Tower(18, 6);
          curTower = newDartMonkey;
          draggingTower = true;
        }
     }
     else if (dist(1000, 300, mouseX, mouseY) < 25) {
        //System.out.println("tower not selected");
        if (mousePressed) {
          Sniper newSniperMonkey = new Sniper(20, 6);
          curTower = newSniperMonkey;
          draggingTower = true;
        }
     }
     else if (dist(1100, 300, mouseX, mouseY) < 25) {
        //System.out.println("tower not selected");
        if (mousePressed) {
          BombTower newBombTower = new BombTower(22, 6);
          curTower = newBombTower;
          draggingTower = true;
        }
     }
   }

}

void makeBalloon(int h){
  Balloon bloon = new Balloon(h, 15.5, 1.5);
  balloons.add(bloon);  
}

void moveBalloons(){
  for (int i = 0; i < balloons.size(); i++) {   
    Balloon b = balloons.get(i);
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
     else if (b.curY < 650 && (b.curY <= 75 || b.curY >= 475)){
       //Moves left
       b.move(-1, 0);
     }
     else if (b.curX > 725 && b.curY < 525){
       //Move down (right side move down)
       b.move(0, 1);
     }
     else {
       //Move right (last row)
       //print(b.curX + "," + b.curY);
       b.move(1, 0);
     }
     
     if (b.curX >= 800 && b.curY >= 600) {
       lives -= b.health;
       balloons.remove(i);
     }
  }
  
}

//void keyPressed(){
//  if (key == 32){
//    makeBalloon(3);
//  }
//  if (key == 'w') {
//    hasWon = true;
//  }
//  if (key == 'l') {
//    hasLost = true;
//  }
//}

int[] locatePatch() {
  return new int[] { (int) mouseX / 50, (int) mouseY / 50 };
}

double[] locatePatch(int x, int y) {
  return new double[] { x / 50, y / 50};
}

boolean isLegalTowerPlacement() {
  if (mouseX > 775 || mouseX < 25 || mouseY < 25 || mouseY > 725 || bank < curTower.cost) {
    return false;
  }
  double[] patch;
  int value;
  
  //check if overlaps with path
  try {
    patch = locatePatch(mouseX + 25, mouseY);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1) {
      return false;
    }
    patch = locatePatch(mouseX - 25, mouseY);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1) {
      return false;
    }
    patch = locatePatch(mouseX, mouseY + 25);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1 ) {
      return false;
    }
    patch = locatePatch(mouseX, mouseY - 25);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1) {
      return false;
    }
  
    //check if overlaps with other towers
    for (Tower t : towers) {
      patch = locatePatch(mouseX + 25, mouseY);
      if (Arrays.equals(patch, locatePatch(t.x + 25, t.y))) {
        return false;
      }
      patch = locatePatch(mouseX - 25, mouseY);
      if (Arrays.equals(patch, locatePatch(t.x -  25, t.y))) {
        return false;
      }
      patch = locatePatch(mouseX, mouseY + 25);
      if (Arrays.equals(patch, locatePatch(t.x, t.y + 25))) {
        return false;
      }
      patch = locatePatch(mouseX, mouseY - 25);
      if (Arrays.equals(patch, locatePatch(t.x, t.y - 25))) {
        return false;
      }
    }
  }
  catch (ArrayIndexOutOfBoundsException e){
    //print("hi");
    return false;
  }
  return true;
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
