
public class NumPad extends Panel{
  
  public NumPad(Number num, float yH){
    super();
    state = false;
    
    this.num = num;
    
    
    w = 5;
    int h = 3;
    String[] keys = new String[]{
      "7", "8", "9", "^", "^",
      "4", "5", "6", "v", "v",
      "1", "2", "3", "0", "<"
    };
    
    Runnable[] runnable = new Runnable[]{
      new NumKey(num, 7),
      new NumKey(num, 8),
      new NumKey(num, 9),
      new NumAdd(num, 10),
      new NumAdd(num, 1),
      new NumKey(num, 4),
      new NumKey(num, 5),
      new NumKey(num, 6),
      new NumAdd(num, -10),
      new NumAdd(num, -1),
      new NumKey(num, 1),
      new NumKey(num, 2),
      new NumKey(num, 3),
      new NumKey(num, 0),
      new NumDel(num)
      
      
    };
    
    float yP = height - yH;
    float xS = (float) width / (float) w;
    float yS = (float) yH / (float) h;
    super.setPosSize(0, yP, xS, yS);
    
    panels = new Panel[keys.length];
    for(int i = 0; i < keys.length; i ++){
      panels[i] = new Key(keys[i], runnable[i]);
      panels[i].setPosSize((i % w) * xS, height, xS, yS);
      
    }
    
    
    state = false;
    overlapping = true;
    animate = true;
    
  }
  
  
  int w;
  
  Number num;
  boolean animate;
  boolean overlapping;
  
  Panel[] panels;
  boolean state;
  
  
  public void setOverlapping(boolean over){
    this.overlapping = over;
    if(!state)
      this.setState(state);
  }
  
  
  public void setState(boolean state){
    this.state = state;
    
    
    int animation = 0;
    if(animate){
      animation = animationLen;
    }
    
    if(state)
      appear(animation);
    else
      disappear(animation);
    
  }
  
  public void disappear(int a){
    if(overlapping)
      disappearOver(a);
    else
      disappearSeperate(a);
  }
  
  public void disappearOver(int animation){
    for(int i = 0; i < panels.length; i ++){
      panels[i].setAnimation(animation, panels[i].xPos, height);
    }
  }
  
  public void disappearSeperate(int animation){
    for(int i = 0; i < panels.length; i ++){
      panels[i].setAnimation(animation, panels[i].xPos, height + (i / w) * ySize);
    }
    
  }
  
  public void appear(int animation){
    
    for(int i = 0; i < panels.length; i ++){
      panels[i].setAnimation(animation, panels[i].xPos, yPos + (i / w) * ySize);
    }
  }
  
  public boolean getState(){
    return this.state;
  }
  
  public float getTextSize(float now, float step){
    for(int i = 0; i < panels.length; i ++){
      now = panels[i].getTextSize(now, step);
    }
    return now;
  }
  
  public void render(){
    for(int i = panels.length - 1; i >= 0; i --){
      panels[i].render();
    }
    
  }
  
  public void tick(){
    for(int i = 0; i < panels.length; i ++){
      panels[i].tick();
    }
  }
  
  public boolean tickButton(){
    for(int i = panels.length - 1; i >= 0; i --){
      panels[i].tickButton(mouseX, mouseY);
    }
    return super.tickButton();
  }
  
  
}



public class Number {
  
  int num;
  // TODO sth if it doesnt have a value....
  
  
  public int getNum(){
    return num;
  }
  
  
  public String getStr(){
    return getNum() + "";
  }
}

public class NumKey implements Runnable{
  
  public NumKey(Number num, int n){
    this.num = num;
    this.n = n;
  }
  
  Number num;
  int n;
  
  public void run(){
    num.num = num.num * 10 + n;
  }
  
}


public class NumDel implements Runnable{
  
  public NumDel(Number num){
    this.num = num;
    
  }
  
  Number num;
  
  
  public void run(){
    num.num = num.num / 10;
  }
  
}


public class NumAdd implements Runnable{
  
  public NumAdd(Number num, int n){
    this.num = num;
    this.n = n;
  }
  
  Number num;
  int n;
  
  public void run(){
    num.num += n;
    if(num.num < 0){
      num.num = 0;
    }
  }
  
  
  
}