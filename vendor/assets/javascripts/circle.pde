
MenuBall workBall = new MenuBall('work', 30,$(window).width()-15,$(window).height()-22, 1.5,1.5,1.5,-1.5,[204, 102, 0],[156, 146, 132]);
MenuBall techBall = new MenuBall('tech', 30, $(window).width()-15,$(window).height()-22, -.75,-.75,-1.5,-1.5,[0, 51, 102],[204, 102, 0]);
MenuBall sandBall = new MenuBall('sand', 30, $(window).width()-15,$(window).height()-22, 1,1,2,-2,[204, 102, 0],[0, 51, 102]);
windowWidth = $(window).width()-15;
windowHeight = $(window).height()-22;
collision = true;
PFont font;

void setup() {
  size(windowWidth, windowHeight, P3D);
  frameRate(15); 
}

//jquery resize for browser window and reset stuff for processing
$(window).resize(function() {

  var canvas = document.getElementById('canvasWindow');
  windowWidth = $(window).width()-15;
  windowHeight = $(window).height()-22;
  canvas.height = windowHeight;
  canvas.width = windowWidth;
  size(windowWidth,windowHeight);
});

//for exploding balls, MINIMIZE OTHER BALLS
void draw() {
  background(0);
  //stroke(255, 50);
  noStroke();



  if(collision){
    if(circlesColliding(workBall.x,workBall.y,workBall.radius,techBall.x,techBall.y,techBall.radius)){
       circlesReaction(workBall,techBall);
    }

    if (circlesColliding(workBall.x,workBall.y,workBall.radius,sandBall.x,sandBall.y,sandBall.radius)){
       circlesReaction(workBall,sandBall);
    }

    if (circlesColliding(techBall.x,techBall.y,techBall.radius,sandBall.x,sandBall.y,sandBall.radius)){
       circlesReaction(techBall,sandBall);
    }
  }
  workBall.update();
  techBall.update();
  sandBall.update();
  workBall.draw();
  techBall.draw();
  sandBall.draw();

  font = loadFont("FFScala.ttf"); 

}

void mouseCheck(MenuBall ball, MenuBall ball2, MenuBall ball3){
  ballClicked(ball, ball2, ball3);
  ballClicked(ball2, ball, ball3);
  ballClicked(ball3, ball2, ball);
}

void ballClicked(MenuBall ball, MenuBall ball2, MenuBall ball3){
  if (mouseX < (ball.x+ball.radius) && mouseX >(ball.x-ball.radius)){
      if (mouseY < (ball.y+ball.radius) && mouseY >(ball.y-ball.radius)){
        
        ball.maximize = true;
        ball2.minimize = true;
        ball3.minimize = true;
        collision = false;
      }
  }
}

int circlesColliding(int x1,int y1,int radius1,int x2,int y2,int radius2){
      //compare the distance to combined radii
      int dX = x2 - x1;
      int dY = y2 - y1;
      int radii = radius1 + radius2;
        
        if ( ( dX * dX )  + ( dY * dY ) < radii * radii ) {
            return true;
        }
        else{
            return false;
        }
}

void circlesReaction(MenuBall ball1, MenuBall ball2){
  
  ball1.dx *= -1;
  if (abs(ball1.dx) > 5 || abs(ball2.dx))
    ball2.dx = (ball1.dx * -0.75);
  else
    ball2.dx = (ball1.dx * -1);
  ball1.dy *= -1;
  if (abs(ball1.dy) > 5 || abs(ball2.dy))
    ball2.dy = (ball1.dy *0.75);
  else
    ball2.dy *= (ball1.dy * -1);
  
}



class MenuBall  {
  float x,y,z,radius,rotatex,rotatey,dx,dy,rx,ry;
  string name;

  MenuBall(string nameIs, float radiusInit, float width, float height, float rX, float rY, float dX, float dY, int[] specularClr, int[] fillClr){
    
    this.x = random(2*radiusInit+50,width-2*radiusInit-15);
    this.y = random(2*radiusInit+50,height-2*radiusInit-15);
    this.rotatex = 2;
    this.rotatey = 2;
    this.radius = 1;
    this.radiusBorder = radiusInit;
    this.rx = rX;
    this.ry = rY;
    this.dx = dX;
    this.dy = dY;
    this.name = nameIs;
    this.spcRed = specularClr[0];
    this.spcGreen = specularClr[1];
    this.spcBlue = specularClr[2];
    this.fillRed = fillClr[0];
    this.fillGreen = fillClr[1];
    this.fillBlue = fillClr[2];
    this.maximize = false;
    this.minimize = false;
    this.initialize = true;
  }

  void draw(){
    pushMatrix();
    translate(this.x,this.y,0);
    specular(this.spcRed, this.spcGreen, this.spcBlue);
    fill(this.fillRed, this.fillGreen, this.fillBlue);
    //lightSpecular(255, 255, 255);
    directionalLight(0, 255, 255, 0, 0, -1);
    rotateX(this.rotatex*0.005);
      rotateY(this.rotatey*0.01);
      sphereDetail(40);
      sphere(this.radius);
      popMatrix();
  }

  void checkSpeed(){
  if (this.dx > 5 || this.dx < 5){
    if (this.dx > 0){
      this.dx -= 4;
    }
    else
      this.dx += 4;
  }
  if (this.dy > 5 || this.dy < 5){
    if (this.dy > 0){
      this.dy -= 4;
    }
    else
      this.dy += 4;
  }
}

  void update(){
    if (this.x >= windowWidth-this.radius || this.x<=0+this.radius){
      this.dx *= -1;
    }

    if (this.y >= windowHeight-this.radius || this.y<=0+this.radius){
      this.dy *= -1;
    }

    if (this.maximize){
      this.radius *= 1.1;
    }

    if (this.initialize){
      this.maximize = true;
    }

    if (this.radius > this.radiusBorder && this.initialize){
      this.initialize = false;
      this.maximize = false;
    }

    if (this.radius > windowWidth || this.radius > windowHeight){
      window.location='index.html';
    }

    if (this.minimize){
      this.radius /= 1.1;
    }


    this.rotatex+=this.rx;
      this.rotatey+=this.ry;
      this.x+=this.dx;
      this.y+=this.dy;
  }

  



}