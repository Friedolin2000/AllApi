

public void background(int col){
  fill(col);
  rect(0, 0, width, height);
}


public class AnimationProc extends UseProc {
  
  public AnimationProc(UseProc old, UseProc nev, int timePeriod){
    super();
    this.old = old;
    this.nev = nev;
    this.start = millis();
    this.end = start + timePeriod;
    
    setDoRender(true);
    setDir(0);
  }
  
  UseProc old, nev;
  long start, end;
  
  float xSpeed, ySpeed;
  
  
  
  
  /**
    0 = right
    1 = down
    2 = left
    3 = up
    
    ... is next screen
  */
  public AnimationProc setDir(int dir){
    this.xSpeed = 0;
    this.ySpeed = 0;
   // this.xOff = 0;
    //this.yOff = 0;
    switch(dir){
      case 0:
        this.xSpeed = -width;
        //this.xOff = width;
        break;
        
      case 1:
        this.ySpeed = -height;
       // this.yOff = height;
        break;
      
      case 2:
        this.xSpeed = width;
        //this.xOff = -width;
        break;
      
      case 3:
        this.ySpeed = height;
       // this.yOff = -height;
        break;
      
    }
    return this;
  }
  
  
  public void render(){
    super.render();
    long mils = millis();
    if(mils >= end){
      nextScreen(nev, false);
    }
    
    
    float fac = (float) (mils - start) / (float) (end - start);
    float x = xSpeed * fac;
    float y = ySpeed * fac;
    translate(x, y);
    old.render();
    
    x = -xSpeed;
    y = -ySpeed;
    translate(x, y);
    nev.render();
  }
  
  
}