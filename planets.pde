Planet[] sun = new Planet[1];
Planet[] planets = new Planet[50];
PImage s;

boolean tracing = false;
boolean showForces = true;
boolean forceBetweenPlanets = true;

void setup() {
  if (tracing) {
    background(0);
  }

  s = loadImage("sun.png");

  size(1200, 600);
  sun[0] = new Planet(width/2, height/2, 200, 0);

  for (int i = 0; i < planets.length; i++) {
    planets[i] = new Planet(random(width), random(height), random(5, 20), 1);
  }
}

void draw() {
  if (!tracing) {
    background(0);
  }


  for (int i = 1; i < planets.length; i++) {

    planets[i].force(sun);
    planets[i].show();
    planets[i].move();
    planets[i].die(sun);
  }

  if (forceBetweenPlanets) {
    for (int i = planets.length - 1; i > 0; i--) {
      planets[i].force(planets);
      //planets[i].die(planets);
      //planets[i].die(planets);
      //planets[i].die(planets[i]);
    }
  }
  sun[0].show();
}
