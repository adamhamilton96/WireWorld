// WireWorld Cellular Automataon
// States
// 0 - Empty Space - Black - Does nothing
// 1 - Conductor - Yellow - Turns into Electron Head if 1 or 2 neighbours is an Electron Head
// 2 - Electron Head - Blue - Turns into an Electron Tail
// 3 - Electron Tail - Red - Turns into a Conductor

int gridSize;
int squareSize;
int[][] grid;
int [][] next;
int choice = 1;

void setup() {
  frameRate(60);
  size(600, 600);
  gridSize = 40;
  squareSize = width / gridSize;
  grid = new int[gridSize][gridSize];
  next = new int[gridSize][gridSize];
}

void draw() {
  drawGrid();
  calculateGrid();
}

void drawGrid() {
  noStroke();
  for (int j = 0; j < gridSize; j++) {
    for (int i = 0; i < gridSize; i++) {
      if (grid[i][j] == 0) fill(0);
      else if (grid[i][j] == 1) fill(255, 255, 0);
      else if (grid[i][j] == 2) fill(0, 0, 255);
      else if (grid[i][j] == 3) fill(255, 0, 0);
      rect(i * squareSize, j * squareSize, squareSize, squareSize);
    }
  }
}

void calculateGrid() {
  if (!mousePressed) {
    for (int j = 1; j < gridSize - 1; j++) {
      for (int i = 1; i < gridSize - 1; i++) {
        int neighbours = 0;
        if (grid[i - 1][j + 1] == 2) neighbours++;
        if (grid[i][j + 1] == 2) neighbours++;
        if (grid[i + 1][j + 1] == 2) neighbours++;
        if (grid[i - 1][j] == 2) neighbours++;
        if (grid[i + 1][j] == 2) neighbours++;
        if (grid[i - 1][j - 1] == 2) neighbours++;
        if (grid[i][j - 1] == 2) neighbours++;
        if (grid[i + 1][j - 1] == 2) neighbours++;
        if (grid[i][j] == 1 && (neighbours == 1 || neighbours == 2)) next[i][j] = 2;
        else if (grid[i][j] == 1) next[i][j] = 1;
        else if (grid[i][j] == 2) next[i][j] = 3;
        else if (grid[i][j] == 3) next[i][j] = 1;
      }
    }  
    grid = next;
    next = new int[gridSize][gridSize];
  }
}

void mouseDragged() {
  for (int j = 0; j < gridSize; j++) {
    for (int i = 0; i < gridSize; i++) {
      if (mouseX > squareSize * i && mouseX < squareSize * i + squareSize && mouseY > squareSize * j && mouseY < squareSize * j + squareSize) {
        if (choice == 1) grid[i][j] = 1;
        else if (choice == 2) grid[i][j] = 2;
        else if (choice == 3) grid[i][j] = 0;
      }
    }
  }
}

void mousePressed() {
  for (int j = 0; j < gridSize; j++) {
    for (int i = 0; i < gridSize; i++) {
      if (mouseX > squareSize * i && mouseX < squareSize * i + squareSize && mouseY > squareSize * j && mouseY < squareSize * j + squareSize) {
        if (choice == 1) grid[i][j] = 1;
        else if (choice == 2) grid[i][j] = 2;
        else if (choice == 3) grid[i][j] = 0;
      }
    }
  }
}

void keyPressed() {
  if (key == 'a') choice = 1;
  else if (key == 's') choice = 2;
  else if (key == 'd') choice = 3;
}
