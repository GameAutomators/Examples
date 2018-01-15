void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
  // Set digital pin 4 as Output Pin.
pinMode(4,output);
}

void loop() {
  // put your main code here, to run repeatedly:

  // Read the analog output from the pin A0.
int a=analogRead(A0);
Serial.println(a);

// Set the pin 4 to HIGH initially.
digitalWrite(4,HIGH);

//Check for the threshold value.
if(a<570)
{
  // Delay the time of appearance of 'BANG'.
  delay(30);

  // Set the pin 4 to LOW (Touch)
  digitalWrite(4,LOW);
  delay(500);
  
  // Set the pin 4 to HIGH (Release the touch)
  digitalWrite(4,HIGH);
  delay(1000);
}
}

