public class Shape {
  color c = color(random(255), random(255), random(255));
  PVector pos = new PVector(random(width), random(height), random(30, 32));
  PVector vel = new PVector(random(-2, 2), random(-2, 2), 0.01);
  boolean living = true;
  int clds = 0; 
  int particlesMax = 192;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  boolean hasImage;
  PImage image;
  void kill(boolean a) {
    if (explosions) living = false;
    if(agariomode) vel.z = -2;
    if (a&&explosions) {
      for (int i=0; i<particlesMax; i++) {
        particles.add(new Particle(pos.x, pos.y, c));
      }
    }
  }
  void kill(Shape s, boolean sdx, boolean sdy) {
    
    if (agariomode) {
      if (s.pos.z>pos.z) {
        s.vel.z+=pos.z/75;
        living = false;
      }
      if (s.pos.z<pos.z) {
        vel.z+=s.pos.z/75;
        s.living = false;
      }
    } else if (bounce) {
      PVector tmpVel;
      vel.x = !sdx?-vel.x:vel.x;
      vel.y = !sdy?-vel.y:vel.y;
    }
  }
  void check(Shape s) {
    if (!s.living||!living) {
      return;
    }
    float r = s.pos.z>pos.z?s.pos.z:pos.z;
    boolean isCollidingX = s.pos.x>pos.x-r/2&&pos.x>s.pos.x-r/2;
    boolean isCollidingY = s.pos.y>pos.y-r/2&&pos.y>s.pos.y-r/2;
    boolean thisIsGoingLeft = vel.x<0;
    boolean thatIsGoingLeft = s.vel.x<0;
    boolean sameDirX = thisIsGoingLeft==thatIsGoingLeft;
    boolean thisIsGoingUp = vel.y<0;
    boolean thatIsGoingUp = s.vel.y<0;
    boolean sameDirY = thisIsGoingUp==thatIsGoingUp;

    if (isCollidingX&&isCollidingY) {
      if (explosions) {
        boolean a  =  random(1)>0.4999;
        kill(a);
        s.kill(!a);
      } else if (bounce) {
        kill(s, sameDirX, sameDirY);
        s.kill(this, sameDirX, sameDirY);
      } else if (mode==2||agariomode){
        
        kill(s, sameDirX, sameDirY);
        s.kill(this, sameDirX, sameDirY);
      }
    }
  }
  void update() {
    fill(c);
    stroke(0);
    strokeWeight(1);
    for (int i=0; i<particles.size(); i++) {
      if (particles.get(i).living) {
        particles.get(i).update();
      }
    }
    if (!living) return;
    //vel.add(gravity);
    clds-=1;
    pos.add(vel);
    if (pos.x>width-pos.z/2||pos.x<pos.z/2) {
      vel.x*=-1;
      clds+=3;
    }
    if (pos.y>height-pos.z/2||pos.y<pos.z/2) {
      vel.y*=-1;
      clds+=3;
    }
    if (clds>50) {
      kill(true);
    }
    vel.z*=0.95;
    if (hasImage||!hasImage) show();
    //if (hasImage) image(image, pos.x-pos.z/2, pos.y-pos.z/2, pos.z, pos.z);
  };
  void show() {
    //
  };
}