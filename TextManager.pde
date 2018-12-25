


public class TextManager extends Offset{
  
  public TextManager(){
    super();
    
    init = false;
    setCol(0);
    //println("construc");
    setAccuracy(0);
    setW(true);
    setH(true);
    setCenter(true);
    setAutoDesc(true);
    toCare = new ArrayList<TextManager>();
    
    setBelow(0);
    
    
    
    setOff = false;
  }
  
  public TextManager setPos(float xPos, float yPos){
    super.setPos(xPos, yPos);
    return this;
  }
  
  public TextManager setPosSize(float xPos, float yPos, float xSize, float ySize){
    super.setPosSize(xPos, yPos, xSize, ySize);
    //super.setPosSi
    return this;
  }
  
  
  public TextManager setVision(boolean w, boolean h){
    setW(w);
    setH(h);
    return this;
  }
  
  public TextManager setW(boolean w){
    this.w = w;
    toInit();
    return this;
  }
  
  public TextManager setH(boolean h){
    this.h = h;
    toInit();
    return this;
  }
  
  public TextManager setDesc(boolean desc){
    this.desc = desc;
    toInit();
    return this;
  }
  
  public TextManager setAutoDesc(boolean autoDesc){
    this.autoDesc = autoDesc;
    toInit();
    return this;
  }
  
  public TextManager setBelow(float below){
    this.below = below;
    toInit();
    return this;
  }
  
  public TextManager setAbove(float above){
    this.above = above;
    toInit();
    return this;
  }
  
  public TextManager setAccuracy(float acc){
    this.accuracy = acc;
    toInit();
    return this;
  }
  /*
  public TextManager setAccuracy(float acc){
    this.accuracy = acc;
    toInit();
    return this;
  }*/
  
  public float getTxtSize(){
    return txtSize;
  }
  
  public TextManager setTxt(String txt){
    this.txt = txt;
    //toInit(); ID IN SETABOVE
    float above = ySize;
    while(doesTextSizeFit(above, txt, xSize, ySize)){
      above += ySize;
      //println(above);
    }
    setAbove(above);
    
    //println("TM.setTxt: " + xOffPos);
    return this;
  }
  
  
  public void nevPosSize(int id){
    //println("TM.nevPosSize.start: " + xOffPos);
    super.nevPosSize(id);
    if(!setOff && id == 4){
      setOff = true;
      setOffset(ySize / 8.0);
      //println("setOff " + xOffPos);
    }
    
    //println("TM.nevPosSize(" + id + ").start: " + xOffPos);
  }
  
  public TextManager setCenter(boolean center){
    this.center = center;
    return this;
  }
  
  //public TextManager setCol
  
  
  
  public TextManager setXPosEnd(){
    float endPos = xPos + xSize;
    setWidthEnd();
    setYPos(endPos - xSize);
    return this;
  }
  
  // WARNING: THIS HAS TO BE LAST STATEMENT (at least after size related sthings r set)
  public TextManager setWidthEnd(){
    setXSize(getWidth());
    return this;
  }
  
  public TextManager setYPosEnd(){
    float endPos = yPos + ySize;
    setHeightEnd();
    setYPos(endPos - ySize);
    return this;
  }
  
  public TextManager setHeightEnd(){
    setYSize(getHeight());
    return this;
  }
  
  
  public TextManager addTxt(String txt){
    return addTxt(txt, xPos, yPos, xSize, ySize);
  }
  
  public TextManager addTxt(String txt, float xPos, float yPos, float xSize, float ySize){
    init();
    TextManager rV = new TextManager();
    rV.setPosSize(xPos, yPos, xSize, ySize);
    
    rV.setVision(this.w, this.h);
    // desc?
    // this desc
    /*
      this: autoDesc desc
                   0 0 -> 0
                   0 1 -> 1
                   1 0 -> if it has the so only setAutoDesc
                   1 1 -> 1
    */
    rV.setAutoDesc(this.autoDesc);
    rV.setDesc(this.desc);
    
    rV.setAccuracy(this.accuracy);
    rV.setCenter(this.center);
    // what if u setWidthEnd before this?
    
    rV.setOffset(this.offset); // where ?
    rV.setCol(this.col);
    
    // rV.setVars
    // rV.init() + this.init()
    // take smaller txtSize for both and apply in every to Care if it is in rV
    // ?
   // rV.set
    rV.setTxt(txt);
    
    rV.init();
    if(rV.getTxtSize() < this.getTxtSize()){
      this.txtSize = rV.txtSize;
      for(int i = 0; i < toCare.size(); i ++){
        toCare.get(i).txtSize = rV.txtSize;
      }
    }
    
    toCare.add(rV);
    return rV;
  }
  
