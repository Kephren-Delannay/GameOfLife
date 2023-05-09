final int CELL_SIZE = 100;
int probabilityOfSTartingAlive = 15;
int[][] grid;
int[][] buffer;
color alive = color(0, 200, 0);
color dead = color(0);

void setup(){
 size(500, 500);
 background(0);
 grid = new int[width/CELL_SIZE][height/CELL_SIZE];
 buffer = new int[width/CELL_SIZE][height/CELL_SIZE];
 setupGridRandom();
 drawGrid();
 drawCells();
}

void draw(){
  if(mousePressed){
    background(0);
    drawGrid();
    drawCells();
    iteration();
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

void iteration(){
  for(int x=0; x < height / CELL_SIZE; x++){
   for(int y=0; y < width / CELL_SIZE; y++){
     // visit each cell
     if(grid[x][y] == 1){
       // alive
     }else {
       // dead
     }
   }
 }
}
