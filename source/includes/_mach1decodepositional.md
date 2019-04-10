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

The following are functions to aid in how positional distance effects the overall gain of an mach1decode object to any design. The resulting distance calculations can also be used for any external effect if created.

### Falloff/Attenuation
```cpp
void setUseFalloff(bool useFalloff);
```
Boolean turning on/off distance attenuation calculations on that mach1decode object

### Reference positional point/plane/shape
```cpp
void setUseClosestPointRotationMuteInside(bool useClosestPointRotationMuteInside);
```
This very long named function can set whether the rotational pivots of a mach1decode soundfield are by referencing the device/camera to a positional point or the closest point of a plane (and further the closest plane of a shape). This allows each mach1decode object to be placed with more design options to prevent soundfield scenes from rotating when not needed.

### Set Filter Speed
Filter speed determines the amount of angle smoothing applied to the orientation angles used for the Mach1DecodeCore class. 1.0 would mean that there is no filtering applied, 0.1 would add a long ramp effect of intermediary angles between each angle sample. It should be noted that you will not have any negative effects with >0.9 but could get some orientation latency when <0.85. The reason you might want angle smoothing is that it might help remove a zipper effect seen on some poorer performing platforms or devices.

```cpp
float filterSpeed = 1.0f;

mach1Decode.setFilterSpeed(filterSpeed);
```

## Setup for Advanced Settings 

### Mute Controls
Similar to the `setUseClosestPointRotationMuteInside` these functions give further control over placing a soundfield positionally and determining when it should/shouldn't output results.

```cpp
void setMuteWhenOutsideObject(bool muteWhenOutsideObject);
```
Mute mach1decode object (all coefficifient results becomes 0) when outside the positional reference shape/point

```cpp
void setMuteWhenInsideObject(bool muteWhenInsideObject);
```
Mute mach1decode object (all coefficifient results becomes 0) when inside the positional reference shape/point

### Manipulate input angles for positional rotations
void setIgnoreTopBottom(bool ignoreTopBottom);
```cpp
void setUseYawForRotation(bool useYawForRotation);
```
Ignore Yaw angle rotation results from pivoting positionally

```cpp
void setUsePitchForRotation(bool usePitchForRotation);
```
Ignore Pitch angle rotation results from pivoting positionally

```cpp
void setUseRollForRotation(bool useRollForRotation);
```
Ignore Roll angle rotation results from pivoting positionally

### Experimental: BlendMode
This is a feature for combining two mach1decode spatial mixes to become blended for inside reference shape only, attenuation between both decode mixes are relative to each other and based on a center to exterior planes (walls) relationship.
```cpp
void setUseBlendMode(bool useBlendMode);
```
Enable this experimental mode

```cpp
void setFalloffCurveBlendMode(float falloffCurveBlendMode);
```
Set the custom curve for the relationship between the center to the exterior planes. 

## Update per Spatial Soundfield Position
Updatable variables for each mach1decode object. These are also able to be set once if needed.

```cpp
void setCameraPosition(Mach1Point3DCore* pos);
```
Updates the device/camera's position in desired x,y,z space

```cpp
void setCameraRotation(Mach1Point3DCore* euler);
```
Updates the device/camera's orientation with Euler angles (yaw, pitch, roll)

```cpp
void setCameraRotationQuat(Mach1Point4DCore* quat);
```
Updates the device/camera's orientation with Quaternion

```cpp
void setDecoderAlgoPosition(Mach1Point3DCore* pos);
```
Updates the decode object's position in desired x,y,z space

```cpp
void setDecoderAlgoRotation(Mach1Point3DCore* euler);
```
Updates the decode object's orientation with Euler angles (yaw, pitch, roll)

```cpp
void setDecoderAlgoRotationQuat(Mach1Point4DCore* quat);
```
Updates the decode object's orientation with Quaternion

```cpp
void setDecoderAlgoScale(Mach1Point3DCore* scale);
```
Updates the decode object's scale in desired x,y,z space

## Applying Resulting Coefficients

```cpp
void evaluatePositionResults();
```
Calculate!

```cpp
void getVolumesWalls(float *result);
```
Get coefficient results for applying to mach1decode object for rotational and positional, replaces the results from: `mach1Decode.decode`

```cpp
float getDist();
```
Get normalized distance between mach1decode object and device/camera

```cpp
Mach1Point3DCore getCurrentAngle();
```

```cpp
Mach1Point3DCore getVolumeRotation();
```

### Experimental: BlendMode
```cpp
void getVolumesRoom(float *result);
```
Get coeff results for the center of "Blend Mode". Very experimental!


### Update Falloff/Attenuation
```cpp
void setFalloffCurve(float falloffCurve);
```
Set a resulting float of that curve to the current buffer