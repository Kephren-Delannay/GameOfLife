final int CELL_SIZE = 100;


int probabilityOfSTartingAlive = 15;

// Varaibles for grid state
int[][] grid;
int[][] buffer;

// Variables for colors
color alive = color(0, 200, 0);
color dead = color(0);

// Variables for timer
int interval = 1000;
int lastRecordedTime = 0;
boolean isPaused = true;


void setup(){
 size(500, 500);
 background(0);
 grid = new int[width/CELL_SIZE][height/CELL_SIZE];
 buffer = new int[width/CELL_SIZE][height/CELL_SIZE];
 setupGridRandom();
 drawGrid();
 drawCells();
 println(visitNeighbours(0,0));
}

void draw(){
  if (millis()-lastRecordedTime>interval) {
    if (!isPaused) {
      iteration();
      background(0);
      drawGrid();
      drawCells();
      lastRecordedTime = millis();
    }
  }
}

void drawGrid(){
  stroke(42);
  for(int x=0; x < height; x+= CELL_SIZE){
    line(x, 0, x, height);
   for(int y=0; y < width; y+= CELL_SIZE){
     line(0, y, width, y);
   }
  }
}

void drawCells(){
  for(int x=0; x < height / CELL_SIZE; x++){
   for(int y=0; y < width / CELL_SIZE; y++){
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
  for(int x=0; x < height / CELL_SIZE; x++){
   for(int y=0; y < width / CELL_SIZE; y++){
     // visit each cell
     int neighbours = visitNeighbours(x,y);
     if(grid[x][y] == 1){
       // alive
       if(neighbours < 2 || neighbours > 3){
          // dies
          buffer[x][y] = 0;
       }else{
          // continues living
          buffer[x][y] = 1;
       }
     }else {
       // dead
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
 arrayCopy(buffer, grid);
}
