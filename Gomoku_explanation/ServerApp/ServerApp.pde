import processing.net.*;

Server server;

final int PLAYER = 1;       //1:サーバー側,2:クライアント側
final int N = 15;           //マス目の数
final int WIDTH = 40;       //1マスの幅
final int INIT_POS_X = 40;  //左上端のx座標
final int INIT_POS_Y = 40;  //左上端のy座標

int[][] board;//碁石データ
//1: 入力有効
//2: 入力無効
//3: リスタート画面
int status = 1;//入力有効

void setup() {
  server = new Server(this, 20000);
  size(640, 640);//ウィンドウのサイズ
  textAlign(CENTER, CENTER);//テキストの中央をゼロ座標にする
  initBoard();//碁盤の初期化
}

void stop() {
  server.stop();
}

//碁盤の初期化
void initBoard() {
  status = 1;
  board = new int[N+2][N+2];//碁石データの初期化
  background(255);//背景を白色にする

  //縦線の描写
  for (int i=1; i<=N; i++) {
    line(getX(i), getY(1), getX(i), getY(N));
  }
  //横線の描写
  for (int i=1; i<=N; i++) {
    line(getX(1), getY(i), getX(N), getY(i));
  }
}

//n列目のx座標を得る
int getX(int n) {
  return INIT_POS_X+WIDTH*(n-1);
}

//n行目のy座標を得る
int getY(int n) {
  return INIT_POS_Y+WIDTH*(n-1);
}

//碁石を描写
void drawCircle(int x, int y, int player) {
  if (player == 1) fill(0);//サーバー側なら黒色に塗りつぶす
  if (player == 2) fill(255);//クライアント側なら白色に塗りつぶす
  ellipse(getX(x), getY(y), WIDTH*0.5, WIDTH*0.5);//碁石の枠線の描写
}

//同プレーヤーの碁石が5つ縦，横，斜めに並んでいるか確認
boolean check(int x, int y) {
  //横方向を確認
  int j = 4, k = 0;
  for (int i=1; i<5; i++) {
    if (board[x+i][y] != PLAYER) {
      j = i-1;
      break;
    }
  }
  for (int i=1; i<5; i++) {
    if (board[x+j-i][y] != PLAYER) {
      k++;
      break;
    }
  }

  //縦方向を確認
  j = 4;
  for (int i=1; i<5; i++) {
    if (board[x][y+i] != PLAYER) {
      j = i-1;
      break;
    }
  }
  for (int i=1; i<5; i++) {
    if (board[x][y+j-i] != PLAYER) {
      k++;
      break;
    }
  }
  
  //斜め方向を確認
  j = 4;
  for (int i=1; i<5; i++) {
    if (board[x+i][y+i] != PLAYER) {
      j = i-1;
      break;
    }
  }
  for (int i=1; i<5; i++) {
    if (board[x+j-i][y+j-i] != PLAYER) {
      k++;
      break;
    }
  }
  
  //斜め方向を確認
  j = 4;
  for (int i=1; i<5; i++) {
    if (board[x+i][y-i] != PLAYER) {
      j = i-1;
      break;
    }
  }
  for (int i=1; i<5; i++) {
    if (board[x+j-i][y-j+i] != PLAYER) {
      k++;
      break;
    }
  }

  //4方向とも5つ並んでいなければ真，そうでなければ偽(k=4)
  if (k < 4) return true;
  else return false;
}

void mouseClicked() {
  switch (status) {
    case 1://入力有効
      int x = (mouseX-INIT_POS_X+WIDTH/2)/WIDTH+1;//クリックされた列を特定
      int y = (mouseY-INIT_POS_Y+WIDTH/2)/WIDTH+1;//クリックされた行を特定

      //碁盤範囲制限
      if (x < 1 || y < 1) return;
      if (x > N || y > N) return;

      //クリックされた位置に碁石があるか確認
      if (board[x][y] == 0) {
        board[x][y] = PLAYER;//碁盤上の情報を追加
        drawCircle(x, y, PLAYER);//碁石を描写
        server.write(x+" "+y+'\n');//打たれた碁石の座標を報告
        status = 2;//入力無効
      }
      if (check(x, y)) {
        server.write("0 1\n");//勝利を報告

        //勝利画面表示
        fill(255, 150);
        rect(0, 0, width, height);
        fill(0);
        textSize(50);
        text("YOU WIN", width/2, height/2);
        status = 3;
        restart();
      }
      break;
    case 3://リスタート画面
      //CONTINUEのボタン内でクリックされたか確認
      if (mouseX < width/2-100) break;
      if (mouseX > width/2+100) break;
      if (mouseY < height/2+65) break;
      if (mouseY > height/2+100) break;
      server.write("1 0\n");//リスタートの報告
      status = 1;
      initBoard();//碁盤の初期化
      break;
    default:
      break;
  }
}

//リスタート画面表示（CONTINUEのボタン）
void restart() {
  fill(255, 150);
  rect(width/2-100, height/2+65, 200, 35);
  fill(0);
  textSize(30);
  text("CONTINUE", width/2, height/2+80);
}

//クライアントイベント
void draw() {
  Client c = server.available();
  if (c != null) {
    String s = c.readStringUntil('\n');
    if (s != null) {
      String[] ss = splitTokens(s);
      int x = int(ss[0]);//x座標を得る
      int y = int(ss[1]);//y座標を得る
      if(x == 0) {
        //敗北画面表示
        fill(255, 150);
        rect(0, 0, width, height);
        fill(0);
        textSize(50);
        text("YOU LOSE", width/2, height/2);
        status = 3;
        restart();
        return;
      }
      if(y == 0) {
        initBoard();//碁盤の初期化
        return;
      }
      status = 1;//入力有効
      board[x][y] = 2;//碁盤上の碁石情報追加
      drawCircle(x, y, 2);//相手側の碁石を追加
    }
  }
}
