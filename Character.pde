class Characters {
  private float x;
  private float y;
  private float dx;
  private float dy;
  private float xbuild = 0;
  private float ybuild = 0;
  private float holdvalue = 0;
  private boolean onplatform = true;
  private static final int wide = 20;
  private float tall = 20;
  private boolean w = false;
  private boolean a = false;
  private boolean d = false;
  private int tokenCounter = 0;


  public Characters(float xcord, float ycord, float xvelocity, float yvelocity, float holdframe, boolean platform)
  {
    x = xcord;
    y = ycord;
    dx = xvelocity;
    dy = yvelocity;
    holdvalue = holdframe;
    onplatform = platform;
  }
  // displays the rectangle for the character
  public void display()
  {
    rect (x, y, wide, tall, 5);
  }
  // makes the character bounce off the vertical walls
  public void bouncex()
  {
    if (x >= width - wide || x <= 0)
    {
      dx = -dx;
    }

    if (x>width-wide)
    {
      x=width-wide-1;
    }
    if (x<0)
    {
      x=1;
    }
  }
  //makes the character treat the bottom of the game as a platform
  public void bouncey()
  {
    if (y >= height - wide)
    {
      dy = 0;
      dx = 0;
      onplatform = true;
    }
    
    if (y>height-wide)
    {
      y=height-wide-1;
    }
    
  }
  // implements gravity for the character
  public void gravity()
  {
    if (!onplatform)
    {
      dy = dy + 0.5;
    }
  }
  // moves the character according to its set velocity in each frame
  public void move()
  {
    x = dx + x;
    y = dy + y;
  }
  // returns the bottom right y-variable of the character
  public float bottomy()
  {
    return y+wide;
  }
  // returns the bottom right x-variable of the character
  public float bottomx()
  {
    return x+wide;
  }
  // returns top left x-variable of the character
  public float x()
  {
    return x;
  }
  // returns the top left x-variable of the character
  public float y()
  {
    return y;
  }
  // returns y-velocity of the character
  public float dy()
  {
    return dy;
  }
  // returns if the character is on the platform or not
  public boolean onplatformornot()
  {
    return onplatform;
  }  
  // returns if the w key is held down
  public boolean w()
  {
    return w;
  }  
  // returns if the a key is held down
  public boolean a()
  {
    return a;
  }  
  // return if the d key is held down
  public boolean d()
  {
    return d;
  }  
  // If the character is found to collide with the top of the platform in the main method, this method makes the character stop all velocity and sit on the platform
  public void collidetop(float yplatform)
  {
    dx=0;
    dy=0;
    y=yplatform-wide;
    onplatform = true;
  }  
  // If the character is foudnd to collide with the bottom of the platform in the main method, this method makes the character bounce off of the bottom of the platform
  public void collidebottom(float yplatform)
  {
    dy = dy*-0.8;
    y=yplatform+wide;
  }
  // sets the variable for if the w key is held to false
  public void upbooleanfalse()
  {
    w = false;
  }
  // sets the variable for if the a key is held to false
  public void leftbooleanfalse()
  {
    a = false;
  }
  // sets the variable for if the d key is held to false
  public void rightbooleanfalse()
  {
    d = false;
  }
  // sets the variable for if the w key is held to true
  public void upbooleantrue()
  {
    w = true;
  }
  // sets the variable for if the a key is held to true
  public void leftbooleantrue()
  {
    a = true;
  }
  // sets the variable for if the d key is held to true
  public void rightbooleantrue()
  {
    d = true;
  }
  // charges the jump to the left if the a key is held
  public void xstoreleft()
  {
    if (xbuild>-7)
    {
      xbuild = xbuild - 0.4;
    }
    holdvalue ++;
  }
  // charges the jump to the right if the d key is held
  public void xstoreright()
  {
    if (xbuild<7)
    {
      xbuild = xbuild + 0.4;
    }
    holdvalue ++;
  }
  // charges the vertical jump if the w key is held
  public void ystore()
  {
    if (ybuild>-13)
    {
      ybuild = ybuild - 0.4;
    }
    holdvalue ++;
  }
  // sets the store values to actual velocities, to make the character jump after all keys are released
  public void jump() 
  {
    if (!w && !a && !d)
    {
      if (holdvalue>0)
      {
        dy = ybuild;
        dx = xbuild;
        ybuild = 0;
        xbuild = 0;
        holdvalue = 0;
        onplatform = false;
        tall = 20;
      }
    }
  }
  // returns true if touching one token, increases token counter
  public boolean touchingToken(Token T) {
    float[] TL = {x, y};
    float[] TR = {x+wide, y};
    float[] BL = {x, y+tall};
    float[] BR = {x+wide, y+tall};

    if (
      T.radius>findDistance(T.xPos, T.yPos, TL) ||
      T.radius>findDistance(T.xPos, T.yPos, TR) ||
      T.radius>findDistance(T.xPos, T.yPos, BL) ||
      T.radius>findDistance(T.xPos, T.yPos, BR) 
      )
    {
      tokenCounter +=1;
      return true;
    } else {
      return false;
    }
  }
  // makes token disappear if character is touching it, and checks if character is touching any of the tokens
  public void checkTouchingAllTokens() {
    for (int i=0; i<manyTokens.length; i++) {
      if (touchingToken(manyTokens[i])) {
        tokenSound.rewind();
        tokenSound.play();
        manyTokens[i].disappear();
      }
    }
  }  
  // displays the token counter for the character in the top corner
  void displayTokenCounter(int xPos, color c) {
    textSize(50);
    fill(c);
    text(this.tokenCounter, xPos, 60.0);
  }
  // helper function to find the distance between the center of the circle and corners
  // of rectangles
  float findDistance(float x, float y, float[] b) {
    float x1 = x;
    float x2 = b[0];
    float y1 = y;
    float y2 = b[1];

    return (float)Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2) * 1.0);
  }
  // Checks if the character is overlapping every platform, then determines if it is colliding with the top or the bottom of the platform, and implements collidbottom and collidetop for each situation
  public void collideplatform()
  {
    for (int i=0; i<Platforms.length; i++)
    {
      if (this.x() > Platforms[i].bottomx() || Platforms[i].x() > this.bottomx())
      {
      } else if (this.y() > Platforms[i].bottomy() || Platforms[i].y() > this.bottomy())
      {
      } else if (!this.onplatformornot())
      {
        if (this.dy()>0)
        {
          this.collidetop(Platforms[i].y());
        }
        if (this.dy()<0)              
        {
          this.collidebottom(Platforms[i].y());
        }
      }
    }
  }
  // Abstracts everything that we had in the draw method into one single method in order to clean it up
  public void exist()
  {
    this.bouncey();
    this.bouncex();
    this.gravity();
    this.move();
    this.collideplatform();
    if (this.w()==true )
    {
      this.ystore();
    }
    if (this.a()==true )
    {
      this.xstoreleft();
    }
    if (this.d()==true )
    {
      this.xstoreright();
    }
    this.jump();
    if (this.w() || this.a() || this.d())
    {
      image(img1, this.x(), this.y()+5, 20, 15);
    } else
    {
      image(img1, this.x(), this.y(), 20, 20);
    }
    this.checkTouchingAllTokens();
    this.displayTokenCounter(50, #0000FF);
  }
  public void overlappingb()
  {
    if (!this.onplatformornot() && !b.onplatformornot())
    if (b.x() > this.x() || this.x() > b.bottomx())
      {
      } else if (b.y() > this.bottomy() || this.y() > b.bottomy())
      {
      } else 
      {
        float storex = dx*1.02;
        float storey = dy*1.02;
        dx = b.dx*1.02;
        dy = b.dy*1.02;
        b.dx = storex;
        b.dy = storey;
      }
  }
}
