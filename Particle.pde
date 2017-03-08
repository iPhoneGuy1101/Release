public class Particle{
  color c;
  boolean living = true;
  PVector pos = new PVector();
  PVector vel = new PVector(random(-4,4),random(-4,4));
  Particle(float x, float y, int a){
    pos.x = x;
    pos.y = y;
    c = a;
  }
  void show(){
    strokeWeight(4);
    stroke(c);
    fill(c);
    line(pos.x,pos.y,pos.x-vel.x*2,pos.y-vel.y*2);
  }
  void update(){
    show();
    pos.add(vel);
    vel.add(gravity);
    if(pos.x>width||pos.x<0||pos.y>height){living = false;}
  }
}