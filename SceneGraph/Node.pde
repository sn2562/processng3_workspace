//基本のクラス
class Node{
	PVector pos = new PVector();//平行移動
	PVector rot = new PVector();//回転移動
	PVector scl = new PVector();//拡大縮小
	ArrayList<Node> childNodes = new ArrayList<Node>();
	
	Node(){
		scl.set(1,1,1);
	}

	void draw(){
	}

	void doDraw(){
		pushMatrix();
		translate(pos.x, pos.y, pos.z);
		rotateX(rot.x);
		rotateY(rot.y);
		rotateZ(rot.z);
		scale(scl.x, scl.y, scl.z);
		
		for(Node node:childNodes){
			node.doDraw();
		}
		
		draw();
		popMatrix();
	}
}


//平面を描画する
class Plane extends Node{
	//draw()をオーバーライドして、描画するモノを決める
	void draw(){
		fill(128,255,255);
//		rect(-50,-50,100,100);
		box(50,50,50);
		println("pos "+pos);
		println("rot "+rot);
		println("scl "+scl);
	}
}