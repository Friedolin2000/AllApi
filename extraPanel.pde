public class MoneySelector extends Button{
  
  public MoneySelector(NumB[] buttons){
    super();
    
    this.options = buttons;
    this.backup = buttons;
    
    buts = new Button[2];
    buts[0] = new Button().setTxtCol(0).setTxt("<");
    buts[0].setCol(128);
    buts[0].setPosSize(0, 0, width / 8, getSize());
    
    buts[1] = new Button().setTxtCol(0).setTxt(">");
    buts[1].setCol(128);
    buts[1].setPosSize(width - width / 8, 0, width / 8, getSize());
    
    
    setPosSize(0, 0, width, getSize());
    
    xtSize = width / 4;
    xtPos = xtSize / 2;
    
    for(int i = 0; i < options.length; i ++){
      options[i].setSize(xtSize, getSize());
    }
    refreshOptions();
    
  }
  
  public MoneySelector setStart(int start){
    this.start = start;
    keepStartInRange();
    refreshOptions();
    useProc.doRender();
    return this;
  }
  
  public MoneySelector setYPos(float v){
    super.setYPos(v);
    //println("setY: " + v);
    try{
      buts[0].setYPos(v);
      buts[1].setYPos(v);
      
      //println("option: " + options);
      for(int i = 0; i < options.length; i ++){
        options[i].setYPos(v);
      }
      //println("setY: " + v + " done " + options.length);
    } catch(Exception e){
      //println("EXCEPTION");
    }
    
    return this;
  }
  
  
  float xtPos, xtSize;
  
  int start;
  
  NumB[] options;
  Button[] buts;
  
  NumB[] backup;
  
  public float getSize(){
    return new Counter().getSize(width / 4);
  }
  
  
  public void reset(){
    backup = new NumB[options.length];
    for(int i = 0; i < backup.length; i ++){
      backup[i] = options[i].clone();
      options[i].setNum(0);
    }
    
    
    
  }
  
  public void undo(){
    this.options = backup;
  }
  
  public void render(){
    // println("rebder");
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    stroke(0);
    for(int i = start; i < start + 3 && i < options.length; i ++){
      try{
        //println(options[i].getNum());
        options[i].render();
      } catch(Exception e){
        println("catchE");
      }
      //println(i + ": " + options[i].xPos + ", " + options[i].yPos);
      
    }
    stroke(255);
    
  }
  
  public void tickButtons(){
    if(buts[0].tickButton()){
      start -= 3;
      
      keepStartInRange();
      refreshOptions();
      useProc.doRender();
    } else if(buts[1].tickButton()){
      start += 3;
      
      keepStartInRange();
      refreshOptions();
      useProc.doRender();
    }
    
    
    
    for(int i = start; i < start + 3 && i < options.length; i ++){
      try{
        options[i].tickButton();
      } catch(Exception e){}
      
    }
  }
  
  public void keepStartInRange(){
    while(start < -2){
      start += 3;
    }
    
    while(options.length - start - 1 < 0){
      //start = options.length;
      start -= 3;
    }
  }
  
  public void refreshOptions(){
    for(int i = start; i < start + 3 && i < options.length; i ++){
      try{
        options[i].setXPos(xtPos + (i - start) * xtSize);
      } catch(Exception e){}
    }
  }
  
  
  
}
public class NumB extends Button{
  
  
  public NumB(){
    super();
    setId(0);
    setNum(0);
  }
  
  
  public int id;
  public int num;
  
  public NumB setNum(int num){
    this.num = num;
    return this;
  }
  
  public NumB setId(int id){
    this.id = id;
    return this;
  }
  
  public int getNum(){
    return num;
  }
  
  public int getId(){
    return id;
  }
  
  public NumB clone(){
    //println("<NumBclone>");
    NumB rV = new NumB();
    //rV.buts = buts;
    //rV.col = col;
    //rV.img = img;
    
    rV.setPosSize(xPos, yPos, xSize, ySize);
    
    rV.txt = txt;
    rV.txtCol = txtCol;
  
    rV.active = active; // might delete
    rV.press = press;
  
    
    rV.setId(getId());
    rV.setNum(getNum());
    //println("</NumBclone>");
    return rV;
    //return null;
  }
  
}


