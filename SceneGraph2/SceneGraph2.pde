float rot_y = 0;

void setup(){
	
	size(500,500,P3D);
	
}

void draw(){
	background(0);
	
	//全体の移動
	pushMatrix();
	translate(width/2,height/2,0);
	rotateY(rot_y);
	
	//個単体の移動、姿勢変更
	pushMatrix();
	
	rotateX(PI/3);
	rotateY(PI/3);
	rotateZ(PI/3);
	fill(255,100,100);
	box(50,50,50);
	
	popMatrix();
	
	popMatrix();

	rot_y += 0.05f;
}