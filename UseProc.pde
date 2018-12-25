public abstract class UseProc{
  
  // TODO maybe an int state with HashMap -> doSubRender/Tick
  
  
  public UseProc(){
    doRender = true;
    //subRender = new Runnable[0];
    
    //middlePos = height/2 - width/2;
    //middleMaxPos = middlePos + width;
    //init();
    
    first = true;
    //setupKeyBoard();
    vibrate(vibSetup);
    coolActivate();// = new Cooldown();
  }
  
  //float middlePos;
  //float middleMaxPos;
  
  protected boolean doAfterRender;
  protected boolean doRender;
  
  boolean first;
  
  boolean lastPress;
  
  protected Cooldown cool;
  
  public void tickFirst(){}
  public void tick(){}
  public void tickPressStart(){}
  public void tickPress(){}
  public void tickButtons(){}
  public void tickRelease(){}
  public void render(){}
  
  
  public void doRender(){
    setDoRender(true);
  }
  
  public void setRender(){
    setDoRender(true);
  }
  
  public void setDoRender(boolean render){
    this.doRender = render;
  }
  
  public void setAfterNextRender(boolean state){
    doAfterRender = state;
  }
  
  Cooldown starter;
  //boolean first;
  
  public void drawHelper(){
    if(first){
      thread("tickFirst");
      first = false;
    }
    
    tick();
    //println(cool);
    cool.update();
    try{
      starter.update();
    } catch(Exception e){}
    
    if(mousePressed){
      
      if(!lastPress){
        tickPressStart();
        starter = new Cooldown(start);
        //coolActivate();
      }
      
      tickPress();
      
      if(cool.isExpired() && starter.isExpired()){
        tickButtons();
        coolActivate();
      }
      
      //first = true;
    } else if(lastPress){
      if(!starter.isExpired()){
        tickButtons();
      }
      
      tickRelease();
      //lastPress
    }
    
    if(doRender){
      render();
      doRender = doAfterRender;
    }
    
    lastPress = mousePressed;
    
//    try{
//      println(starter.timer);
//    } catch(Exception e){
//      
//    }
  }
  
 
  
  
  public void coolActivate(){
    cool = new Cooldown();
  }
  /*
  public boolean isExpired(){
    return cool.isExpired();
  }
  */
  
  
  public void onBackScreen(){
    setRender();
  }
  
  
}


public void tickFirst(){
  useProc.tickFirst();
}
