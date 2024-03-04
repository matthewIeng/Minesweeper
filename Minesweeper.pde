import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private boolean winner = false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
   
    // make the manager
    Interactive.make( this );
   
    //your code to initialize buttons goes here
    //fist call to new
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for( int r =0; r < NUM_ROWS; r++){
    for (int c=0; c < NUM_COLS; c++){
      buttons[r][c] = new MSButton(r,c);
    }
    }
   
    for(int i = 0; i < NUM_BOMBS; i++)
    setMines();
}
public void setMines()
{
  int mineRows = (int)(Math.random() * 20);
  int mineCols = (int)(Math.random() * 20);
  if(mines.contains(buttons[mineRows][mineCols]) == false) {
    mines.add(buttons[mineRows][mineCols]);
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    {
   buttons[9][3].setLabel("Y");
   buttons[9][4].setLabel("O");
   buttons[9][5].setLabel("U");
   buttons[9][6].setLabel("'");
   buttons[9][7].setLabel("R");
   buttons[9][8].setLabel("E");
   buttons[9][10].setLabel("A");
   buttons[9][12].setLabel("L");
   buttons[9][13].setLabel("O");
   buttons[9][14].setLabel("S");
   buttons[9][15].setLabel("E");
   buttons[9][16].setLabel("R");
   winner = false;
}
}
public void displayWinningMessage()
{
      buttons[9][3].setLabel("C");
     buttons[9][4].setLabel("O");
     buttons[9][5].setLabel("N");
     buttons[9][6].setLabel("G");
     buttons[9][7].setLabel("R");
     buttons[9][8].setLabel("A");
     buttons[9][9].setLabel("T");
     buttons[9][10].setLabel("S");
     buttons[9][11].setLabel("Y");
     buttons[9][12].setLabel("O");
     buttons[9][13].setLabel("U");
     buttons[9][14].setLabel("W");
     buttons[9][15].setLabel("O");
     buttons[9][16].setLabel("N");
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
    return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int i = -1; i <= 1; i++){
      for(int j = -1; j <= 1;j++){
        if((i!=0 ||j!=0) && isValid(row + i, col + j) && mines.contains(buttons[row + i][col + j])){
          numMines++;
        }
      }
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed ()
    {
        clicked = true;
        if(mouseButton == RIGHT)  {
        flagged = !flagged;
        if(flagged == false)
        clicked = false; }
        else if(mines.contains(this))
        displayLosingMessage();
        else if(countMines(myRow,myCol) > 0)
        setLabel(countMines(myRow, myCol));
        
        else {
           for(int i = -1; i < 2; i++){
                        for(int j = -1; j < 2; j++){
                            if(isValid(myRow+i, myCol+j)){
                                if(buttons[myRow+i][myCol+j].clicked == false){
                                    buttons[myRow+i][myCol+j].mousePressed();
                                }
                            }
                        }
                    }
    }
    }
    public void draw ()
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) )
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
