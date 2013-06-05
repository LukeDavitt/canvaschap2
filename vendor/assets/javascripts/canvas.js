$('document').ready(function() {
	canvasApp();
});


function canvasApp(){
	function canvasSupport(){
		return Modernizr.canvas;
	}


	if(!canvasSupport()){
		return;
	}
	else{
			var theCanvas = document.getElementById('canvas');
			var context = theCanvas.getContext('2d');
	}
	
	
	function drawScreen(){
		var pie = Math.PI;
		var x = 50;
		var y = 100;
		var width = 40;
		var height = 40;

		context.setTransform(1,0,0,1,0,0);
		context.translate(x+0.5*width,y+0.5*height);
		context.rotate(pie/4);
		context.fillStyle = 'red';
		context.fillRect(-.5*width,-.5*height,width,height);
		
		context.setTransform(1,0,0,1,0,0);
		x = 100;
		y = 100;
		width = 40;
		height = 40;
		context.translate(x+.5*width,y+.5*height);
		context.rotate(pie/3);
		context.fillStyle='red';
		context.fillRect(-.5*width,-.5*height,width,height);
		
		context.setTransform(1,0,0,1,0,0);
		x=150,
		y=100;
		context.translate(x+.5*width,y+.5*height);
		context.rotate(pie/2);
		context.fillStyle = 'red';
		context.fillRect(-.5*width,-.5*height,width,height);

		context.setTransform(1,0,0,1,0,0);
		x=200;
		context.translate(x+.5*width,y+.5*height);
		context.rotate(2*pie/3);
		context.fillStyle = 'blue';
		context.fillRect(-.5*width,-.5*height,width,height);


	}
	drawScreen();

}