public class Counter extends NumB{
  
  public Counter(){
    super();
    
    //this.id = 0;
    
    
    buts = new Button[2];
    buts[0] = new Button();
    buts[0].setY(yPos, xSize);
    
    buts[1] = new Button();
    
    
    setNum(0);
    
    //println(this + " contructor done " + buts);
  }
  
  
  
  public Counter setNum(int num){
    super.setNum(num);
    //this.num = num;
    try{
      
    if(num == 0){
      buts[1].setY(yPos, ySize);
      
      
    } else {
      buts[0].setTxt(num + "x");
      //
      
      buts[1].setY(yPos + xSize, ySize - xSize);
      
      //println(this + " setY: " + buts[1].yPos);
    }
    
    //println();
    } catch(Exception e){
      //println(this + " maybe exception\n" + e);
    }
    return this;
  }
  
  public Counter setYSize(float ySize){
    super.setYSize(ySize);
    try{
    buts[0].setYSize(xSize);
    setNum(num);
    } catch(Exception e){
      
    }
    return this;
  }
  
  public Counter setYPos(float yPos){
    super.setYPos(yPos);
    try{
    for(int i = 0; i < buts.length; i ++){
      buts[i].setYPos(yPos);
    }
    } catch(Exception e){}
    
    return this;
  }
  
  public Counter setXPos(float xPos){
    super.setXPos(xPos);
    try{
    for(int i = 0; i < buts.length; i ++){
      buts[i].setXPos(xPos);
    }
    } catch(Exception e){}
    return this;
  }
  
  public Counter setXSize(float xSize){
    super.setXSize(xSize);
    try{
    for(int i = 0; i < buts.length; i ++){
      buts[i].setXSize(xSize);
    }
    buts[0].setYSize(xSize);
    setNum(num);
    } catch(Exception e){}
    return this;
  }
  
  public Counter setTxtCol(int col){
    try{
    for(int i = 0; i < buts.length; i ++){
      buts[i].setTxtCol(col);
    }
    } catch(Exception e){}
    return this;
  }
  
  public Counter setTxt(String txt){
    try{
    buts[1].setTxt(txt);
    } catch(Exception e){}
    return this;
  }
  
  Button[] buts;
  
  //int num;
  //int id;
  
  
  
  public float getSize(float xSize){
    return xSize * 1.5;
  }
  
  public void render(){
    
    //println(this + " render(" + (yPos / buts[1].yPos) + "): " + getNum());
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
      //println(i + ": " + buts[i].ySize);
    }
    
  }
  
  public boolean tickButton(){
    boolean rV = super.tickButton();
    if(rV){
      if(num == 0){
        //if(buts[1].tickButton()){
          num ++;
        //}
      } else {
        if(buts[0].tickButton()){
          num ++;
        } else if(buts[1].tickButton()){
          num --;
        }
      }
      
      
      setNum(num);
      
      useProc.doRender();
    }
    return rV;
  }
  
  public Counter clone(){
    //println("<Counterclone>");
    Counter rV = new Counter();
    rV.buts = buts;
    rV.col = col;
    rV.img = img;
   // println("clone");
    rV.setPosSize(xPos, yPos, xSize, ySize);
    
    rV.txt = txt;
    rV.txtCol = txtCol;
  
    rV.active = active; // might delete
    rV.press = press;
  
    
    rV.setId(getId());
    //println("setNum: ");
    rV.setNum(getNum());
    //println(rV + " " + rV.yPos + " so: " + rV.buts[1].yPos);
    //println("</Counterclone>");
    return rV;
  }
  
  
}




public class GraphButton extends Button{
  
  public GraphButton(){
    super();
    
    
    setPointSize(0);
    setTxtHeight(ySize / 4.0);
    setOffset(txtHeight / 4);
    setGraphSize((int) abs((xSize - 2 * offset) / 12));
    setFrameCol(0);
    setLineCol(color(39, 76, 148));
    
    
    txtHeightSet = false;
    graphSizeSet = false;
  }
  
