

public void initUseProc(){
  yUniversalSize = height / 6.0;
  smallDist = height / 16.0;
}

float yUniversalSize;
float smallDist;

int smallPress = 300;
int animationLen = 100;

int normalFrameCol = 250;
int blackFrameCol = 50;

UseProc useProc;

boolean portrait, portraitTested;

public void testPortrait(){
  if(portraitTested){
    return;
  }
  portrait = height >= width;
  
  portraitTested = true;
}


public void nextScreen(UseProc useProc){
  nextScreen(useProc, true);
}

public void nextScreen(UseProc nev, int dir){
  nextScreen(new AnimationProc(useProc, nev, animationLen).setDir(dir), false);
  
}

public void nextScreen(UseProc nev, boolean animation){
  if(animation && useProc != null){
    nextScreen(nev, 0);
    return;
  }
  
  useProc = nev;
  
  testPortrait();
  if(portrait){
      useProc.initP();
    } else {
      useProc.initL();
    }
}


public abstract class UseProc{
  
  
  
  public UseProc(){
    doAfterRender = false;
    doRender = true;
    
    
    
    
    vibrate(); // have it?
    
  }
  
  protected boolean doAfterRender;
  protected boolean doRender;
  
  
  boolean lastPress;
  PVector firstPos;
  
  int bg;
  boolean doBg = false;
  
  public void tickButtons(){}
  public void tick(){}
  public void render(){}
  public void initP(){init();}
  public void initL(){init();}
  public void init(){}
  
  
  int buttonStartTime;
  public void tickFirstPress(){buttonStartTime = millis(); firstPos = new PVector(mouseX, mouseY);}
  public void tickPress(int elapsedTime){}
  public void tickLastPress(int totalTime){
    if(totalTime < smallPress && dist(firstPos.x, firstPos.y, mouseX, mouseY) < smallDist){
      tickButtons();
    }
  }
  
  
  
  
  public void doRender(){
    doRender(true);
  }
  
  public void doRender(boolean render){
    this.doRender = render;
  }
  
  public void doAfterRender(){
    this.setDoRender(true);
  }
  
  public void setDoRender(boolean state){
    doAfterRender = state;
  }
  
  
  public void setBg(int col){
    this.doBg = true;
    this.bg = col;
  }
  
  
  public void drawHelper(){
    
    tick();
    
    if(mousePressed){
      // here is press
      if(!lastPress) {
        // last is false; now is true -> pressbeginn
        
        tickFirstPress();
      }
      tickPress(millis() - buttonStartTime);
      
    } else if(lastPress){
      tickLastPress(millis() - buttonStartTime);
      
      // to know the time between presses
      //buttonTime = millis();
    }
    
    if(doRender){
      if(doBg)
        background(bg);
      render();
      doRender = doAfterRender;
    }
    
    lastPress = mousePressed;
    
  }
  
  
  // TODO remove?
  public void onBackScreen(){
    doRender();
  }
  
  
}


public void vibrate(){
  vibrate(100);
}

public void vibrate(long millis){
  // TODO
}

public float cutDown(float x, float min, float max){
  
  if(x < min)
    return min;
  
  if(max < min)
    max = min;
    
  if(x > max)
    return max;
  
  return x;
}



