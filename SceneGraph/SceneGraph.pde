Node root = new Node();//全体を管理するノード
Plane plane = new Plane();//全体に含まれる子ノードとしての平面

void setup(){
	size(500,500,OPENGL);

	root.pos.set(width/2,height/2,0.0f);

	plane.rot.set(PI/3,PI/3,PI/3);


	root.childNodes.add(plane);//rootノードの子供としてplaneノードを登録
}

void draw(){
	background(0);
	//	plane.pos.x = 150.0f + sin(frameCount*0.02f)*100.0f;
	root.rot.y += 0.05f;
	//	plane.scl.y = sin(frameCount*0.03f)*0.5f+1.5f;
	root.doDraw();//全体を描画
}