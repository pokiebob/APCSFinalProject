//Balloon Tower Defense
import java.util.Arrays;   
import processing.sound.*;
     
int[][] background = pumpkinPatch();

int colPatch = 16;
int rowPatch = 15;
int bank = 650; 
int income = 100; 
int ticks = 0;
int lives = 150;
int level = 1;
int round = 0;

ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Balloon> balloons = new ArrayList<Balloon>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>(); 

boolean hasStarted = false;
boolean draggingTower = false;
boolean selectingTower = false;

Tower curTower, selectedTower;
Timer time;
Button start = new Button("Start", 600, 600, 200, 100);
SoundFile song;
SoundFile pop;
PImage dmonkey, smonkey, btower, startScreen;

void setup(){
  size(1200,750);
  //setBackground();
  startScreen = loadImage("StartScreen.jpg");
  startScreen.resize(1200, 0);
  image(startScreen, 0, 0);
  start.display();
  time = new Timer(0);
  dmonkey = loadImage("DartMonkey.png");
  smonkey = loadImage("SniperMonkey.png");
  btower = loadImage("BombTower.png");
  song = new SoundFile(this, "BTDsong.mp3");
  pop = new SoundFile(this, "Pop.mp3");
  //song.loop();
}

void draw(){
 
  if (hasStarted){ 
    if (!song.isPlaying()){
      song.play();
    }
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
    
    if (time.getTime() <= 0){
       //Display win message 
    }
    
    time.countUp();
    
    if (ticks <= 0 && balloons.size()==0){
      round++;
      setTicks();
    }
    ticks--;
  }
}

void spawnBalloon() {
  if (ticks >= 0) {
    
    if (round == 1) {
      if (ticks < 200) {
        if(ticks % 10 == 0) makeBalloon(1);
      }
    }
    
    else if (round == 2) {
      if (ticks < 350) {
        if(ticks % 10 == 0) makeBalloon(1);
      }
    }
    
    else if (round == 3) {
      if (ticks < 300){
        if(ticks >= 250) {
          if(ticks % 10 == 0) makeBalloon(2);
        } else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 4) {
      if (ticks < 530){ 
        if(ticks > 180) {
          if(ticks % 10 == 0) makeBalloon(2);
        } else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 5) {
      if (ticks < 320){ 
        if(ticks > 270) {
          if(ticks % 10 == 0) makeBalloon(2);
        } else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 6) {
      if (ticks < 340){
       if(ticks < 150) {
         if(ticks % 10 == 0) makeBalloon(2);
        } else if (ticks < 190) {
          if (ticks % 10 == 0) makeBalloon(3);
        }
        else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 7) {
      if (ticks < 450){
       if(ticks < 200) {
         if(ticks % 10 == 0) makeBalloon(2);
        } else if (ticks < 250) {
          if (ticks % 10 == 0) makeBalloon(3);
        }
        else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 8) {
      if (ticks < 440){
       if(ticks < 200) {
         if(ticks % 10 == 0) makeBalloon(2);
        } else if (ticks < 340) {
          if (ticks % 10 == 0) makeBalloon(3);
        }
        else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 9) {
      if (ticks < 300){
        if(ticks % 10 == 0) makeBalloon(3);
      }
    }
    
    else if (round == 10) {
      if (ticks < 1020){
        if(ticks % 10 == 0) makeBalloon(2);
      }
    }
  
  }
  
  //if (round == 1) {
  //  for (int i = 199; i >= 0; i-=100){
  //    if ( (i/100 % 2 == 0) && ticks >= i && ticks <= i + 100){
  //      if(ticks % 10 == 0) makeBalloon(3);
  //    }
  //  }
  //}
  
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
    ticks = 530;
  }
  else if (round == 5){
    ticks = 320;
  }
  else if (round == 6){
    ticks = 340;
  }
  else if (round == 7){
    ticks = 450;
  }
  else if (round == 8){
    ticks = 440;
  }
  else if (round == 9){
    ticks = 300;
  }
  else if (round == 10){
    ticks = 1020;
  }
  ticks += 200;
  if (round > 1) bank += income;
}

/*
round 1 = 20 red
round 2 = 35 red
round 3 = 25 red, 5 blue
round 4 = 35 red, 18 blue
round 5 = 5 red, 27 blue 
round 6 = 15 red, 15 blue, 4 green
round 7 = 20 red, 20 blue, 5 green
round 8 = 10 red, 20 blue, 14 green
round 9 = 30 green
round 10 = 102 blue
*/

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
    upgradeTower.display();
    
    if (mousePressed && upgradeTower.mouseIsOver()) {
      selectedTower.upgrade();
      selectingTower = false;
    }
    
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
  text("Round: " + round, 1000, 50);
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
            if (level == 4) {
              Bullet b1 = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction + 10, t.sharpness); 
              Bullet b2 = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction - 10, t.sharpness); 
              bullets.add(b1);
              bullets.add(b2);
              b1.display();
              b2.display();
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
  for (int i = 0; i < bullets.size(); i++){
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
              if (dist(b.curX, b.curY, surroundingBalloon.curX, surroundingBalloon.curY) <= b.splashRadius) {
                int initial = balloon.health;
                surroundingBalloon.decreaseHealth(b.damage);
                if (surroundingBalloon.health <= 0) {
                  income += initial;
                  balloons.remove(k);
                  if (!pop.isPlaying()){
                    pop.play();
                  }
                }
                else {
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
    
    if (bullets.size() > 0 && b.range <= 0){
      bullets.remove(i); 
    }
    else {
      b.display();
      b.move();
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
         income -= (int) (curTower.cost * 0.07);
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

void keyPressed(){
  if (key == 32){
    makeBalloon(5);
  }
}

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
    print("hi");
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
