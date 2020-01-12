class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  float fitness = 0;
  Obstacles[] obs;
  
  Dot(Obstacles[] ob) {
    obs = ob.clone();
    brain = new Brain(400);
    pos = new PVector(width/2,height-10);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  
  }
  
 //--------------------------------------------------------------------------------
 
  void show() {
    if(isBest) {
      fill(0,255,0);
      ellipse(pos.x,pos.y,18,18);
    } else {
      fill(0);
      ellipse(pos.x,pos.y,4,4);
    }
  
  }
  
  //---------------------------------------------------------------------------------
  
  void move() {
    
    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }
  
  //---------------------------------------------------------------------------------
  
  boolean hitObstacle() {
    for(int i = 0; i < obs.length; i++) {
      if(pos.x > obs[i].startx && pos.x < (obs[i].startx + obs[i].len) && pos.y > obs[i].starty && pos.y < (obs[i].starty + obs[i].brd)) {
        return true;
      }
    }
    return false;
  }
  
  
  
  //---------------------------------------------------------------------------------
  
  void update() {
    if(!dead && !reachedGoal) {      
      move();
      if(pos.x < 2 || pos.y < 2 || pos.x > (width-3) || pos.y > (height-3) || hitObstacle()) {
        dead = true;
      } else if(dist(pos.x,pos.y,goal.x,goal.y) < 5) {
        reachedGoal = true;
      }
    }
  }
  
  //--------------------------------------------------------------------------------
  
  void calculateFitness() {
    if(reachedGoal) {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {
      float distanceToGoal = dist(pos.x,pos.y,goal.x,goal.y);
      fitness = 1.0 / (distanceToGoal * distanceToGoal);
    }
  }
  
  //----------------------------------------------------------------------------
  
  Dot gimmeBaby() {
    Dot baby = new Dot(obs);
    baby.brain = brain.clone();
    return baby;
  }
}
