import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
public final static int NUM_BOMBS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

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
  int mineRows = (int)(Math.random() * 5);
  int mineCols = (int)(Math.random() * 5);
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
    //your code here
}
public void displayWinningMessage()
{
    //your code here
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
          for(int r = -1; r < 2; r++)
            for(int c = -1; c < 2; c++)
                if (isValid(myRow + r, myCol + c) && buttons[myRow][myCol].clicked == false) {
                    buttons[myRow + r][myCol + c].mousePressed();
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
