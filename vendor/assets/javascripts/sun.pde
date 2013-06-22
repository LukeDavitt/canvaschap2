windowWidth = $(window).width()-15;
windowHeight = $(window).height()-22;

Planet sun = new Planet('sun', 25,[204, 102, 0],[156, 146, 132],windowWidth/2,windowHeight/2,500);
Planet earth = new Planet('earth', 10,[204, 102, 0],[156, 146, 132],windowWidth/4,windowHeight/4,10);

void setup()
{
	size(windowWidth, windowHeight, P3D);
	frameRate(20); 
}

//jquery resize for browser window and reset stuff for processing
$(window).resize(function() 
{

  var canvas = document.getElementById('canvasWindow');
  windowWidth = $(window).width()-15;
  windowHeight = $(window).height()-22;
  canvas.height = windowHeight;
  canvas.width = windowWidth;
  size(windowWidth,windowHeight);
});


void draw()
{
	background(200);
	sun.gravitate(earth);
	earth.update();
	earth.draw();
	sun.draw();
}


class Planet  {
  var dx,dy,force,distance;

  Planet(string nameIs, float radiusInt, int[] specularClr, int[] fillClr,X,Y,mass){
    
    this.x = X;
    this.y = Y;
    this.rotatex = 2;
    this.rotatey = 0;
    this.radius = radiusInt;
    this.name = nameIs;
    this.spcRed = specularClr[0];
    this.spcGreen = specularClr[1];
    this.spcBlue = specularClr[2];
    this.fillRed = fillClr[0];
    this.fillGreen = fillClr[1];
    this.fillBlue = fillClr[2];
    this.mass = mass;
  }

  void draw()
  {
    pushMatrix();
	    translate(this.x,this.y,0);
	    specular(this.spcRed, this.spcGreen, this.spcBlue);
	    fill(this.fillRed, this.fillGreen, this.fillBlue);
	    directionalLight(0, 255, 255, 0, 0, -1);
	    sphereDetail(40);
	    sphere(this.radius);
    popMatrix();
  }

  void update()
  {
  	this.x += dx;
  	this.y += dy;
  }

  void gravitate(body)
  {
  	dx = this.x - body.x;
  	dy = this.y - body.y;
  	distance = Math.sqrt((dx*dx)+(dy*dy));
  	dx /= distance;
  	dy /= distance;
  	force = (body.mass * this.mass)/Math.pow(distance, 2);
  	dy *= force;
  	body.dx += dx;
  	body.dy += dy;
  }
}