  public GraphButton setXSize(float xSize){
    super.setXSize(xSize);
    if(!graphSizeSet){
      setGraphSize((int) ((xSize - 2 * offset) / 12));
    
    }
    
    return this;
  }
  
  boolean txtHeightSet, graphSizeSet;
  
  
  public GraphButton setYSize(float ySize){
    super.setYSize(ySize);
    //refreshLine();
    if(!txtHeightSet){
      setTxtHeight(ySize / 4.0);
    }
    return this;
  }
  
  /**
    0 - 100.0
  */
  public GraphButton setGraphSize(int size){
    this.graph = new float[size]; //xPos + size * xSize / 100.0;
    graphSizeSet = true;
    return this;
  }
  
  public GraphButton setGraph(float[] graph){
    this.graph = graph;
    return this;
  }
  
  public GraphButton setPointSize(float size){
    this.pointSize = size;
    return this;
  }
  
  
  
  public String autoSave(){
    String rV = "";
    for(int i = 0; i < graph.length; i ++){
      rV += graph[i];
      if(i < graph.length - 1){
        rV += ", ";
      }
    }
    
    return rV;
  }
  
  public void loadAutoSave(String auto){
    String[] gGraph = auto.split(", ");
    if(gGraph.length == 1 && gGraph[0].equals("")){
      
      gGraph = new String[0];
    }
    
    float[] zw = new float[gGraph.length];
    for(int i = 0; i < zw.length; i ++){
      zw[i] = Float.parseFloat(gGraph[i]);
    }
    graph = zw;
    
  }
  
  
  
  public GraphButton setOffset(float off){
    this.offset = off;
    return this;
  }
  
  public GraphButton setTxtHeight(float txtHeight){
    this.txtHeight = txtHeight;
    txtHeightSet = true;
    return this;
  }
  
  public GraphButton setFrameCol(int col){
    this.frameCol = col;
    return this;
  }
  
  public GraphButton setLineCol(int lCol){
    this.lineCol = lCol;
    return this;
  }
  
  float txtHeight;
  
  float line;
  float offset;
  
  float[] graph;
  
  float pointSize;
  
  int lineCol, frameCol;
  
  
  public void render(){
    fill(col);
    rect(xPos, yPos, xSize, ySize);
    
    new TextPanel(txt, xPos, yPos, xSize, txtHeight).setCol(txtCol).render();
    
    
    float minPos = yPos + ySize - offset;
    float maxPos = yPos + txtHeight + offset / 2;
    
    float xxPos = xPos + offset;
    
    stroke(frameCol);
    line(xxPos, minPos, xxPos, maxPos);
    line(xxPos, minPos, xPos + xSize - offset, minPos);
    
    float dif = (minPos - maxPos) / 100.0;
    float last = minPos - graph[0] * dif;
    float smallSize = (xSize - 2.0 * offset) / (graph.length - 1);
    
    stroke(lineCol);
    // so that first entry is also rendered
    ellipse(xxPos, last, pointSize, pointSize);
      
    for(int i = 1; i < graph.length; i ++){
      
      line(xxPos + (i - 1) * smallSize, last, xxPos + i * smallSize, minPos - graph[i] * dif);
      last = minPos - graph[i] * dif;
      
      ellipse(xxPos + i * smallSize, last, pointSize, pointSize);
      
    }
    
    
  }
  
  
  
  public float[] getGraph(){
    return graph;
  }
  
  
  public void tickPress(){
    if(tickButton()){
     int x = (int) ((graph.length - 1) * (mouseX - offset - xPos) / (xSize - 2 * offset) + 0.5);
     if(x < 0){
       x = 0;
     } else if(x >= graph.length){
       x = graph.length - 1;
     }
     
     float y = 100 * (mouseY - offset / 2 - txtHeight - yPos) / (ySize - 1.5 * offset - txtHeight);
     if(y < 0){
       y = 0;
     } else if(y > 100){
       y = 100;
     }
     
     y = 100 - y;
     
     graph[x] = y;
     
     useProc.doRender();
    }
  }
  
  
}




