//desired values
    float a;
    float b;
    float m;
    float n1;
    float n2;
    float n3;
    float radius;
   
    
    //interpolated values
    float aCur = 1;
    float bCur = 1;
    float mCur = 3;
    float n1Cur = 5;
    float n2Cur = 18;
    float n3Cur = 18;
    float radiusCur = 100;
    
    int steps0 = (int)random(200);
    int steps1 = (int)random(200);
    int steps2 = (int)random(200);
    
     int s1=(int)random (10);
     int s2=(int)random (10);
     int s3=(int)random (10);
    
    //tresholds
    float randomizingTreshold = 0.02f;
    float interpolationSpeed = 0.15f;
    
    //gui
    int pointColor =  color (random(255), random(255), random(255));
    int pointColor1 = color (random(255), random(255), random(255));
    int pointColor2 = color (random(255), random(255), random(255));
    
    
    
    //maximum radius for the next final supershape
    float getNextMaxR (int steps){
        float maxR = 0;
        for (int p = 0; p < steps; p++) {
            float phi = map (p, 0, steps, 0, 2*PI);
            float r = superFormula(phi, a, b, m, n1, n2, n3);   
            maxR = (Math.abs(r)>maxR)?Math.abs(r):maxR;
        }
        return maxR;
    }
    
    //the magic
    float superFormula(float phi, float a, float b, float m, float n1,
            float n2, float n3) {
        float r = (float)(Math.pow(Math.pow(Math.abs(Math.cos(m * phi / 4) / a), n2) + Math.pow(Math.abs(Math.sin(m * phi / 4) / b), n3), -1 / n1));
        return r;
    }
    
    void interpolateValues(float t){
        aCur = (int)map (t, 0, 1, aCur,  a);
        bCur = (int)map (t, 0, 1, bCur,  b);
        mCur = (int)map (t, 0, 1, mCur,  m);
        n1Cur = map (t, 0, 1, n1Cur,  n1);
        n2Cur = map (t, 0, 1, n2Cur,  n2);
        n3Cur = map (t, 0, 1, n3Cur,  n3);
        
        radiusCur = map (t, 0, 1, radiusCur,  radius);
    }
    
    //just check if it is time to reshape already
    boolean isClose (float tresh){
        boolean returnValue;
        if ((Math.abs(a-aCur)<=tresh) && (Math.abs(b-bCur)<=tresh)  && (Math.abs(n1-n1Cur)<=tresh) && (Math.abs(n2-n2Cur)<=tresh) && (Math.abs(n3-n3Cur)<=tresh)){
            returnValue = true;
        } else{
            returnValue = false;
        }
        return returnValue;
    }
    
    //generate new random values
    void randomize (){
        a=1f;
        b=a;
        m=(int)random (1, 30); //has to be an integer, otherwise the shape will be open 
        n1=random (0.1f, 30f);
        n2=random (0.1f, 30f);
        n3=random (0.1f, 30f);
    }
    
 
    void drawShapePointsInt(int radialSteps, int internalSteps, int pointColor, float outerWeight, float innerWeight) {
        float internalRadiusMultiplier = ((height*0.9f)/getNextMaxR(100))/8; //calculate scaling factor for the inner shape
        for (int p = 0; p < radialSteps; p++) {
            float phi = map (p, 0, radialSteps, 0, 2*PI);   //convert steps to radians
            float r1 = superFormula(phi, aCur, bCur, mCur, n1Cur, n2Cur, n3Cur); //"normalized" outer radius at phi 
            float r2 = superFormula(phi, a, b, m, n1, n2, n3);  //"normalized" inner radius at phi
            
            for (int i = 0; i<internalSteps; i++){
                //calculate values for the current inner step
                float rr = map (i, 0, internalSteps-1, r1, r2);
                float rad = map (i, 0, internalSteps-1, radiusCur, internalRadiusMultiplier);
                float weight = map (i, 0, internalSteps-1, outerWeight, innerWeight);
                float alpha = map (i,0, internalSteps-1, 255, 1);
                stroke (pointColor, alpha);
                strokeWeight (weight);
                float x = width/2+(float)(rr*rad*Math.cos(phi));    //simple trigonometry and scaling
                float y = height/2+(float)(rr*rad*Math.sin(phi));   //simple trigonometry and scaling
                point (x,y);
            }
        }
    }

    public void setup() {
        size(1024, 512);
        radius = 100;
        randomize();
    }
    
    public void draw() {
        background(245,247,232);
        
        if (isClose(randomizingTreshold)){
            
            //time to set new values
            randomize();
            float mR = getNextMaxR(300);
            radius = ((height*0.9f)/mR)/2;
        } else {
            //otherwise just interpolate closer to the desired values
            interpolateValues(interpolationSpeed);
            
        }
       
        
        // Draw Shape Points 
        // drawShapePointsInt(steps0, s1, pointColor, 3, random(90));
        
        // drawShapePointsInt(steps1, s2, pointColor1, 1, random(90));
        
        // drawShapePointsInt(steps2, s3, pointColor2, 1, random(90));
       
          
        drawShapePointsInt(steps2, s3, pointColor2, 1, random(90));
          
          save ("../shape2.png");
          
          // Exit Sketch
          exit();
        
    }
