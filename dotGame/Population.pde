import java.util.Scanner;

class Population {
  Dot[] dots;
  float fitnessSum;
  int gen = 2;
  int bestDot = 0;
  int minStep = 400;

  Population(int size, Obstacles[] ob) {
    dots = new Dot[size];
    for(int i = 0; i < size; i++) {
      dots[i] = new Dot(ob);
    }
  }
  
 //----------------------------------------------------------------------------
 
 void show() {
   for(int i = 0; i < dots.length; i++) {
     dots[i].show();
   }
 }
 
 //----------------------------------------------------------------------------
 
 void update() {
   
   for(int i = 0; i < dots.length; i++) {
     if(dots[i].brain.step <= minStep) {
       dots[i].update();
     } else {
       dots[i].dead = true;
     }
   }
 }   

 //----------------------------------------------------------------------------

  void calculateFitness() {
    for(int i = 0; i < dots.length; i++) {
     dots[i].calculateFitness();
   }
  }
  
  //----------------------------------------------------------------------------
  
  boolean allDotsDead() {
    for(int i = 0; i < dots.length; i++) {
      if(!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }
  
  //----------------------------------------------------------------------------
  
  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for(int i = 1; i < newDots.length; i++) {
      //select parent based on fitness
      Dot parent = selectParent();
      //get baby from them
      newDots[i] = parent.gimmeBaby();
    }
    
    dots = newDots.clone();
    System.out.println("Generation " + gen);
    gen++;
  }
  
  //----------------------------------------------------------------------------
  
  void calculateFitnessSum() {
    fitnessSum = 0;
    for(int i = 0; i <dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }
  
  //----------------------------------------------------------------------------
  
  Dot selectParent() {
    float rand = random(fitnessSum);
    
    float runningSum = 0;
    for(int i = 0; i <dots.length; i++) {
      runningSum += dots[i].fitness;
      if(runningSum > rand) {
        return dots[i];
      }
    }
    
    return null;
  }
  
  //----------------------------------------------------------------------------
  
  void mutate() {
    for(int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }
  
  //-----------------------------------------------------------------------------
  
  void setBestDot() {
    int maxIndex = 0;
    float max = 0;
    for(int i = 0; i < dots.length; i++) {
      if(dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    
    bestDot = maxIndex;
    
    if(dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
    }
  } 
}
