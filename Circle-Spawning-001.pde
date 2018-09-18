// Circle Spawning with No Intersection
// by Michael Pinn
// https://www.openprocessing.org/sketch/157175
// Fork by Rupert Russell 18/09/2018
// Pallet by http://imgr.co/palette-gallery.html


color[] rainbow = {#FFFFCD, #CC5C54, #F69162, #85A562, #7AB5DB};
ArrayList<Circle> circles = new ArrayList<Circle>();

int min = 10;
int max = 250;
int counter = 0;
int saveCount = 0;

/* Our object */
Circle c = new Circle(new PVector(0, 0), 20);

void setup() {
  size(7700, 7700);
  circles.add(c);
  /* Because we are not refreshing the draw screen. We set what the background wil be a the  */
   background(rainbow[0]);
   smooth();
}

void draw() {
  c.draw();
  /* Make a random location and diameter */
  PVector newLoc = new PVector(random(width - 500) + 250, random(height - 500) + 250);
  int newD = (int) random(min, max);
  /* Detect whether if we use these these values if it will intersect the other objects. */
  while (detectAnyCollision (circles, newLoc, newD)) {
    /* If the values do interect make new values. */
    newLoc = new PVector(random(width - 500) + 250, random(height - 500) + 250);
    newD = (int) random(min, max);
  }

  /* Once we have our values that do not intersect, add a circle. */
  c = new Circle(newLoc, newD);
  circles.add(c);
  
  /* You can add an "if" statement to prevent the simulation going on forever */

if(counter == 500){
  save("save_" + saveCount + ".png");
  println("saving " + saveCount);
  saveCount ++;
counter = 0;
}
counter ++;
}

static boolean detectAnyCollision(ArrayList<Circle> circles, PVector newLoc, int newR) {
  for (Circle c : circles) {
    if (c.detectCollision(newLoc, newR)) {
      return true;
    }
  }
  return false;
}


class Circle {
  PVector loc;
  int d;

  Circle(PVector loc, int d) {
    this.loc = loc;
    this.d = d;
  } 

  void draw() {
    /* Random color to add some spice */
    noStroke();
    fill(rainbow[int(random(1, 5))]);
    ellipse(loc.x, loc.y, d, d);
  }

  boolean detectCollision(PVector newLoc, int newD) {
    /* 
     We must divide d + newD because they are both diameters. We want to find what both radius's values are added on. 
     However without it gives the balls a cool forcefeild type gap.
     */
    return dist(loc.x, loc.y, newLoc.x, newLoc.y) < ((d + newD)/2);
  }
  
  
}
