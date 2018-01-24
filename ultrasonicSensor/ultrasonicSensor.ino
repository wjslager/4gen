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

FloatSmoothing distanceSm(0.05);

#define TRIGGER_PIN 8
#define ECHO_PIN 9
#define MAX_DISTANCE 450
float distanceSmooth;

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
// NewPing setup of pins and maximum distance.

void setup() {

  Serial.begin (9600);

}


void loop() {

  delay(50);
  unsigned int uS = sonar.ping_cm();
  distanceSmooth = distanceSm.smooth(uS);
  Serial.println(distanceSmooth);

}