  public TextManager refreshSize(){
    float low = this.getTxtSize();
    for(int i = 0; i < toCare.size(); i ++){
      if(toCare.get(i).getTxtSize() < low){
        low = toCare.get(i).getTxtSize();
      }
      
    }
    
    this.txtSize = low;
    for(int i = 0; i < toCare.size(); i ++){
      toCare.get(i).txtSize = low;
        //low = toCare.get(i).getTxtSize();
      //}
      
    }
    return this;
  }
  
  
  float below, above;
  
  boolean setOff;
  
  boolean init;
  
  boolean center;
  
  float accuracy;
  
  boolean desc;
  boolean autoDesc;
  
  boolean w, h;
  
  ArrayList<TextManager> toCare;
  String txt;
  float txtSize;
  
  
  
  
  public void toInit(){
    init = false;
  }
  
  public void init(){
    if(!init){
      init = true;
      
      if(autoDesc && !desc){
        //println("desc");
        char c;
        char[] d = new char[]{ 'q', 'y', 'p', 'g', 'j' };
        for(int i = 0; i < txt.length(); i ++){
          c = txt.charAt(i);
          for(int j = 0; j < d.length; j ++){
            if(c == d[j]){
              desc = true;
              break;
            }
          }
          
        }
      }
      // -test for Descending
      // -adjust for width if(w)
      // -adjust fot height if(h)
      //println("last");
      
      
      
      txtSize = getTextSize(txt, xOffSize, yOffSize, below, above);
      //println("but");
    } else {
      textSize(txtSize);
    }
  }
  
  public float getWidth(){
    init();
    float rV = textWidth(txt);
    rV += 2.0 * offset;
    return rV;
  }
  
  public float getHeight(){
    float rV = getTxtHeight();
    rV += 2.0 * offset;
    return rV;
  }
  
  public float getTxtHeight(){
    init();
    float rV = textAscent();
    if(desc){
      rV += textDescent();
    }
    return rV;
  }
  
  
  
  public void render(){
    //println("in");
    init();
    //println("TM.render: " + xOffPos);
    // textSize is in 
    //textSize(txtSize);
    
    //println("render " + xOffPos + " " + yOffSize);
    float yP;
    float xP;
    if(desc){
      yP = yOffPos + yOffSize / 2.0 - (textAscent() + textDescent()) / 2;
      yP += textAscent();
    } else {
      yP = yOffPos + yOffSize / 2.0 + textAscent() / 2.0;
    }
    if(center){
      xP = xOffPos + xOffSize / 2.0 - textWidth(txt)/2.0;
    } else {
      xP = xOffPos;
    }
    fill(col);
    text(txt, xP, yP);
    
    // how do u know where to draw?
    
  }
  
  
  public float getTextSize(String text, float xSize, float ySize, float below, float above){
    //float below = 0;
    //float above = ySize;
    
    // init above
    // for what?
    
    //println("where");
    // 
    float current = getAverage(new float[]{below, above});
    while((above - below > accuracy) && ((current != below) && (current != above))){
      if(doesTextSizeFit(current, text, xSize, ySize)){
        below = current;
      } else{
        above = current;
      }
      current = getAverage(new float[]{below, above});
      //println("nev Current: " + current);
    }
    
    return below;
  }
  
  public float getAverage(float[] values){
    float sum = 0;
    for(int i = 0; i < values.length; i ++){
      sum += values[i];
    }
    return sum / values.length;
  }
  
  public boolean doesTextSizeFit(float size, String text, float xSize, float ySize){
    textSize(size);
    boolean rV = true;
    // w && h
    /*
       0 0
       0 1
       1 0
       1 1
    */
    if(w){
      //println(textFitsX(text, xSize));
      rV = rV & textFitsX(text, xSize) >= 0;
    }
    if(h){
      //println(textFitsY(ySize));
      rV = rV & textFitsY(ySize) >= 0;
    } else if(!w){
      rV = false;
    }
    return rV;
  }
  
  public float textFitsX(String text, float xSize){
    return (xSize - textWidth(text))/2;
  }
  
  public float textFitsY(float ySize){
    float y = textAscent();
    if(desc){
      y += textDescent();
    }
    return (ySize - y)/2;
  }
  
  
  
}
