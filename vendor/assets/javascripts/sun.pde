windowWidth = $(window).width()-15;
windowHeight = $(window).height()-22;
var centerX = windowWidth /2;
var centerY = windowHeight /2;
var yOffset = 50;
var xOffset = 100;
var yUpperLimit = centerY + yOffset;
var yLowerLimit = centerY - yOffset;
var xUpperLimit = centerX + xOffset;
var xLowerLimit = centerX - xOffset;

Planet sun = new Planet('sun', 15,[204, 102, 0],[156, 146, 132],centerX,centerY);
Planet earth = new Planet('earth', 5,[204, 102, 0],[156, 146, 132],null,centerY);

void setup()
{
	size(windowWidth, windowHeight, P3D);
	frameRate(20); 
}



void draw()
{
	background(200);
  earth.updateForEllipse();
  earth.draw();
	sun.draw();
}


class Planet  
{
  var dx,dy,force,distance;

  Planet(string nameIs, float radiusInt, int[] specularClr, int[] fillClr,X,Y){
    
    if(X)
      this.x = X;
    if(Y)
      this.y = Y;
    this.radius = radiusInt;
    this.name = nameIs;
    this.spcRed = specularClr[0];
    this.spcGreen = specularClr[1];
    this.spcBlue = specularClr[2];
    this.fillRed = fillClr[0];
    this.fillGreen = fillClr[1];
    this.fillBlue = fillClr[2];
    this.yoperator = 'sub';
    this.xoperator = 'sub';
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

  void updateForEllipse()
  {  
    if (this.y === yUpperLimit)
    {
      this.yoperator = 'sub';
    }
    else if (this.y === yLowerLimit)
    {
      this.yoperator = 'add';
    }

    if (this.x === centerX)
    {
      if (this.y > centerY)
        this.xoperator = 'sub';
      else
        this.xoperator = 'add';
    }


    switch(this.yoperator)
    {
      case 'sub':
        this.y -= 1;
        break;
      case 'add':
        this.y += 1;
        break;
      default:
        alert('something went wrong');
        return;
        break;
    }

    switch(this.xoperator)
    {
      case 'add':
        this.x = centerX + Math.sqrt(Math.pow(xOffset, 2)*(1-((Math.pow((this.y-centerY),2))/(Math.pow(yOffset,2)))));
        break;
      case 'sub':
        this.x = centerX - Math.sqrt(Math.pow(xOffset, 2)*(1-((Math.pow((this.y-centerY),2))/(Math.pow(yOffset,2)))));
        break;
      default:
        alert('something went wrong');
        return;
        break;
    }
  }



  void gravitate(body)
  {
  	dx = this.x - body.x;
  	dy = this.y - body.y;
  	distance = Math.sqrt((dx*dx)+(dy*dy));
  	dx /= distance;
  	dy /= distance;
  	force = (body.mass * this.mass)/Math.pow(distance, 2);
  	dx *= force;
  	dy *= force;
  	body.dx += dx;
  	body.dy += dy;
  }
}
