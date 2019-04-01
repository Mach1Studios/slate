# Mach1DecodePositional API

Mach1DecodePositional allows the 3DOF orientation decoding to decode in a dev environment that supports 6DOF with positional movement. It does this by referencing the user's device to a location and adding an additional layer of rotations and attenuations to the spatial decoding. 

## Unity & Unreal Engine

Please view the examples in `examples/Unity|UnrealEngine` to see deployment of Mach1Spatial mixes with positional rotation and attenuation applied. These fucntions can be viewed from the M1Base class used in both examples and are called by creating a new object in the game engine and attaching Mach1SpatialActor or Mach1SpatialDecode.cs to view the setup for a Mach1 Spatial mix layer. 

> These implementation require the multichannel mixes to be split into multiple-mono mixes. You can use `m1-transcode` or the M1-Transcoder GUI application to achieve this easily. 

## Summary Use

 - `setCameraPosition(Mach1Point3DCore* pos)` 
 - `setCameraRotation(Mach1Point3DCore* euler)`
 - `setMach1ObjPosition(Mach1Point3DCore* pos)`
 - `setMach1ObjRotation(Mach1Point3DCore* euler)`
 - `setMach1ObjScale(Mach1Point3DCore* scale)`
 - `setAttenuationCurve(float* curve)`
 - `getPositionResultsPoint()`
 - `getPositionResultsObjCenter()`
 - `getPositionResultsObjWalls(enum planeSelect, bool pointType)`
 - `updatePostionResults()`

## Installation
> shell:

```
rsync -aved  "$OF_PATH/addons/ofxMach1/libs/lib/osx/libMach1DecodePositionalCAPI.dylib" "$TARGET_BUILD_DIR/$PRODUCT_NAME.app/Contents/Frameworks/";
install_name_tool -change libMach1DecodeCAPI.dylib @executable_path/../Frameworks/libMach1DecodePositionalCAPI.dylib "$TARGET_BUILD_DIR/$PRODUCT_NAME.app/Contents/MacOS/$PRODUCT_NAME";
```

Import and link the appropriate target device's / IDE's library file. 
<aside class="notice">Requires libMach1DecodeCAPI for reference to spatial object and orientation decoding</aside>

<aside class="notice">openFrameworks: when importing ofxMach1 add the following to your post-build script</aside>