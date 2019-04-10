# Mach1DecodePositional API

Mach1DecodePositional allows the 3DOF orientation decoding to decode in a dev environment that supports 6DOF with positional movement. It does this by referencing the user's device to a location and adding an additional layer of rotations and attenuations to the spatial decoding. 

## Unity & Unreal Engine

Please view the examples in `examples/Unity|UnrealEngine` to see deployment of Mach1Spatial mixes with positional rotation and attenuation applied. These fucntions can be viewed from the M1Base class used in both examples and are called by creating a new object in the game engine and attaching Mach1SpatialActor or Mach1SpatialDecode.cs to view the setup for a Mach1 Spatial mix layer. 

> These implementation require the multichannel mixes to be split into multiple-mono mixes. You can use `m1-transcode` or the M1-Transcoder GUI application to achieve this easily. 

## Summary Use

The Mach1DecodePositional API is designed to be added if 6DOF or positional placement of Mach1Decode objects are needed. Once added and used for updating the object's and referencable device/camera it will calculate the positional and rotational angles and distances and result them via the same useable coefficients that are used for Mach1Decode, as per the following way:

Setup Step (setup/start):

```cpp
void setup(){
    mach1DecodePositional.setDecodeAlgoType(Mach1DecodeAlgoSpatial);
    mach1DecodePositional.setPlatformType(Mach1PlatformDefault);
    mach1DecodePositional.setUseFalloff(bool useFalloff);
    mach1DecodePositional.setFalloffCurve(float falloffCurve);
    mach1DecodePositional.setUseClosestPointRotationMuteInside(bool useClosestPointRotationMuteInside);
}
void loop(){
    mach1DecodePositional.setCameraPosition(Mach1Point3D devicePos);
    mach1DecodePositional.setCameraRotation(Mach1Point3D deviceRot);
    mach1DecodePositional.setDecoderAlgoPosition(Mach1Point3D objPos);
    mach1DecodePositional.setDecoderAlgoRotation(Mach1Point3D objRot);
    mach1DecodePositional.setDecoderAlgoScale(Mach1Point3D objScale);

    mach1DecodePositional.getDist();
    mach1DecodePositional.getVolumesWalls(float* result);
}
```

 - `setDecodeAlgoType`
 - `setPlatformType`
 - `setUseFalloff` set distance attenuation for soundfield
 - `setFalloffCurve` design custom distance attenuation curves
 - `setUseClosestPointRotationMuteInside` reference rotations use a plane instead of a point, or closest plane of a shape if needed

Audio Loop:

 - update device/camera position & rotation (can use Euler or Quat)
 - update m1obj decode position & rotation (can use Euler or Quat)
 - `getDist` used for attenuation/falloff results
 - `getVolumesWalls` resulting coeffs for players

## Installation

Import and link the appropriate target device's / IDE's library file. 

For Unity: 
 - Import the Custom Asset Package

For Unreal Engine: 
 - Add the Mach1Spatial Plugin to your project

<aside class="notice">Requires libMach1DecodeCAPI for reference to spatial object and orientation decoding</aside>

## Setup per Spatial Soundfield Position

void setUseFalloff(bool useFalloff);
void setFalloffCurve(float falloffCurve);
void setAttenuationCurve(float* curve);
void setUseClosestPointRotationMuteInside(bool useClosestPointRotationMuteInside);
void setFilterSpeed(float filterSpeed);

## Setup for Advanced Settings 

void setUseBlendMode(bool useBlendMode);
void setFalloffCurveBlendMode(float falloffCurveBlendMode);

void setIgnoreTopBottom(bool ignoreTopBottom);
void setMuteWhenOutsideObject(bool muteWhenOutsideObject);
void setMuteWhenInsideObject(bool muteWhenInsideObject);

void setUseYawForRotation(bool useYawForRotation);
void setUsePitchForRotation(bool usePitchForRotation);
void setUseRollForRotation(bool useRollForRotation);

## Update per Spatial Soundfield Position

void setCameraPosition(Mach1Point3DCore* pos);
void setCameraRotation(Mach1Point3DCore* euler);
void setCameraRotationQuat(Mach1Point4DCore* quat);
void setDecoderAlgoPosition(Mach1Point3DCore* pos);
void setDecoderAlgoRotation(Mach1Point3DCore* euler);
void setDecoderAlgoRotationQuat(Mach1Point4DCore* quat);
void setDecoderAlgoScale(Mach1Point3DCore* scale);

## Applying Resulting Coefficients

void evaluatePositionResults();
void getVolumesWalls(float *result);
void getVolumesRoom(float *result);
float getDist();
Mach1Point3DCore getCurrentAngle();
Mach1Point3DCore getVolumeRotation();