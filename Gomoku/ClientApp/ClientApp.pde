import processing.net.*;

Client client;

final int PLAYER = 2;
final int N = 15;
final int WIDTH = 40;
final int INIT_POS_X = 40;
final int INIT_POS_Y = 40;

int[][] board;
// 1: enable
// 2: disable
// 3: restart
int status = 2;

void setup() {
  client = new Client(this, "127.0.0.1", 20000);
  size(640, 640);
  textAlign(CENTER, CENTER);
  initBoard();
}

void stop() {
  client.stop();
}

void initBoard() {
  status = 2;
  board = new int[N+2][N+2];
  background(255);
  for (int i=1; i<=N; i++) {
    line(getX(i), getY(1), getX(i), getY(N));
  }
  for (int i=1; i<=N; i++) {
    line(getX(1), getY(i), getX(N), getY(i));
  }
}

int getX(int n) {
  return INIT_POS_X+WIDTH*(n-1);
}

int getY(int n) {
  return INIT_POS_Y+WIDTH*(n-1);
}

void drawCircle(int x, int y, int player) {
  if (player == 1) fill(0);
  if (player == 2) fill(255);
  ellipse(getX(x), getY(y), WIDTH*0.5, WIDTH*0.5);
}

boolean check(int x, int y) {
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
  
  if (k < 4) return true;
  else return false;
}

void mouseClicked() {
  switch (status) {
    case 1:
      int x = (mouseX-INIT_POS_X+WIDTH/2)/WIDTH+1;
      int y = (mouseY-INIT_POS_Y+WIDTH/2)/WIDTH+1;
      if (x < 1 || y < 1) return;
      if (x > N || y > N) return;
      if (board[x][y] == 0) {
        board[x][y] = PLAYER;
        drawCircle(x, y, PLAYER);
        client.write(x+" "+y+'\n');
        status = 2;
      }
      if (check(x, y)) {
        client.write("0 1\n");
        background(255);
        fill(0);
        textSize(50);
        text("YOU WIN", width/2, height/2);
        status = 3;
        restart();
      }
      break;
    case 3:
    println("ok");
      if (mouseX < width/2-100) break;
      if (mouseX > width/2+100) break;
      if (mouseY < height/2+65) break;
      if (mouseY > height/2+100) break;
      client.write("1 0\n");
      status = 1;
      initBoard();
      break;
    default:
      break;
  }
}

void restart() {
  fill(255);
  rect(width/2-100, height/2+65, 200, 35);
  fill(0);
  textSize(30);
  text("CONTINUE", width/2, height/2+80);
}

void clientEvent(Client c) {
  String s = client.readStringUntil('\n');
  if (s != null) {
    String[] ss = splitTokens(s);
      int x = int(ss[0]);
      int y = int(ss[1]);
      if(x == 0) {
        background(255);
        fill(0);
        textSize(50);
        text("YOU LOSE", width/2, height/2);
        status = 3;
        restart();
        return;
      }
      if(y == 0) {
        initBoard();
        return;
      }
      status = 1;
      board[x][y] = 1;
      drawCircle(x, y, 1);
  }
}

void draw() {
  
}
