class Square extends Shape{
  void show(){
    fill(c);
    stroke(0);
    strokeWeight(1);
    rect(pos.x-pos.z/2,pos.y-pos.z/2,pos.z,pos.z);
  };
}

class Circle extends Shape{
  void show(){
    fill(c);
    stroke(0);
    strokeWeight(1);
    ellipse(pos.x,pos.y,pos.z,pos.z);
  };
}

class Triangle extends Shape{
  void show(){
    fill(c);
    stroke(0);
    strokeWeight(1);
    triangle(pos.x-pos.z/2,pos.y-pos.z/2,pos.x+pos.z/2,pos.y-pos.z/2,pos.x,pos.y+pos.z/2);
  };
}

/*class Image extends Shape{
  PImage image = (images.get((int)random(images.size())));
  Image(){
    pos.z*=1.25;
  }
  void show(){
    image(image,pos.x-pos.z/2,pos.y-pos.z/2,pos.z,pos.z);
  }
}*/