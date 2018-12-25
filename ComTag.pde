




public class ComTag extends UseProc {
  
  public void tick(){
    bar = ":";
    rV = "";
    
    sace();
  }
  
  String rV;
  String bar;
  
  public void a(String d){
    rV += d;
    rV += bar;
  }
  
  public void sace(){
    FileManager values = new FileManager(
    new String[]{// to set:...
      "values.txt"
    });
    
    makeData();
    values.addString(rV, true);
    delAutoSave();
    
    nextScreen(new Statistics());
  }
  
  public void makeData(){
    a(new Time().toDate());
    a("set");
    
    
    
  }
}

