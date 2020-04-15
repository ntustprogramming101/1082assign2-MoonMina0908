float buttonX = 248, buttonY = 360;
float buttonHoveredX,buttonHoveredY;

int life;
float lifeX=10, lifeY=10, lifeGap=70;

float groundhogX, groundhogY, groundhogMove = 80;
float groundhogX1, groundhogY1;

float lawnHeight=15;
final float square =80;

float soldierX, soldierY;
float soldierSpeed;

float cabbageX, cabbageY;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState;

boolean right =false;
boolean left =false;
boolean down =false;
boolean up =false;


int nowTime;
int lastTime;

PImage bgImg;

PImage groundhogIdleImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;

PImage lifeImg;
PImage soilImg;
PImage soldierImg;
PImage cabbageImg;

PImage startHoveredImg, startNormalImg;
PImage restartHoveredImg, restartNormalImg;

PImage titleImg;
PImage gameoverImg;


void setup() {
	size(640, 480, P2D);
	// Enter Your Setup Code Here

  //img load
  bgImg =loadImage("img/bg.jpg");
  groundhogIdleImg =loadImage("img/groundhogIdle.png");
  groundhogDownImg =loadImage("img/groundhogDown.png");
  groundhogLeftImg =loadImage("img/groundhogLeft.png");
  groundhogRightImg =loadImage("img/groundhogRight.png");
  lifeImg =loadImage("img/life.png");
  soilImg =loadImage("img/soil.png");
  soldierImg =loadImage("img/soldier.png");
  cabbageImg =loadImage("img/cabbage.png");
  startHoveredImg =loadImage("img/startHovered.png");
  startNormalImg =loadImage("img/startNormal.png");
  restartHoveredImg =loadImage("img/restartHovered.png");
  restartNormalImg =loadImage("img/restartNormal.png");
  titleImg =loadImage("img/title.jpg");
  gameoverImg =loadImage("img/gameover.jpg");
  
  gameState = GAME_START;
  
  //soldier starting position
  soldierX=-square;
  soldierY=square*2+floor(random(4))*square;
  
  //cabbage starting position
  cabbageX=floor(random(8))*square;
  cabbageY=square*2+floor(random(4))*square;
  
  //groundhog starting position
  groundhogX = square*4;
  groundhogY = square;
  
  //life starting
  life=2;
  
}

void draw() {
	// Switch Game State
  switch(gameState){
		// Game Start
    case GAME_START :
    if(mouseX<buttonX+startNormalImg.width && mouseX>buttonX && mouseY<buttonY+startNormalImg.height && mouseY>buttonY){
      buttonHoveredX=buttonX;
      buttonHoveredY=buttonY;
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }else{
      buttonHoveredX=width;
      buttonHoveredY=height;
    }
    image(titleImg,0,0);
    image(startNormalImg,buttonX,buttonY,144,60);
    image(startHoveredImg,buttonHoveredX,buttonHoveredY,144,60);
    break;
    
		// Game Run
    case GAME_RUN :
      //bg
      image(bgImg,0,0);
      
      //lawn
      noStroke();
      fill(124,204,25);
      rect(0,square*2-15,640,square*2);
      
      //sun
      noStroke();
      fill(255,255,0);
      ellipse(width-50,height-430,125,125);
      fill(253,184,19);
      ellipse(width-50,height-430,115,115);
      
      //life
      if(life==2){
        image(lifeImg,lifeX,lifeY);
        image(lifeImg,lifeX+lifeGap,lifeY);
      }
      else if(life==3){
        image(lifeImg,lifeX,lifeY);
        image(lifeImg,lifeX+lifeGap,lifeY);
        image(lifeImg,lifeX+lifeGap*2,lifeY);
      }
      else if(life==1){
        image(lifeImg,lifeX,lifeY);
      }
      else if(life==0){
        gameState=GAME_LOSE;
      }

      
      //soil
      image(soilImg,0,square*2);
      
      //cabbage
      image(cabbageImg,cabbageX,cabbageY);
      
      //soldier
      image(soldierImg,soldierX,soldierY);
      soldierSpeed=5;
      soldierX +=soldierSpeed;
      if(soldierX == width){
        soldierX = -square;
      }
      
      //groundhog
      if(right==true){
        image(groundhogRightImg,groundhogX,groundhogY);
      }
      else if(left==true){
        image(groundhogLeftImg,groundhogX,groundhogY);
      }
      else if(down==true){
        image(groundhogDownImg,groundhogX,groundhogY);
      }
      else{image(groundhogIdleImg,groundhogX,groundhogY);}
      
      
      //boundary check
      if(groundhogX>width- groundhogIdleImg.width){
       groundhogX=width- groundhogIdleImg.width;
      }
      else if(groundhogX<0){
        groundhogX = 0;
      }
      else if(groundhogY > height-groundhogIdleImg.height){
        groundhogY = height-groundhogIdleImg.height;
      }
      
      //touch soldier
      if(groundhogY+groundhogIdleImg.height>soldierY && groundhogY < soldierY+soldierImg.height){
        if(groundhogX<soldierX+soldierImg.width && groundhogX+groundhogIdleImg.width>soldierX){
          //groundhog starting position
          groundhogX = square*4;
          groundhogY = square;
          life -= 1;

        }
      }
      
      //touch cabbage
      if(groundhogY+groundhogIdleImg.height>cabbageY && groundhogY<cabbageY+cabbageImg.height){
       if(groundhogX+groundhogIdleImg.width>cabbageX && groundhogX<cabbageX+cabbageImg.width){
         cabbageX=width;
         cabbageY=height;
        if(cabbageX==width && cabbageY==height){
         life += 1;
        }
       }
      }
      
      
      break;
		// Game Lose
    case GAME_LOSE :
      image(gameoverImg,0,0);
      
      if(mouseX<buttonX+startNormalImg.width && mouseX>buttonX && mouseY<buttonY+startNormalImg.height && mouseY>buttonY){
        buttonHoveredX=buttonX;
        buttonHoveredY=buttonY;
        if(mousePressed){
          gameState = GAME_RUN;
          groundhogX = square*4;
          groundhogY = square;
          life=2;
          cabbageX=floor(random(8))*square;
          cabbageY=square*2+floor(random(4))*square;
          soldierX=-square;
          soldierY=square*2+floor(random(4))*square; 
        }
        }else{
        buttonHoveredX=width;
        buttonHoveredY=height;
      }
      image(restartNormalImg,buttonX,buttonY,144,60);
      image(restartHoveredImg,buttonHoveredX,buttonHoveredY,144,60);
      break;
  }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case RIGHT:
        groundhogX +=square;
        nowTime = millis();
        if(nowTime-lastTime>=1){
          right=true;
          lastTime = millis();
        }
        break;
        case LEFT:
          groundhogX -=square; 
          nowTime = millis();
        if(nowTime-lastTime>=1){
          left=true;
          lastTime = millis();
        }
          break;
        case DOWN:
          groundhogY +=square; 
          nowTime = millis();
          if(nowTime-lastTime>=1){
            down=true;
            lastTime = millis();
          }
          break;
        /*case UP:groundhogY -=square; break;*/
    }
  }
}
////////
void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case RIGHT:right=false;break;
      case LEFT:left=false;break;
      case DOWN:down=false;break;
    }
  }
}
