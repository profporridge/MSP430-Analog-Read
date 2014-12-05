/*
Based on the code in the 'Graph' example from the Energia IDE

Draws a different colored line for each value read from the MSP430's
analog input.

*/
import processing.serial.*;

Serial myPort; // The serial port
int xPos = 1; 
int step = 1;
float[] lastValues;
int serialPortIndex = 2; // The index of the serial port to connect to

void setup () {

  size(400, 300); 
  colorMode(HSB, 100);
  // List all the available serial ports
  
  if (serialPortIndex <0){
      println("You must modify the code to select which port to use. Taking the first port...");
      serialPortIndex =0;
  }
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[serialPortIndex],9600);

  myPort.bufferUntil('\n');
  background(0);
}

void draw () {
//
}

void serialEvent (Serial myPort) {

  String inString = myPort.readStringUntil('\n');
  inString = trim(inString);
  if (inString != null) {

  // break up incoming string into array
  String[] inBytes = split(inString,','); 
  // initialize the set of previous values
  if (lastValues == null)
    lastValues = new float[inBytes.length];
    
  for(int i =0; i < inBytes.length; i++){
    float inByte= float(unhex(inBytes[i]));
    inByte = map(inByte, 0, 1023, 0, height);

    // draw a line segment between the previous value 
    // and the current value. Use a different color 
    // for each line
    stroke(i*100/inBytes.length,50,100);
    line(xPos-step, height-lastValues[i], xPos, height - inByte);
   
    lastValues[i] = inByte;
    } 
    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
      xPos = 1;
    } 
    else {
      // increment the horizontal position:
      xPos+= step;
    }
    
    // draw a vertical black line to clear the old graph as we go. 
    stroke(0);
    line(xPos,height, xPos,0);
  }
}
