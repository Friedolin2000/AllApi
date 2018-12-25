public class UPanel{
  
  public void init(){}
  
  public UPanel(){
    init();
    setCol(255);
    
    
    setPosSize(0, 0, width, height / 2.0);
    setOffset(0);
    
  }
  
  public UPanel setImg(PImage img){
    this.img = img;
    return this;
  }
  
  public UPanel setCol(int col){
    this.bgCol = col;
    return this;
  }
  
  public UPanel setPosSize(float xPos, float yPos, float xSize, float ySize){
    setX(xPos, xSize).setY(yPos, ySize);
    return this;
  }
  
  public UPanel setPos(float xPos, float yPos){
    setXPos(xPos).setYPos(yPos);
    return this;
  }
  
  public UPanel setSize(float xSize, float ySize){
    setXSize(xSize).setYSize(ySize);
    return this;
  }
  
  public UPanel setX(float xPos, float xSize){
    setXPos(xPos).setXSize(xSize);
    return this;
  }
  
  public UPanel setY(float yPos, float ySize){
    setYPos(yPos).setYSize(ySize);
    return this;
  }
  
  public UPanel setXPos(float xPos){
    this.xOffPos = xPos;
    this.xPos = xPos + offset;
    //this.txt.set(this.ySize);
    nevPosSize(1);
    return this;
  }
  
  public UPanel setYPos(float yPos){
    this.yOffPos = yPos;
    this.yPos = yPos + offset;
   // this.txt.setXPos(this.xPos);
    nevPosSize(2);
    return this;
  }
  
  public UPanel setXSize(float xSize){
    this.xOffSize = xSize;
    this.xSize = xSize - 2.0 * offset;
    //this.txt.setXSize(this.xSize);
    nevPosSize(3);
    return this;
  }
  
  public UPanel setYSize(float ySize){
    this.yOffSize = ySize;
    this.ySize = ySize - 2.0 * offset;
    //this.txt.setYSize(this.ySize);
    nevPosSize(4);
    return this;
  }
  
  
  public UPanel setOffset(float off){
    this.offset = off;
    // to refresh all
    this.setPosSize(xOffPos, yOffPos, xOffSize, yOffSize);
    return this;
  }
  
  public void nevPosSize(int id){}
  
  
  // well...
  
  
  
  int bgCol;
  PImage img;
  
  float offset;
  
  float xOffPos, yOffPos, xOffSize, yOffSize;
  float xPos, yPos, xSize, ySize;
  
  
  //TextManager txt;
  
  
  
  public void render(){
    if(img == null){
      fill(bgCol);
      rect(xPos, yPos, xSize, ySize);
     // txt.render();
      //super.render();
    } else {
      image(img, xPos, yPos, xSize, ySize);
    }
  }
  
  ///^$;#^#^#^#^#^#^# Button
  
  
  public boolean tickButton(){
    return isMouseOnButton();
  }
  
  public boolean isMouseOnButton(){
    //print("test: ");
    if(isMouseXOnButton()){
      //print("x");
      if(isMouseYOnButton()){
        //println("y");
        return true;
      }
    }
    //println();
    return false;
  }
  
  public boolean isMouseXOnButton(){
    if(mouseX > xPos && mouseX < xPos + xSize){
      return true;
    }
    return false;
  }
  
  public boolean isMouseYOnButton(){
    //println(yPos + " " + ySize);
      if(mouseY > yPos && mouseY < yPos + ySize){
        return true;
      }
    return false;
  }
  
  
  
}


public class UButton extends UPanel{
  
  
  public void init(){
    txt = new TextManager();
    
  }
  
  public void nevPosSize(int id){
    //println("Button.setPosSize " + xSize);
    txt.setPosSize(xPos, yPos, xSize, ySize);
    // TODO do like this or ever by itself ??
    
    
  }
  
  public UButton setTxt(TextManager txt){
    txt.setPosSize(xPos, yPos, xSize, ySize);
    this.txt = txt;
    
    return this;
  }
  
  
  public TextManager getTxt(){
    return txt;
  }
  
  TextManager txt;
  
  
  public void render(){
    super.render();
    //println("But: " + xSize + " " + ySize);
    txt.render();
    
  }
  
  
  
  
  
  
}