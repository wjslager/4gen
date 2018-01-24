/*
   created by Rui Santos, http://randomnerdtutorials.com

   Complete Guide for Ultrasonic Sensor HC-SR04

    Ultrasonic sensor Pins:
        VCC: +5VDC
        Trig : Trigger (INPUT) - Pin11
        Echo: Echo (OUTPUT) - Pin 12
        GND: GND
*/

#include "floatsmoothing.h"
#include <NewPing.h>


#define TRIGGER_PIN 8
#define ECHO_PIN 9

#define TRIGGER_PIN2 2
#define ECHO_PIN2 3

#define TRIGGER_PIN3 4
#define ECHO_PIN3 5

#define MAX_DISTANCE 450


float distanceSmooth1;
float distanceSmooth2;
float distanceSmooth3;

FloatSmoothing distanceSm1(0.1);
FloatSmoothing distanceSm2(0.1);
FloatSmoothing distanceSm3(0.1);

NewPing S1(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
NewPing S2(TRIGGER_PIN2, ECHO_PIN2, MAX_DISTANCE);
NewPing S3(TRIGGER_PIN3, ECHO_PIN3, MAX_DISTANCE);

unsigned int uS1;
unsigned int uS2;
unsigned int uS3;

void setup() {
  Serial.begin (9600);
}


void loop() {
  uS1 = S1.ping_cm();
  uS2 = S2.ping_cm();
  uS3 = S3.ping_cm();

  distanceSmooth1 = distanceSm1.smooth(uS1);
  distanceSmooth2 = distanceSm2.smooth(uS2);
  distanceSmooth3 = distanceSm3.smooth(uS3);

  Serial.print("0 600 ");
  Serial.print(distanceSmooth1);
  Serial.print("\t");
  Serial.print(distanceSmooth2);
  Serial.print("\t");
  Serial.println(distanceSmooth3);

  delay(25);
}
