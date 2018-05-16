# Mach1Encode API

## Create

```cpp
Mach1Encode::Mach1Encode()
{
  Mach1Encode = Mach1EncodeCAPI_create();
}
```

```swift
init() {
    Mach1Encode = Mach1EncodeCAPI_create()
}
```

## Delete

```cpp
Mach1Encode::Mach1Encode()
{
  Mach1Encode = Mach1EncodeCAPI_create();
}
```

```swift
deinit {
    Mach1EncodeCAPI_delete(Mach1Encode)
}
```

## Generate Point Results
Returns the resulting `points` coefficients based on selected and calculated input/output configuration.

```cpp
auto points = m1Encode.generatePointResults();
```

## Set Input Mode
Sets the number of input streams to be positioned as points.

 - INPUT_MONO
 - INPUT_STEREO
 - INPUT_QUAD
 - INPUT_AFORMAT
 - INPUT_BFORMAT

```cpp
if (inputKind == 0) { // Input: MONO
    m1Encode.inputMode = M1Encode::INPUT_MONO;
}
if (inputKind == 1) { // Input: STERO
    m1Encode.inputMode = M1Encode::INPUT_STEREO;
}
if (inputKind == 2) { // Input: Quad
    m1Encode.inputMode = M1Encode::INPUT_QUAD;
}
if (inputKind == 3) { // Input: AFORMAT
    m1Encode.inputMode = M1Encode::INPUT_AFORMAT;
}
if (inputKind == 4) { // Input: BFORMAT
    m1Encode.inputMode = M1Encode::INPUT_BFORMAT;
}
```

## Set Output Mode
Sets the output spatial format, Mach1Spatial or Mach1Horizon

 - OUTPUT_4CH (Mach1Spatial)
 - OUTPUT_8CH (Mach1Horizon)

```cpp
if (outputKind == 0) { // Output: Quad
    m1Encode.outputMode = M1Encode::OUTPUT_4CH;
}
if (outputKind == 1) { // Output: 7.1
    m1Encode.outputMode = M1Encode::OUTPUT_8CH;
}
```

## Set Rotation
Rotates the point(s) around the center origin of the vector space.

> UI value range: 0.0 -> 1.0 (0-360)

```cpp
m1Encode.rotation = rotation;
```

## Set Diverge
Moves the point(s) to/from center origin of the vector space.

> UI value range: -1.0 -> 1.0

```cpp
m1Encode.diverge = diverge;
```

## Set Pitch/Height
Moves the point(s) up/down the vector space.

> UI value range: -1.0 -> 1.0

```cpp
m1Encode.pitch = pitch;
```

## Set Stereo Rotation
Rotates the two stereo points around the axis of the center point between them.

> UI value range: -180.0 -> 180.0

```cpp
m1Encode.sRotate = sRotation;
```

## Set Stereo Spread
Increases or decreases the space between the two stereo points. 

> UI value range: 0.0 -> 1.0

```cpp
m1Encode.sSpread = sSpread;
```

## Set Auto Orbit
When active both stereo points rotate in relation to the center point between them so that they always triangulate toward center of the cuboid.

> default value: true

```cpp
m1Encode.autoOrbit = autoOrbit;
```

## Set Isotropic / Periphonic
When active encoding behavior acts evenly with distribution across all azimuth/rotation angles and all altitude/pitch angles.

> default value: true

```cpp
m1Encode.isotropicEncode = enableIsotropicEncode;
```
