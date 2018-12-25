




void setup(){
  fullScreen();
  //accSetup();
  appName = this + ""; // preferably act appName... cuz the hex at end changes stimes
  frameRate(24);
  init();
  nextScreen(new Statistics());
  thread("loadAutoSave");
}

String appName;

/*
FAQ
doRender();
backScreen();

*/

int clazz;



public void c(int c){
  clazz = c;
}

public String autoSaveTime(Time t){
  String rV = "null";
  if(t != null){
    rV = t.toDate();
  }
  return rV;
}

public Time loadAutoSaveTime(String t){
  if(!t.equals("null")){
    return new Time().setStringDate(t);
  }
  return null;
}


public void autoSave(){
  thread("actAutoSave");
}

public void actAutoSave(){
  String rV = "";
  String bar = ":";
  
  //rV += events.autoSave();
  rV += bar;
  rV += clazz;
  
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[]{rV});
}

public void loadAutoSave(){
  String[] info = new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).getStrings();
  if(info.length != 1){
    // WARNING: RETURNS IF !1
    return;
  }
  
  // how is it saved?
  try{
    String[] sp = info[0].split(":");
    int ind = 0;
    
    ind ++;
    
    
    
    ind ++;
    int claz = Integer.parseInt(sp[ind]);
    switch(claz){
      case 0:
        nextScreen(new UseProc());
        break;
      
        
    }
    println(" -> all loaded");
    useProc.doRender();
  } catch(Exception e){
    println(" -> loading execrptiom: " + e);
  }
  
}



public void init(){
  
  
}




