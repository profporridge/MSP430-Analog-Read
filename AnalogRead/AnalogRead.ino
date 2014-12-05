/*
  Based on the 'Graph' example from the Energia IDE 

  Hardware Required:
  * MSP-EXP430G2 LaunchPad
  
  Software Required: 
  * Energia
  * Processing

  Run the accompanying Processing script to view analog inputs as a chart.
*/

void setup() {
  Serial.begin(9600);
}

void loop() {

	// read the analog inputs into a string, send it out on the serial port
	char s[4*7];
	sprintf(s, "%03X,%03X,%03X,%03X,%03X,%03X,%03X",
			analogRead(A0),
			analogRead(A3),
			analogRead(A4),
			analogRead(A5),
			analogRead(A6),
			analogRead(A7),
			analogRead(A10));

  Serial.println(s);

  // delays smaller than ~100 ms seem to cause problems
  delay(150);
}
