#include "floatsmoothing.h"

FloatSmoothing::FloatSmoothing(float easing)
{
  this->easing = easing;
}

float FloatSmoothing::smooth(float inputValue)
{
  if (outputValue != inputValue)
  {
    distance = inputValue - outputValue;
    outputValue += distance * easing;
    return outputValue;
  }

  return inputValue;
}

