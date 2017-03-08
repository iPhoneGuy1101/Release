import processing.serial.*;

int mode=round(random(3));
//0 = no collisions
//1 = explode
//2 = bounce off other shapes
//3 = agar.io mode
ArrayList<Shape> shapes = new ArrayList<Shape>();
PVector gravity = new PVector(0, 0.1);
PImage mouse, button;
int imagecount = 5, load = imagecount = 5, h = round(imagecount*2.5);
boolean started, click, recording = false;
boolean hasImages = false, explosions = mode==1;
boolean bounce = mode==2, agariomode = mode==3;
ArrayList<PImage> images;
//Define explosions boolean, tells wether explosions are enabled
Shape newShape() {
  return(random(1)<0.25?(new Triangle())
    :(random(1)<0.33?(new Circle())
    :(new Square)));
    //:(random(1)<0.5?(new Square()):(new Image()))));
}

void setup() {//Creates setup function (runs on program launch)
  //frame.setTitle("Bouncing Shapes");//Set title
  size(window.innerWidth,window.innerHeight);//Set window size to 640X360 (360p)
  //fullScreen();
  mouse = loadImage("mouseCursor.png");
  images = new ArrayList<PImage>();
  for (int i=1; i<imagecount+1; i++) {
    images.add(loadImage("image"+i+".png"));
  };
  //for (int i=0; i<25; i++) {
  //  shapes.add(newShape());
  //  //shapes.get(i).image = i%h<images.size()?images.get(i%h):mouse;
  //  //shapes.get(i).hasImage = !shapes.get(i).image.equals(mouse);
  //  //if(shapes.get(i).hasImage) shapes.get(i).pos.z*=random(1.2,1.5);
  //}
  button = loadImage("backgroundButton.png");
}
boolean displayCursor;
void drawA() {
  frameRate(80);
  background(0);
  if (keyPressed) keyPressed = false;//Prevent spam 60 times a second of above
  //frame.setTitle("Bouncing Shapes (cursor: "+(displayCursor?"en":"dis")+"abled) "+5*((int)frameRate/5)+" fps");//Set title in case of change
  for (int i=0; i<shapes.size(); i++) {
    shapes.get(i).update();
    for (int j=0; j<shapes.size(); j++) {
      if (i!=j&&explosions) shapes.get(i).check(shapes.get(j));
      if (i!=j&&bounce) shapes.get(i).check(shapes.get(j));
      if (i!=j&&agariomode) shapes.get(i).check(shapes.get(j));
    }
  }
  //if(!displayCursor){
  if (mousePressed) {
    Shape newOne = newShape();
    newOne.pos.x = mouseX;
    newOne.pos.y = mouseY;
    shapes.add(newOne);
    mousePressed=!mousePressed;
  }
  //}
  
}
void draw() {
  explosions = mode==1;
  bounce = mode==2;
  agariomode = mode==3;
  frameRate(76);
  background(0);
  if (key=='c'&&keyPressed) displayCursor=!displayCursor;//toggle explosions
  if (key=='r'&&keyPressed) recording=!recording;//toggle explosions
  if (key=='0'&&keyPressed) mode=0;
  if (key=='1'&&keyPressed) mode=1;
  if (key=='2'&&keyPressed) mode=2;
  if (key=='3'&&keyPressed) mode=3;

  if(keyPressed) keyPressed=false;
  if (started&&load>=99) drawA();
  if (!started&&load<=98) {
    fill(140);
    strokeWeight(4);
    stroke(70);
    image(button, width/2-125, height/4, 250, 75);
    fill(50);
    strokeWeight(3);
    stroke(200);
    textFont(createFont("Minecrafter Alt", 36));
    text("Start", width/2-90, height/4+48+4);
    textFont(createFont("Minecrafter Alt", 12));
    text("click this button", width/2-90, height/4+48+16);
    fill(0,0,0,0);
    stroke(0,0,0,255);
    strokeWeight(2);
    rect(width/2+50,height/4+21,25,25);
    image(mouse,width/2+52,height/4+22,26,26);
    if(mouseX<width/2+128&&
    mouseX>width/2-128&&
    mouseY<height/4+48+8&&
    mouseY>height/4&&mousePressed) click=true;
    
    if(click){
     // for(int a=0; a<100; a++){
        load+=10;
        fill(255);
        rect(width/2-100,height/2,load*2,32);
        //delay((int)random(1,500)/5);
        if(load>=99){
      started = true;
          for(int i=0; i<10; i++){
            shapes.add(newShape());
          }
        }
     // }
    }
  }
  if (displayCursor) noCursor();
  if (displayCursor) image(mouse, mouseX-12, mouseY-8, 32, 32);
  
  if (recording) saveFrame("frames\\####.png");
  fill(255, 0, 0);
  if (recording) ellipse(width-20, 20, 10, 10);
}
