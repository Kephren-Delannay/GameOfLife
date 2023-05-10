final int CELL_SIZE = 20;


int probabilityOfSTartingAlive = 15;

// Varaibles for grid state
int[][] grid;
int[][] buffer;

// Variables for colors
color alive = color(55, 55, 55);
color bg = color(255);
color line = color(180);

// Variables for timer
int interval = 300;
int lastRecordedTime = 0;
boolean isPaused = true;


void setup(){
 size(500, 500);
 colorMode(RGB);
 background(bg);
 grid = new int[width/CELL_SIZE][height/CELL_SIZE];
 buffer = new int[width/CELL_SIZE][height/CELL_SIZE];
 setupGridRandom();
 drawGrid();
 drawCells();
 
}

void draw(){
  
  if (millis()-lastRecordedTime>interval) {
    if (!isPaused) {
      iteration();
      drawNextState();
      lastRecordedTime = millis();
    }
  }  
  
  if(isPaused && mousePressed){
   int xCellOver = int(map(mouseX, 0, width, 0, width/CELL_SIZE));
   xCellOver = constrain(xCellOver, 0, width/CELL_SIZE - 1);
   int yCellOver = int(map(mouseY, 0, height, 0, height/CELL_SIZE));
   yCellOver = constrain(yCellOver, 0, height/CELL_SIZE - 1);
   if(buffer[xCellOver][yCellOver] == 0)
     grid[xCellOver][yCellOver] = 1;
   else
     grid[xCellOver][yCellOver] = 0;
   drawNextState();
  }
  if(isPaused && !mousePressed){
    for(int i=0; i<width/CELL_SIZE; i++){
     for(int j=0; j<height/CELL_SIZE; j++){
       copyArray(grid,buffer);
     }
    }
  }
}

void copyArray(int[][] src, int[][] dest){
 for(int i=0; i<width/CELL_SIZE; i++){
   for(int j=0; j<height/CELL_SIZE; j++){
     dest[i][j] = src[i][j];
   }
 } 
}

void drawNextState(){
   background(bg);
   drawGrid(); 
   drawCells();
}

void drawGrid(){
  stroke(line);
  for(int x=0; x < width; x+= CELL_SIZE){
    line(x, 0, x, height);
   for(int y=0; y < height; y+= CELL_SIZE){
     line(0, y, width, y);
   }
  }
}

void drawCells(){
  for(int x=0; x < width / CELL_SIZE; x++){
   for(int y=0; y < height / CELL_SIZE; y++){
     if(grid[x][y] == 1){
       fill(alive);
       rect(x*CELL_SIZE, y*CELL_SIZE, CELL_SIZE, CELL_SIZE);
     }
   }
  }
}

void setupGridRandom(){
 for(int x=0; x < height / CELL_SIZE; x++){
   for(int y=0; y < width / CELL_SIZE; y++){
     
     float p = random(100);
     int state = 0;
     if(p < probabilityOfSTartingAlive){
       state = 1;
     }
     grid[x][y] = state;
     
   }  
 } 
}

void emptyGrid(){
  for(int i=0; i<width/CELL_SIZE; i++){
   for(int j=0; j<height/CELL_SIZE; j++){
     grid[i][j] = 0;
     buffer[i][j] = 0;
   }
 }
}

int visitNeighbours(int x, int y){
  int neighbours = 0;
  for(int i=max(0, x-1); i <= min(x+1, (width/CELL_SIZE) - 1); i++){
    for(int j=max(0, y-1); j <= min(y+1, (height/CELL_SIZE) - 1); j++){
      if(i == x && j == y)
        continue;
       neighbours += grid[i][j]; 
    }
  }
  return neighbours;
}

void iteration(){
  for(int x=0; x < width / CELL_SIZE; x++){
   for(int y=0; y < height / CELL_SIZE; y++){
     // visit each cell
     int neighbours = visitNeighbours(x,y);
     if(grid[x][y] == 1){
       if(neighbours < 2 || neighbours > 3){
          // dies
          buffer[x][y] = 0;
       }else{ 
          // continues living
          buffer[x][y] = 1;
       }
     }else {
       if(neighbours == 3){
         // born
         buffer[x][y] = 1;
       }else{
         // stays dead
         buffer[x][y] = 0;
       }
     } // end if
   } // end y loop
 } // end x loop
 
 // replace the arrays
 copyArray(buffer, grid);
}

void keyPressed(){
 if(key == ' '){
   isPaused = !isPaused;
 }
 if(key == 'r' || key == 'R'){
   setupGridRandom();
   drawNextState();
 }
 if(key == 'c' || key == 'C'){
   emptyGrid();
   drawNextState();
 }
 
}
