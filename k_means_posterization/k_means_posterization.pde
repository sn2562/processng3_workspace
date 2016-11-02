//画像中に含まれる色をランダムに選んで画像全体を減色
//Constants

int level = 10;
color[] colors = new color[level];
PImage source = loadImage("source.png");
int groupIndex[];//画素ごとのグループの割当を保持する.-1番は透明色
int loop = 30;//分類の繰り返し回数

String path = year()+""+month()+""+day()+hour()+minute()+second()+"_posterization_level+"+level+"loop"+loop;


//葉書サイズ
size(500, 740);
noStroke();
groupIndex = new int[width*height];

//画像の準備と表示
int img_height = height;
source.resize(source.width*(img_height/source.height), img_height);//リサイズ
source = source.get((source.width-width)/2, 0, width, height);//画像の切り抜き

//ランダムに5色を取得して、最初のグループにする
for (int i=0; i<level; i++) {
  colors[i]= source.get(int(random(width)), int(random(height)));
  if (colors[i] == 0) //透明色ではなく、これは背景色...取得していたらやり直し
    i--;
}
//確認のため、表示とコンソールへ出力
for (int i=0; i<level; i++) {
  fill(colors[i]);
  rect(10+i*40, 10, 30, 30);
  color c = colors[i];
  println("r = " + red( c ) + ", g = " + green( c ) + 
    ", b = " + blue( c ));
}

while (loop>0) {
  //****step1****//
  //全てのピクセルについて、上記のグループで分類する
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      int index =width*j+i;
      //ピクセルの色
      color c = source.get(i, j);
      int minimam_index = 0;//色同士の距離の最小値のindex
      float[] d = new float[level];
      if (c == 0||groupIndex[index]==-1) {//透明色なら-1、または既に透明色で設定されているなら-1のままにする
        groupIndex[index]=-1;
      } else {//透明でないならグループに振り分ける
        for (int k=0; k<level; k++) {
          color g_c = colors[k];//比較するグループの色
          d[k] = sq(red(g_c)-red(c)) +
            sq(green(g_c)-green(c)) +
            sq(blue(g_c)-blue(c));//現在の色とグループの色との距離を計算
          //もし距離が今までに登録した距離より小さければ更新
          if (d[k]<d[minimam_index])
            minimam_index = k;
        }
        groupIndex[index]=minimam_index;
      }
    }
  }

  //****step2****//
  //それぞれのグループの平均色を出す
  source.loadPixels();
  float[][] averageColor = new float[level][3];
  int[] count = new int[level]; 
  for (int i =0; i<height*width; i++) {
    if (groupIndex[i]!=-1) {//色が透明でないなら
      color c = source.pixels[i];
      averageColor[groupIndex[i]][0] += red(c);
      averageColor[groupIndex[i]][1] += green(c);
      averageColor[groupIndex[i]][2] += blue(c);
      count[groupIndex[i]]++;
    }
  }
  //****step3****//
  //それぞれのグループの平均色を算出して、置き換える
  //colors[] 
  for (int i=0; i<level; i++) {
    float r = averageColor[i][0]/count[i];
    float g = averageColor[i][1]/count[i];
    float b = averageColor[i][2]/count[i];
    colors[i] = color(r, g, b);
  }

  loop--;
}

//画像のそれぞれのピクセルの値をグループの色で置き換える
for (int j = 0; j < height; j++) {
  for (int i = 0; i < width; i++) {
    int index =width*j+i;
    if (groupIndex[index]!=-1)//透明でないなら
      source.pixels[index] = colors[groupIndex[index]];
  }
}
source.updatePixels(); 
image(source, 0, 0);//表示

//結果を保存
save(path+".png");