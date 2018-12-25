public class TimePicker extends UseProc{
  
  public TimePicker(Time time){
    super();
    // WARNING: makes use of pointers
    backup = time.clone();
    this.time = time;
    float ySize = height / 4;
    
    float xSize = width / 6;
    // add + anzeige + sub + save
    buts = new Button[6 + 1 + 6 + 2];
    for(int i = 0; i < 6; i ++){
      buts[i] = new Button().setTxtCol(255).setTxt("^");
      buts[i].setCol(0);
      buts[i].setPosSize(i * xSize, 0, xSize, ySize);
      
    }
    
    buts[6] = new Button();
    buts[6].setTxtCol(255);
    buts[6].setCol(0);
    buts[6].setPosSize(0, ySize, width, ySize);
    
    for(int i = 7; i < 7 + 6; i ++){
      buts[i] = new Button().setTxtCol(255).setTxt("v");
      buts[i].setCol(0);
      buts[i].setPosSize((i - 7) * xSize, 2 * ySize, xSize, ySize);
      
    }
    
    xSize = width / 2;
    
    buts[13] = new Button();
    //buts[13].setTxtCol(255);
    //buts[13].setImg(getImg("back"));
    buts[13].setPosSize(0, height - ySize, xSize, ySize);
    
    buts[14] = new Button();
    //buts[13].setTxtCol(255);
   // buts[14].setImg(getImg("save"));
    buts[14].setPosSize(xSize, height - ySize, xSize, ySize);
    
    
    
    
  }
  
  
  Button[] buts;
  
  Time backup;
  Time time;
  //float ySize;
  
  
  public void render(){
    background(255);
    buts[6].setTxt(time.toDate());
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    
  }
  
  
  public void tickButtons(){
    int ind = -1;
    for(int i = 0; i < buts.length; i ++){
      if(buts[i].tickButton()){
        ind = i;
        // i -> what
        
        break;
      }
    }
    
    int[] toAdd = new int[6];
    if(ind < 0){
      // shouldnt happen
    }else if(ind < 6){
      toAdd[ind] = 1;
      
    } else if(ind < 7){
      // anzeige
    } else if(ind < 7 + 6){
      toAdd[ind - 7] = -1;
      
    } else if(ind < 14){
      
      time.setTime(backup);
      
      backScreen();
    } else if(ind < 15){
      
      backScreen();
    } else {
      fill(255);
      ellipse(width /2, height / 2, width, width);
      
      println("PRESSED STH IMPOSSIBLE ind: " + ind);
      
     // fill(0);
      //new TextPanel();
      
    }
    
    time.addTime(new Time(toAdd[0],
      toAdd[1],
      toAdd[2],
      toAdd[3],
      toAdd[4],
      toAdd[5]
      )
    );
    
    doRender();
    
  }
  
  
}