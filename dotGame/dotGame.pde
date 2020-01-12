
Population test;
PVector goal = new PVector(400,10);
Obstacles[] ob;
int totalObstacles;
boolean play = true, restart = false, newlevel = false;

void setup() {
  totalObstacles = 0;
  ob = new Obstacles[totalObstacles];
  System.out.println("Generation 1");
  size(800,800);
  test = new Population(1000, ob);
  
}

void draw() {
  background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10,10);
  if(newlevel) {
    ob = new Obstacles[totalObstacles];
    restart = true;
    newlevel = false;
  }
  switch(totalObstacles) {
    case 0: break;
    case 1: ob[0] = new Obstacles(150,(height/2)-40,500,10);
            break;
    case 2: ob[0] = new Obstacles(0,250,600,10);
            ob[1] = new Obstacles(200,500,600,10);
            break;
    case 3: ob[0] = new Obstacles(0,250,600,10);
            ob[1] = new Obstacles(200,500,600,10);
            ob[2] = new Obstacles((width/2)-5,330,10,100);
            break;        
  }
  if(restart) {
    test = new Population(1000, ob);
    restart = false;
    System.out.println("Generation 1");
  }
  if(test.allDotsDead()) {
    test.calculateFitness();
    test.naturalSelection();
    test.mutate();
  } else {
    if(play) {
      test.update();
    }
    test.show();
  }
}

void keyPressed() {
//  System.out.println("Key pressed");
  if(key == 'p' || key == 'P') {
//    System.out.println("Play");
    if(play) {
      play = false;
    } else {
      play = true;
    }
  }
  
  if(key == 'r' || key == 'R') {
//    System.out.println("Restart");
    restart = true;
  }
  
  if(key == '0' && totalObstacles != 0) {
    totalObstacles = 0;
    newlevel = true;
  }
  
  if(key == '1' && totalObstacles != 1) {
    totalObstacles = 1;
    newlevel = true;
  }
  
  if(key == '2' && totalObstacles != 2) {
    totalObstacles = 2;
    newlevel = true;
  }
  
  if(key == '3' && totalObstacles != 3) {
    totalObstacles = 3;
    newlevel = true;
  }
  
  
} 
