#include <Adafruit_NeoPixel.h>

#define USER_AGE 22 //Mock

#define PIXEL_NUMBER 16

#define STRIP_PIN 3
#define BUTTON_STOP_PIN 4
#define BUZZER_PIN 5

#define BUZZER_SWITCH_TIME_MILLIS 300
#define PIXEL_BLINK_TIME_MILLIS 200

//Colors for every step of 10PPM. Look at the documentation to
//  see the ladder of colors.
const char COLOR_BY_PPM[22][3] = {
  {255, 0, 0}, {255, 0, 0}, {255, 0, 0}, {255, 0, 0},
  {255, 141, 0}, {255, 165, 0}, {255, 207, 0}, {255, 232, 0}, 
  {221, 255, 0}, {129, 253, 0}, {0, 255, 77}, {0, 255, 77}, 
  {129, 253, 0}, {221, 255, 0}, {255, 232, 0}, {255, 207, 0},
  {255, 165, 0}, {255, 141, 0}, {255, 91, 0}, {255, 0, 0},
  {255, 0, 0}, {255, 0, 0}
};

Adafruit_NeoPixel strip = 
  Adafruit_NeoPixel(PIXEL_NUMBER, STRIP_PIN, NEO_GRB + NEO_KHZ800);

int USER_PPM_TRESHOLD;
int input;
int ppm = 90;

//Alarm
unsigned long alarmSwitch = 0;
bool isAlarmOn = false;
bool isBuzzerOn = false;

//Stop butotn
bool isStopButtonActivated = false;

//Strip
unsigned long stripBlinkSwitch = 0;
bool isStripOn = false;

void setup()
{
  //Set user ppm treshold 
  USER_PPM_TRESHOLD = 220 - USER_AGE;
  
  Serial.begin(9600);
  strip.begin();
  
  //Setup buzzer
  pinMode(BUZZER_PIN, OUTPUT);
  noTone(BUZZER_PIN);
  
  //Set up button
  pinMode(BUTTON_STOP_PIN, INPUT_PULLUP);
}

void loop()
{
  getPPM();
  displayStrip();
  checkStopButton();
  determineAlarmStatus();
  alarm();
  delay(15);
}

/*
 * Desc : Read user ppm using serial monitor. It should use a 
 * 	 pulse sensor but this component isn't available in 
 *   Tinkercad :(
 * Input : void
 * Output : void
 */
void getPPM() {
  /*
   * Serial.read() read only one byte at a time so we need to
   * loop while we read every byte of the sended number.
   * Example : 123 we need to loop 3 times.
   * 
   * Building ppm in ppmRead. 
   */
  int ppmRead = 0;
  //Check the number of bytes available in serial monitor
  while(Serial.available() > 0) {
    char input = Serial.read();
    ppmRead = ppmRead * 10 + input - '0';
  }
  
  //If ppm has been entered, we set global ppm
  if(ppmRead != 0) {
    ppm = ppmRead;
  }
}

/*
 * Desc : Set the color of every NeoPixel of the strip.
 *   Every pixel will have the same color.
 *   The function strip.show() must be called after this function
 * Input : - red (char) : Quantity of red color (0-255)
 *         - green (char) : Quantity of green color (0-255)
 *         - blue (char) : Quantity of blue color (0-255)
 * Output : void
 */
void stripSetColor(char red, char green, char blue) {
  for(char i = 0; i < PIXEL_NUMBER; i++) {
    strip.setPixelColor(i, red, green, blue);
  }
}

/*
 * Desc : Make the strip blink according to the 
 *   PIXEL_BLINK_TIME_MILLIS
 * Input : void
 * Output : void
 */
void blinkStrip() {
  unsigned long now = millis();
  if(now - stripBlinkSwitch >= PIXEL_BLINK_TIME_MILLIS) {
    //Switch the blinking mode
    isStripOn = !isStripOn;
    //Reset the time before mode switch
    stripBlinkSwitch = now;
  }
  
  if(isStripOn) {
    //Turn the pixels on with red color
    stripSetColor(255, 0, 0);
  }else{
    //Turn the pixels off
    stripSetColor(0, 0, 0);
  }
}

/*
 * Desc : Turn the pixels on with the right color according
 	 to user ppm
 * Input : void
 * Output : void
 */
void displayStripColorByPpm() {
  //Determine ppm step according to ppm. Each step equals 10 ppm
  int ppmStep = ppm / 10 - 1;
  
  //Error handling if step is too low
  if(ppmStep < 0) {
    ppmStep = 0;
  }
  
  //Error handling if step is too high
  if(ppmStep > 21) {
    ppmStep = 21;
  }  
  
  //Get colors according to ppm step
  int red = COLOR_BY_PPM[ppmStep][0];
  int green = COLOR_BY_PPM[ppmStep][1];
  int blue = COLOR_BY_PPM[ppmStep][2];

  //Set pixels color
  stripSetColor(red, green, blue);
}

/*
 * Desc : Determine how to turn the light on pixels.
 * Input : void
 * Output : void
 */
void displayStrip() {
  //If ppm are too high, make the strip blink
  ppm >= USER_PPM_TRESHOLD ? 
    blinkStrip() : displayStripColorByPpm();
  
  //Display the lights
  strip.show();
}

/*
 * Desc : Check if the user pressed the button to stop alarm
 * Input : void
 * Output : void
 */
void checkStopButton() {
  int state = digitalRead(BUTTON_STOP_PIN);
  //Detect when button is LOW because we use INPUT_PULLUP
  if(state == LOW) {
    isStopButtonActivated = true;
  }
}

/*
 * Desc : Put the alarm on if ppm is too low or too high
 * Input : void
 * Output : void
 */
void determineAlarmStatus() {
  if(!isStopButtonActivated && 
     (ppm <= 40 || ppm >= USER_PPM_TRESHOLD)) {
    isAlarmOn = true;
  } else {
  	isAlarmOn = false;
  }
}

/*
 * Desc : Ring the buzzer if needed
 * Input : void
 * Output : void
 */
void alarm() {
  if(isAlarmOn){
    //Switch buzzer mode every BUZZER_SWITCH_TIME_MILLIS
    unsigned long now = millis();
    if(now - alarmSwitch > BUZZER_SWITCH_TIME_MILLIS) {
      isBuzzerOn = !isBuzzerOn;
      alarmSwitch = now;
    }

    if(isBuzzerOn) {
      //Turn the buzzer on
      tone(BUZZER_PIN, 150);
    }else{
      //Turn the buzzer off
      noTone(BUZZER_PIN);
    }
  }else{
    //Turn the buzzer off if the user pressed the STOP button
    noTone(BUZZER_PIN);
  }
}