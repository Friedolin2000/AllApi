
// strength: 100 -> abs, 0 -> f'(0) = 1
// in formel: große Zahl -> abs

public float intervalStart(float x, float start, float strength){
  float rV;
  if(strength >= 100){
    if(start < x){
      rV = 1;
    } else if(start == x){
      rV = 0.5;
    } else {
      rV = 0;
    }
  } else {
    rV = 1.0 / (exp((-x - start) * 100.0 / (100.0 - strength)) + 1.0);
  }
  return rV;
}

public float intervalEnd(float x, float end, float strength){
  float rV;
  if(strength >= 100){
    if(end > x){
      rV = 1;
    } else if(end == x){
      rV = 0.5;
    } else {
      rV = 0;
    }
  } else {
    rV = 1.0 / (exp((x - end) * 100.0 / (100.0 - strength)) + 1.0);
  }
  return rV;
}

public float sigmoid(float x){
  return sigmoid(x, 0);
}

public float sigmoid(float x, float strength){
  if(strength == 100){
    if(x < 0){
      return 1;
    } else if(x == 0){
      return 0.5;
    } else {
      return 0;
    }
  }
  return  1.0 / (exp(x * 100.0 / (100.0 - strength)) + 1.0);
}

public float interval(float x, float start, float end, float strength){
  float rV;
  rV = intervalStart(x, start, strength);
  rV += intervalEnd(x, end, strength);
  rV -= 1;
  
  return rV;
}


public float sigmoid(float x, float start, float end, boolean rising){
  float rV = (x - start) / (end - start);
  
  // hoe to plot x between 0 and 1 for start to end
  
  float xx = rV * rV;
  rV = 3 * xx - 2 * rV * xx;
  
  
  if(!rising){
    rV = 1 - rV;
  }
  
  
  return rV;
}


public float cap(float x, float cap, boolean up){
  float rV = x;
  
  if((up && x > cap) || (!up && x < cap)){
    rV = cap;
  }
  return rV;
}