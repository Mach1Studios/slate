# Positional Functions

<aside class="notice">Positional functions are being refactored from Unity & Unreal Engine M1Base class to the Mach1Decode API upon release 1.1</aside>

## Unity & Unreal Engine

Please view the examples in `examples/Unity|UnrealEngine` to see deployment of Mach1Spatial mixes with positional rotation and attenuation applied. These fucntions can be viewed from the M1Base class used in both examples and are called by creating a new object in the game engine and attaching Mach1SpatialActor or Mach1SpatialDecode.cs to view the setup for a Mach1 Spatial mix layer. 

> These implementation require the multichannel mixes to be split into multiple-mono mixes. You can use `m1-transcode` or the M1-Transcoder GUI application to achieve this easily. 

## API [coming version:1.1]

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