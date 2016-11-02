float x, y, z, ry;
PGraphics src;

void setup() {
	size(200, 200, P3D);
	x = width/2;
	y = height/2;
	z = 0;

	ry = 0;
	//	noLoop();


	src = createGraphics(width, height, P3D);

	createRT();
	createTR();

}
void draw() {
	src.beginDraw();

	src.pushMatrix();
	//姿勢変化
	src.translate(x,y,0);
	src.rotateX(10);
	src.rotateY(10);
	src.rotateZ(10);
	src.rotateY(ry);

	//回転
//	src.rotateY(ry);

	src.background(100);
	src.box(100);
	src.popMatrix();
	src.endDraw();
	ry += 0.01;
	pushMatrix();
	
	
//	rotateY(ry);
	image(src,0,0);
	popMatrix();
}

void drawCross() {
	int w = 10;
	line(-10, 0, 10, 0);
	line(0, -10, 0, 10);
}

//rotate - translate
void createRT(){
	src.beginDraw();
	src.pushMatrix();
	src.rectMode(CENTER);

	src.rotate(PI/8);
	src.background(100);
	src.rect(0, 0, 100, 100);
	src.save("rt-1.png");

	src.translate(100, 100, 0);
	src.background(100);
	src.rect(0, 0, 100, 100);
	src.save("rt-2.png");

	src.popMatrix();
	src.endDraw();
}
//rotate - translate
void createTR(){
	src.beginDraw();
	src.pushMatrix();
	src.rectMode(CENTER);

	src.translate(100, 100, 0);

	src.background(100);
	src.rect(0, 0, 100, 100);
	src.save("tr-1.png");

	src.rotate(PI/8);

	src.background(100);
	src.rect(0, 0, 100, 100);
	src.save("tr-2.png");

	src.popMatrix();
	src.endDraw();
}
