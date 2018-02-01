// ---------------------------------------------------------------------------
// Example NewPing library sketch that pings 3 sensors 20 times a second.
// ---------------------------------------------------------------------------

#include <NewPing.h>
#include "floatsmoothing.h"

#define SONAR_NUM 4      // Number of sensors.
#define MAX_DISTANCE 200 // Maximum distance (in cm) to ping.

/*
FloatSmoothing smooth[SONAR_NUM] = {
  FloatSmoothing(0.1),
  FloatSmoothing(0.1),
  FloatSmoothing(0.1),
  FloatSmoothing(0.1)
};
*/

NewPing sonar[SONAR_NUM] = {   // Sensor object array.
  NewPing(2, 3, MAX_DISTANCE), // Each sensor's trigger pin, echo pin, and max distance to ping.
  NewPing(4, 5, MAX_DISTANCE),
  NewPing(7, 6, MAX_DISTANCE),
  NewPing(8, 9, MAX_DISTANCE)
};

void setup() {
  Serial.begin(9600); // Open serial monitor at 115200 baud to see ping results.
}

void loop() {
  for (uint8_t i = 0; i < SONAR_NUM; i++) {
    delay(100); // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
    //    Serial.print(smooth[i].smooth(sonar[i].ping_cm()));
    Serial.print(sonar[i].ping_cm());
    Serial.print(" ");
  }
  Serial.println();
}
