/*
    Ultrasonic sensor Pins:
        VCC: +5VDC
        Trig : Trigger (INPUT) - Pin11
        Echo: Echo (OUTPUT) - Pin 12
        GND: GND
*/

#include "floatsmoothing.h"
#include <NewPing.h>


#define TRIGGER_PIN1 8
#define ECHO_PIN1 9

#define TRIGGER_PIN2 2
#define ECHO_PIN2 3

#define TRIGGER_PIN3 4
#define ECHO_PIN3 5

#define TRIGGER_PIN4 4
#define ECHO_PIN3 5

#define MAX_DISTANCE 450

float distanceSmooth1;
float distanceSmooth2;
float distanceSmooth3;
float distanceSmooth4;

FloatSmoothing distanceSm1(0.1);
FloatSmoothing distanceSm2(0.1);
FloatSmoothing distanceSm3(0.1);
FloatSmoothing distanceSm4(0.1);

NewPing S1(TRIGGER_PIN1, ECHO_PIN1, MAX_DISTANCE);
NewPing S2(TRIGGER_PIN2, ECHO_PIN2, MAX_DISTANCE);
NewPing S3(TRIGGER_PIN3, ECHO_PIN3, MAX_DISTANCE);
NewPing S4(TRIGGER_PIN4, ECHO_PIN4, MAX_DISTANCE);

unsigned int uS1;
unsigned int uS2;
unsigned int uS3;
unsigned int uS4;

void setup() {
  Serial.begin (9600);
}


void loop() {
  uS1 = S1.ping_cm();
  uS2 = S2.ping_cm();
  uS3 = S3.ping_cm();
  uS4 = S4.ping_cm();

  distanceSmooth1 = distanceSm1.smooth(uS1);
  distanceSmooth2 = distanceSm2.smooth(uS2);
  distanceSmooth3 = distanceSm3.smooth(uS3);
  distanceSmooth4 = distanceSm3.smooth(uS4);

  //Serial.print("0 600 ");
  Serial.print(distanceSmooth1, DEC);
  Serial.print(" ");
  Serial.print(distanceSmooth2, DEC);
  Serial.print(" ");
  Serial.println(distanceSmooth3, DEC);

  delay(25);
}
