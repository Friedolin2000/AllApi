
public float calcTextSize(String txt, float size, float maxDif, float xSize, float ySize){
  
  if(fits(txt, size, xSize, ySize))
    return size;
  
  float above = size;
  float below = 0;
  float cur;
  try{
    while(above - below > maxDif){
      cur = below + (above - below) / 2.0;
      
      if(fits(txt, cur, xSize, ySize)){
        below = cur;
      } else {
        above = cur;
      }
    }
  } catch(Exception e){
    
  }
  return below;
}

public boolean fits(String txt, float size, float xSize, float ySize){
  textSize(size);
  
  float xS = textWidth(txt);
  if(xS > xSize)
    return false;
  
  float yS = textAscent() + textDescent();
  if(yS > ySize)
    return false;
  return true;
}



public class Screen extends UseProc{
  
  
  public Screen(){
    super();
    
    textSize = height;
    
    bg = color(255);
    panels = new Panel[0];
    
    scrollOffset = 0; // for scrolling
    // must init panels here
  }
  
  float textSize;
  
  int bg;
  
  Panel[] panels;
  
  
  
  public void init(){
    init(false);
  }
  
  public void setPosSize(){
    for(int i = 0; i < panels.length; i ++){
      panels[i].setPosSize(0, i * yUniversalSize, width, yUniversalSize);
    }
  }
  
  public void init(boolean resetTextSize){
    // the erbung must do the pos here
    // thrn call this for this v
    
    // doSetAfterRender after super.init()!!!!
    
    if(resetTextSize) // numPad is in reset cuz the textSize is static...
      textSize = height;
    calcTextSize(textSize);
    
    
    if(getAbsHeight() > 0) // should be > height but getAbsHeight() does - height before return...
      doAfterRender();
    
  }
  
  
  public void calcTextSize(float start){
    this.textSize = start;
    for(int i = 0; i < panels.length; i ++){
      textSize = panels[i].getTextSize(textSize, 1);
      
    }
    
    textSize(textSize);
  }
  
  public void tick(){
    for(int i = 0; i < panels.length; i ++){
      panels[i].tick();
    }
  }
  
  public void render(){
    background(bg);
    for(int i = panels.length - 1; i >= 0; i --){
      panels[i].render();
    }
  }
  
  public void tickButtons(){
    for(int i = 0; i < panels.length; i ++){
      if(panels[i].tickButton(mouseX, mouseY))
        return;
    }
    
  }
  
  
  // for scrolling...
  
  float scrollOffset;
  float lastY;
  
  @Override
  public void tickFirstPress(){
    super.tickFirstPress();
    
    lastY = mouseY;
    
  }
  
  @Override
  public void tickPress(int time){
    super.tickPress(time);
    
    updateScrollOffset();
  }
  
  @Override
  public void tickLastPress(int time){
    super.tickLastPress(time); // <- very important
    
    scrollOffset = updateScrollOffset();
    
  }
  
  public float updateScrollOffset(){
    return updateScrollOffset(scrollOffset + lastY - mouseY);
  }
  
  public float updateScrollOffset(float scroll){
    float rV = cutDown(scroll, 0, getAbsHeight());
    for(int i = 0; i < panels.length; i ++){
      panels[i].setScrollOffset(rV);
      
    }
    
    return rV;
  }
  
  
  
  // api now.....................
  
  public float getAbsHeight(){
    return panels.length * yUniversalSize - height;
  }
  
  public int getInd(Panel p){
    int i = 0;
    while(i < panels.length){
      if(panels[i] == p)
        return i;
      i ++;
    }
    return -1;
  }
  
}


public class PosSize {
  
  
  public PosSize(){
    end = millis();
    
  }
  
  float yOffset;
  
  float xPos, yPos, xSize, ySize;
  
  float xOldPos, yOldPos, xOldSize, yOldSize;
  float xNevPos, yNevPos, xNevSize, yNevSize;
  long start, end;
  
  
  public void setPosSize(float xP, float yP, float xS, float yS){
    setPosSize(xP, yP, xS, yS, true);
  }
  
  public void setPosSize(float xP, float yP, float xS, float yS, boolean resetScroll){
    this.xPos = this.xOldPos = this.xNevPos = xP;
    this.yPos = this.xOldPos = this.yNevPos = yP;
    this.xSize = xS;
    this.ySize = yS;
    
    if(resetScroll)
      setScrollOffset(0);
  }
  
  public void setScrollOffset(float off){
    this.yOffset = off;
  }
  
  public void tick(){
    if(millis() >= end){
      this.xPos = this.xNevPos;
      this.yPos = this.yNevPos - this.yOffset;
      return;
    }
    
    float fac = (float) (millis() - start) / (float) (end - start);
    
    this.xPos = xOldPos + (xNevPos - xOldPos) * fac;
    this.yPos = yOldPos + (yNevPos - yOldPos) * fac - yOffset;
    
  }
  
  
  public void setAnimation(int timeLength, float xP, float yP){
    start = millis();
    end = start + timeLength;
    
    this.xOldPos = this.xPos;
    this.yOldPos = this.yPos;
    
    this.xNevPos = xP;
    this.yNevPos = yP;
    
  }
  
  
}

public abstract class Panel extends PosSize {
  
  
  
  
  public float getTextSize(float now, float step){return now;}
  
  
  public abstract void render();
  
  
  public boolean tickButton(float xMouse, float yMouse){
    if(xMouse < xPos)
      return false;
    
    if(yMouse < yPos)
      return false;
    
    if(xMouse > xPos + xSize)
      return false;
    
    if(yMouse > yPos + ySize)
      return false;
    
    return this.tickButton();
  }
  // TODO stop testing if true
  public boolean tickButton() {
    // ButtonExecution
    
    return true;
  }
  
}

public class Key extends Panel{
  
  public Key(String name, Runnable run){
    this.name = name;
    this.toRun = run;
  }
  
  Runnable toRun;
  String name;
  
  @Override
  public float getTextSize(float now, float maxDist){
    return calcTextSize(name, now, maxDist, xSize, ySize);
  }
  
  public void render(){
    stroke(blackFrameCol);
    fill(255);
    rect(xPos, yPos, xSize, ySize);
    float xP = xPos + xSize / 2.0 - textWidth(name) / 2.0;
    float yP = yPos + ySize / 2.0 + (textAscent() - textDescent()) / 2.0;
    fill(0);
    text(name, xP, yP);
    
  }
  
  public boolean tickButton(){
    toRun.run();
    
    return super.tickButton();
  }
  
}


