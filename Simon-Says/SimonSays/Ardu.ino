int sensorReading[4];
int sensorValueB;
int sensorValueG;
int sensorValueY;
int sensorValueR;
int sum;
int index;
const int InB = A0;
const int InG = A1;  
const int InY = A2;
const int InR = A3;
char orderArray[100]; 
char detect;
char detectPrev;
int count;

void setup()
{ Serial.begin(9600);
  detect = 'N';
  sensorValueB = 500;
  sensorValueG = 530;
  sensorValueY = 610;
  sensorValueR = 470; 
  sum = sensorValueB + sensorValueG + sensorValueY + sensorValueR;
  index = 0;
  count = 0; 
}
void loop()
{
  do
  {
    delay(20);
    sensorValueB = analogRead(InB);
    sensorValueG = analogRead(InG);
    sensorValueY = analogRead(InY);
    sensorValueR = analogRead(InR);
    detectPrev = detect;
    detect = 'N';
    
    if ( sensorValueB > 690) //BLUE
    {
      detect = 'B';
    }
    else if ( sensorValueY > 740) //YELLOW
    {
      detect = 'Y';
    }
    else if ( sensorValueG > 680) //GREEN
    {
      detect = 'G';
    }
    else if ( sensorValueR > 610) //RED
    {
      detect = 'R';
    }
    else {
      count++;
    }
    if((detectPrev != detect)){
      if(detect != 'N'){
        count = 0;
    orderArray[index++] = detect;
    /*for(int o=0; o<index;o++){
    Serial.print(orderArray[o]);
  }
    Serial.println("");*/
    }}
 
      if(count > 30) {
        for(int o=0; o<index;o++){
    Serial.print(orderArray[o]);
      }
    Serial.println("");
    count = 0;
    delay((200*index));
    index = 0;
      }
     

    sum = sensorValueB + sensorValueG + sensorValueY + sensorValueR;
  }while(detect!='N');  
  delay(100);
}
