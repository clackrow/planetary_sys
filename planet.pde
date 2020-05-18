class Planet {
  float mass;
  float G = 0.0005;
  float inV = 4;
  int c;
  PVector pos;
  PVector vel;
  PVector acc;
  PVector force;
  boolean dead = false;

  Planet(float x, float y, float m_, int c_) {
    pos = new PVector(x, y);
    vel = new PVector(random(-inV, inV), random(-inV, inV));
    //vel = new PVector(-30, 0);
    acc = new PVector();
    force = new PVector();
    c = c_;
    mass = m_;
  }

  void show() {
    if (!dead) {
      if (c == 0) {        
        imageMode(CENTER);
        image(s, pos.x, pos.y, mass + 30, mass + 30);
      } else {
        fill(255, 100, 130);
        noStroke();
        ellipse(pos.x, pos.y, mass, mass);
      }
    }
  }

  void move() {
    if (!dead) {
      pos.add(vel);
      vel.add(acc);
    }
  }

  void force(Planet[] p) {
    if (!dead) {
      for (int i = 0; i < p.length; i++) {
        float d = pos.dist(p[i].pos);
        float sinTheta = (p[i].pos.y - pos.y)/d;
        float cosTheta = (p[i].pos.x - pos.x)/d;

        acc.x = G*p[i].mass*cosTheta/d*d;
        acc.y = G*p[i].mass*sinTheta/d*d;

        if (showForces) {
          float magX = mass*cosTheta*500/d;
          float magY = mass*sinTheta*500/d;
          float Nx = pos.x + magX;
          float Ny = pos.y + magY;


          stroke(140, 0, 200);
          line(pos.x, pos.y, Nx, Ny);
          fill(140, 0, 200);
          ellipse(Nx, Ny, 3, 3);
        }
      }

      float maxVel = vel.mag();
      vel.limit(maxVel);
      //if (vel.mag() > 33){
      //  acc.mult(0);
      //}
    }
  }

  void die(Planet[] p) {
    for (int i = 0; i < p.length; i++) {
      float d = pos.dist(p[i].pos);
      if (d < p[i].mass/2) {
        dead = true;
      }
    }
  }

  float escapeV() {
    float v = sqrt(2*G*mass);
    return v;
  }
}
