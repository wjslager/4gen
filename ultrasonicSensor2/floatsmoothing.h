#ifndef _FLOATSMOOTHING_H_
#define _FLOATSMOOTHING_H_

class FloatSmoothing {
  public:
    FloatSmoothing(float easing);
    float smooth(float inputValue);
  protected:
    float easing;
  private:
    float outputValue;
    float distance;
};

#endif

