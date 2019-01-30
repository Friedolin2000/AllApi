import android.os.Environment;
import android.os.Vibrator;
import android.content.Context;

int vibSetup = 100;
int vibStand = 75;
int vibBut = 25;

float tpsCool = 4.5;
float start = 1;


void draw(){
  useProc.drawHelper();
}

UseProc useProc;
ArrayList<UseProc> lastUsedProc = new ArrayList<UseProc>();

public void nextScreen(UseProc nev){
  lastUsedProc.add(useProc);
  useProc = nev;
  useProc.doRender(); // useless but comes in handy when u dont use backScreen
  //accScreen(true);
}

public void backScreen(){
  
  try{
    
    UseProc nev = lastUsedProc.remove(lastUsedProc.size() - 1);
    //println("how did this work?");
    if(nev != null){
      useProc = nev;
    } else {
      println("got null in backScreen: " + this);
    }
  } catch(Exception e){
    println("Error in backScreen(" + e + "): " + this);
  }
  useProc.onBackScreen();
  useProc.setRender();
  //accScreen(false);
}

public void delAutoSave(){
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[0]);
}


//#^#^#^#^#^#^#^#^#^#^#^
/**
  only removes 1 entry that is same as data
*/
public String[] remove(String[] info, String data){
  // TODO
  //println(info);
  boolean removed = false;
  String[] rV = new String[info.length - 1];
  for(int i = 0; i < info.length; i ++){
    //println("i: " + i);
    if(removed){
      rV[i - 1] = info[i];
    } else {
      if(info[i].equals(data)){
        removed = true;
      } else if(i < rV.length) {
        
        rV[i] = info[i];
        
      }
    }
    //println(rV);
  }
  if(removed){
    return rV;
  }
  // if nothing got removed... its the old
  return info;
}
//#&#^#^#^#&#&#^#&#&#&#&#&#^


void onResume(){
  super.onResume();
  //accResume();
  try{
    useProc.setDoRender(true);
  }catch(Exception e){}
  super.onResume();
}

void onPause(){
  super.onPause();
  //accPause();
}






public void vibrate(int millis){
  ((Vibrator) getActivity().getSystemService(Context.VIBRATOR_SERVICE)).vibrate(millis);
}






public class Cooldown{
  
  public Cooldown(){
    this(tpsCool);
  }
  
  public Cooldown(float tps){
    this((int) (frameRate/tps));
  }
  
  public Cooldown(int cooldown){
    this.timer = cooldown;
  }
  
  int timer;
  
  public void update(){
    timer --;
  }
  
  public boolean isExpired(){
    if(timer < 1){
      return true;
    }
    return false;
  }
  
}


public int randFunc(int start, float prly, boolean canBeNeg){
  int rV = 0;
  while(random(100) < prly){
    rV ++;
  }
  
  
  
  if(canBeNeg && random(1) < 0.5){
    rV *= -1;
  }
  return start + rV;
}




// removes the .0 in float strings
public String intify(float num){
  String rV = num + "";
  try{
    if(rV.split("\\.")[1].equals("0")){
      rV = rV.split("\\.")[0];
    }
  } catch(Exception e){}
  return rV;
}

public float squareSpiral(float x, float y){
  // TODO maybe a parameter to select the direction the spiral is going
  float a = abs(abs(x) - abs(y)) + abs(x) + abs(y);
  float rV = a * a + (a + x - y) * sign(x + y + 0.1) + 1.0;

  //rV =  x * x + y * y;
  
  return rV;
}

public float sign(float in){
  if(in < 0){
    return -1;
  } else if(in > 0){
    return 1;
  }
  return in; // cuz if 0 its 0
}





public int randFunc(int start, int steps, float prly, boolean canBeNeg){
  int rV = 0;
  
  while(random(100) >= prly){
    rV ++;
  }
  
  if(canBeNeg && random(1) < 0.5){
    rV *= -1;
  }
  return start + rV * steps;
}


public float nkingsRand(float max, float exponent){
  return pow(random(1), exponent) * max;
}



public String makeString(float[] in){
  String rV = "[";
  for(int i = 0; i < in.length; i ++){
    rV += in[i];
    if(i < in.length - 1){
      rV += ", ";
    }
  }
  
  return rV + "]";
}



public int convertColor(float value, float[] pos, int[] cols){
  for(int i = 0; i < pos.length; i ++){
    if(value < pos[i]){
      int down = cols[i - 1];
      int up = cols[i];
      float dif = (value - pos[i - 1]) / (pos[i] - pos[i - 1]);
      
      return color(
        red(down) + dif * (red(up) - red(down)),
        green(down) + dif * (green(up) - green(down)),
        blue(down) + dif * (blue(up) - blue(down)));
    }
  }
  return cols[cols.length - 1];
}











