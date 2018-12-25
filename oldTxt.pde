

public class TextPanel extends Panel{
  
  float accuracy;
  
  protected String text;
  protected float textSize;
  protected boolean colorSet;
  protected int colour;
  protected float xPos;
  protected float yPos;
  protected float xSize;
  protected float ySize;
  
  
  
  
  public TextPanel(String text, float xPos, float yPos, float xSize, float ySize){
    this(text, xPos, yPos, xSize, ySize, 0, ySize / 16);
  }
  
  public TextPanel(String text, float xPos, float yPos, float xSize, float ySize, float offset){
    this(text, xPos, yPos, xSize, ySize, 0, offset);
  }
  
  public TextPanel(String text, float xPos, float yPos, float xSize, float ySize, float accuracy, float offset){
    xPos += offset;
    yPos += offset;
    
    this.xSize = xSize -=  offset * 2;
    this.ySize = ySize -=  offset * 2;
    
    this.text = text;
    //this.colour = 0;
    //this.colorSet = true;
    setCol(0);
    this.accuracy = accuracy;
    this.textSize = getTextSize(text, xSize, ySize);
    textSize(this.textSize);
    this.xPos = xPos + xSize/2 - textWidth(text)/2;
    this.yPos = yPos + ySize/2 + textAscent()/2;
    
  }
  
  public TextPanel setCol(int colour){
    this.colour = colour;
    this.colorSet = true;
    return this;
  }
  
  
  public float getTextSize(String text, float xSize, float ySize){
    float below = 0;
    float above = ySize;
    
    // init above
    while(doesTextSizeFit(above, xSize, ySize)){
      above += ySize;
    }
    
    // 
    float current = getAverage(new float[]{below, above});
    while((above - below > accuracy) && ((current != below) && (current != above))){
      if(doesTextSizeFit(current, xSize, ySize)){
        below = current;
      } else{
        above = current;
      }
      current = getAverage(new float[]{below, above});
    }
    
    return below;
  }
  
  public float getAverage(float[] values){
    float sum = 0;
    for(int i = 0; i < values.length; i ++){
      sum += values[i];
    }
    return sum/values.length;
  }
  
  public boolean doesTextSizeFit(float size, float xSize, float ySize){
    textSize(size);
    return (textFitsX(xSize) >= 0) && (textFitsY(ySize) > 0);
  }
  
  public float textFitsX(float xSize){
    return (xSize - textWidth(text))/2;
  }
  
  public float textFitsY(float ySize){
    return (ySize - textAscent())/2;
  }
  
  public void render(){
    textSize(textSize);
    if(colorSet){
      fill(colour);
    }
    text(text, xPos, yPos);
  }
  
  public void render(float xPos, float yPos, float xSize, float ySize){
    this.xPos = xPos + xSize/2 - textWidth(text)/2;
    this.yPos = yPos + ySize/2 + textAscent()/2;
    
    render();
  }
  
}



