#include "floatsmoothing.h"

FloatSmoothing::FloatSmoothing(float easing)
{
  this->easing = easing;
}

float FloatSmoothing::smooth(float inputValue)
{
  if (outputValue != inputValue)
  {
    outputValue += (inputValue - outputValue) * easing;
    return outputValue;
  }

  return inputValue;
}
