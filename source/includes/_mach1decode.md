# Mach1Decode API

Mach1Decode supplies the functions needed to playback Mach1 Spatial VVBP formats to a stereo stream based on the device's orientation, this can be used for mobile device windowing or first person based media such as AR/VR/MR without any additional processing effects required.

## Summary Use
```cpp
void setup(){
    mach1Decode.setDecodeAlgoType(Mach1DecodeAlgoSpatial_8);
    mach1Decode.setPlatformType(Mach1PlatformDefault);
    mach1Decode.setFilterSpeed(0.95f);
}
void loop(){
    mach1Decode.setRotation(deviceYaw, devicePitch, deviceRoll); // normalized rotation input
    mach1Decode.beginBuffer();
    auto gainCoeffs = mach1Decode.decodeCoeffs();
    mach1Decode.endBuffer();

    // Apply gainCoeffs to gain/volume of array of audioplayers for custom spatial audio mixer
}
```

```swift
override func viewDidLoad() {
    mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial_8)
    mach1Decode.setPlatformType(type: Mach1PlatformiOS)
    mach1Decode.setFilterSpeed(filterSpeed: 1.0)
}
func update() {
    mach1Decode.beginBuffer()
    let decodeArray: [Float]  = mach1Decode.decode(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))
    mach1Decode.endBuffer()

    // Apply gainCoeffs to gain/volume of array of audioplayers for custom spatial audio mixer
}
```

```javascript
let mach1Decode = null;
Mach1DecodeModule().then(function(m1DecodeModule) {
    m1Decode = new(m1DecodeModule).Mach1Decode();
    m1Decode.setPlatformType(m1Decode.Mach1PlatformType.Mach1PlatformDefault);
    m1Decode.setDecodeAlgoType(m1Decode.Mach1DecodeAlgoType.Mach1DecodeAlgoSpatial_8);
    m1Decode.setFilterSpeed(0.95);
});
function update() {
    mach1Decode.beginBuffer();
    var decoded = mach1Decode.decode(params.decoderRotationY, params.decoderRotationP, params.decoderRotationR);
    mach1Decode.endBuffer();

    // Apply gainCoeffs to gain/volume of array of audioplayers for custom spatial audio mixer
}
```

The Mach1Decode API is designed to be used the following way:

Setup Step (setup/start):

 - `setAlgorithmType`
 - `setAngularSettingsType`
 - `setFilterSpeed`

Audio Loop:

 - `beginBuffer`
 - `setRotation` / `setRotationDegrees` / `setRotationRadians` / `setRotationQuat`
 - `decode` / `decodeCoeffs`
 - `getCurrentAngle` (debug/optional)
 - `endBuffer`

### Using Mach1Decode `decode` Callback Options
The Mach1Decode class's decode function returns the coefficients for each external audio players' gains/volumes to create the spatial decode per update at the current angle. The timing of when this callback can be designed with two different modes of use:

 - Update decode results via the used audio player/engine's audio callback
 - Update decode results via main loop (or any call)

To utilize the first mode simply supply the int your audio player's are using for bufferSize and current index of sample in that buffer to the `decode(yaw, pitch, roll, bufferSize, sampleIndex)` function to syncronize and update with the audio callback
To utilize the second mode simply supply `0` values to `bufferSize` and `sampleIndex`

## Installation

Import and link the appropriate target device's / IDE's library file. 

## Set Platform Type
> Set the Angular Type for the target device via the enum

```cpp
mach1Decode.setPlatformType(Mach1PlatformDefault);
```

```swift
mach1Decode.setPlatformType(type: Mach1PlatformType.Mach1PlatformiOS)
```

```javascript
mach1Decode.setPlatformType(m1Decode.Mach1PlatformType.Mach1PlatformOfEasyCam);
```
Use the `setPlatformType` function to set the device's angle order and convention if applicable:

### Preset Types(enum):
 - `Mach1PlatformDefault` = 0
 - `Mach1PlatformUnity`
 - `Mach1PlatformUE`
 - `Mach1PlatformOfEasyCam`
 - `Mach1PlatformAndroid`
 - `Mach1PlatformiOS`

### Angle Order Conventions
1. Order of Yaw, Pitch, Roll (Defined as angle applied first, second and third).
2. Direction of transform around each pole's positive movement (left or right rotation).
3. integer Range before tranform completes 2(PI).

### Euler Angle Orders:
- (yaw-pitch-roll)
- Unity: Left handed x-y-z (pitch-roll-yaw)
- Unreal Engine: Right handed z-y-x 

## Set Filter Speed
```cpp
float filterSpeed = 1.0f;

mach1Decode.setFilterSpeed(filterSpeed);
```

```swift
mach1Decode.setFilterSpeed(filterSpeed: 1.0)
```

```javascript
mach1Decode.setFilterSpeed(0.95);
```

Filter speed determines the amount of angle smoothing applied to the orientation angles used for the Mach1DecodeCore class. 1.0 would mean that there is no filtering applied, 0.1 would add a long ramp effect of intermediary angles between each angle sample. It should be noted that you will not have any negative effects with >0.9 but could get some orientation latency when <0.85. The reason you might want angle smoothing is that it might help remove a zipper effect seen on some poorer performing platforms or devices.

## Set Decoding Algorithm
```cpp
void setDecodeAlgoType(Mach1DecodeAlgoType newAlgorithmType);
```

```swift
func setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoType)
```

```javascript
mach1Decode.setDecodeAlgoType(m1Decode.Mach1DecodeAlgoType.Mach1DecodeAlgoSpatial_8);
```

Use this function to setup and choose the required Mach1 decoding algorithm.

### Mach1 Decoding Algorithm Types:
 - `Mach1DecodeAlgoSpatial_8` = 0 (default spatial | 8 channels)
 - `Mach1DecodeAlgoHorizon_4` (compass / yaw | 4 channels)
 - `Mach1DecodeAlgoHorizonPairs` (compass / yaw | 4x stereo mastered pairs)

#### Mach1DecodeAlgoSpatial_8
Mach1Spatial. 8 Channel spatial mix decoding from our cuboid configuration. 
This is the default and recommended decoding utilizing isotropic decoding behavior.

#### Mach1DecodeAlgoHorizon_4
Mach1Horizon. 4 channel spatial mix decoding for compass / yaw only configurations.
Also able to decode and virtualize a first person perspective of Quad Surround mixes. 

#### Mach1DecodeAlgoHorizonPairs 
Mach1HorizonPairs. 8 channel spatial mix decoding for compass / yaw only that can support headlocked / non-diegetic stereo elements to be mastered within the mix / 8 channels. Supports and decodes Quad-Binaural mixes.

## Begin Buffer
```cpp
mach1Decode.beginBuffer();
```

```swift
mach1Decode.beginBuffer()
```

```javascript
mach1Decode.beginBuffer();
```

Call this function before reading from the Mach1Decode buffer.

## End Buffer
```cpp
mach1Decode.endBuffer();
```

```swift
mach1Decode.endBuffer()
```

```javascript
mach1Decode.endBuffer();
```

Call this function after reading from the Mach1Decode buffer.

## Decode
There are four exposed functions that can be called at any time to set the next rotation. This maximizes design possibilities where rotations update may need to be called less or more than the calculated returned coefficients are needed. In general their are three ways to calculate `decode` values for your native audio player.

1. Use `setRotation` / `setRotationDegrees` / `setRotationRadians` / `setRotationQuat` before you call `decodeCoeffs()`
2. Use `decode()` with inline arguments in Euler degrees
3. Use `decodeCoeffsUsingTranscodeMatrix()`

### 1. DecodeCoeffs()
```cpp
mach1Decode.setRotationDegrees(float deviceYaw, float devicePitch, float deviceRoll);
std::vector<float> decodedGains = mach1Decode.decodeCoeffs();
```

```swift
mach1Decode.setRotationDegrees(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))
let decodedGains: [Float]  = mach1Decode.decodeCoeffs()
```

```javascript
m1Decode.setRotationDegrees(params.decoderRotationY, params.decoderRotationP, params.decoderRotationR);
var decodedGains = m1Decode.decodeCoeffs();
```

For easier use with more design cases we have a function for "decode" that uses the last called `setRotation` function in case your use case needs different input rotation descriptions or have different places that the orientation is updated compared to the audio thread your decode might be applied within. 

Please view the section on `setRotation` to learn more about the different functions for updating input rotations to Mach1Decode.

### 2. Decode()
```cpp
std::vector<float> decodedGains = mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRoll);
```

```swift
let decodedGains: [Float]  = mach1Decode.decode(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))
```

```javascript
var decodedGains = m1Decode.decode(params.decoderRotationY, params.decoderRotationP, params.decoderRotationR);
```
An all in one call to `decode(float yaw, float pitch, float roll)` with the input orientation rotation described in absolute Euler degrees can be used.

### Decoding Design
> Default Isotropic Decoding [recommended]: 

> lower performance version for non audio thread operation or for use in managed languages

```cpp
std::vector<float> volumes = mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRoll);
```

> you can get a per sample gains/volumes frame if you specify the buffer size and the current sample index

```cpp
std::vector<float> decodedGains = mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize, int sampleIndex);

// high performance version is meant to be used on the audio thread, it puts the resulting channel gains/volumes
// into a float array instead of allocating a result vector. Notice the pointer to volumeFrame array passed. The array itself has to have a size of 18 floats

float decodedGainsFrame [18];
mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRoll, float *decodedGainsFrame, int bufferSize, int sampleIndex);
```

The decode function's purpose is to give you updated gains/volumes for each input audio channel for each frame in order for spatial effect to manifest itself. There are two versions of this function - one for cases when you might not need very low latency or couldn't include C/C++ directly, and another version for C/C++ high performance use.

If using on audio thread, high performance version is recommended if possible.

## Example of Using Decoded Coefficients
> Sample based example

```cpp
decodedGains = mach1Decode.decode(deivceYaw, devicePitch, deviceRoll);

for (int i = 0; i < 8; i++) {
    playersLeft[i].setVolume(decodedGains[i * 2] * overallVolume);
    playersRight[i].setVolume(decodedGains[i * 2 + 1] * overallVolume);
}
```

```swift
//Send device orientation to mach1Decode object with the preferred algo
mach1Decode.beginBuffer()
let decodedGains: [Float]  = mach1Decode.decode(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))
mach1Decode.endBuffer()

//Use each coeff to decode multichannel Mach1 Spatial mix
for i in 0...7 {
    players[i * 2].volume = Double(decodedGains[i * 2])
    players[i * 2 + 1].volume = Double(decodedGains[i * 2 + 1])
}
```

> Buffer based example

```cpp
//16 coefficients of spatial, 2 coefficients of headlocked stereo
float decodedGains[18];

mach1Decode.beginBuffer();
for (size_t i = 0; i < samples; i++)
{
    mach1Decode.decode(Yaw, Pitch, Roll, decodedGains, samples, i);

    for (int j = 0; j < 8; j++)
    {
        sndL += decodedGains[j * 2 + 0] * buffer[j][idx];
        sndR += decodedGains[j * 2 + 1] * buffer[j][idx];
    }

    buf[i * 2 + 0] = (short) (sndL * (SHRT_MAX-1));
    buf[i * 2 + 1] = (short) (sndR * (SHRT_MAX-1));
}
mach1Decode.endBuffer();
bufferRead += samples;
```

Input orientation angles and return the current sample/buffers coefficients

## Set Rotation
> Call this before you call `decodeCoeffs()` to properly update the calculated gains before applying to your native audio player/handler.

Use one of these functions to update new rotation values for Mach1Decode, ideally before calling `decodeCoeffs()` which will return the calculated spatial gains you will be applying to your native audio player/handler as per our examples. To make things more human interpretable in terms of the expected ranges and values you can use in each of these `setRotation` functions we have explicitly named the input arguments.

### Rotation: Normalized
```cpp
mach1Decode.setRotation(float deviceYawNorm, float devicePitchNorm, float deviceRollNorm);
```

```swift
mach1Decode.setRotation(Yaw: Float(deviceYawNorm), Pitch: Float(devicePitchNorm), Roll: Float(deviceRollNorm))
```

```javascript
m1Decode.setRotation(params.decoderRotationYNorm, params.decoderRotationPNorm, params.decoderRotationRNorm);
```

 - Yaw: float for device/listener yaw angle: [Range: -1.0 -> 1.0]
 - Pitch: float for device/listener pitch angle: [Range: -0.25 -> 0.25]
 - Roll: float for device/listener roll angle: [Range: -0.25 -> 0.25]

### Rotation: Degrees
```cpp
mach1Decode.setRotationDegrees(float deviceYawDegrees, float devicePitchDegrees, float deviceRollDegrees);
```

```swift
mach1Decode.setRotationDegrees(Yaw: Float(deviceYawDegrees), Pitch: Float(devicePitchDegrees), Roll: Float(deviceRollDegrees))
```

```javascript
m1Decode.setRotationDegrees(params.decoderRotationYDegrees, params.decoderRotationPDegrees, params.decoderRotationRDegrees);
```

 - Yaw: float for device/listener yaw angle: [Range: 0->360 | -180->180]
 - Pitch: float for device/listener pitch angle: [Range: -90->90]
 - Roll: float for device/listener roll angle: [Range: -90->90]

### Rotation: Radians
```cpp
mach1Decode.setRotationRadians(float deviceYawRads, float devicePitchRads, float deviceRollRads);
```

```swift
mach1Decode.setRotationRadians(Yaw: Float(deviceYawRads), Pitch: Float(devicePitchRads), Roll: Float(deviceRollRads))
```

```javascript
m1Decode.setRotationRadians(params.decoderRotationYRads, params.decoderRotationPRads, params.decoderRotationRRads);
```

 - Yaw: float for device/listener yaw angle: [Range: 0->2PI | -PI->PI]
 - Pitch: float for device/listener pitch angle: -PI/2 -> PI/2
 - Roll: float for device/listener roll angle: -PI/2 -> PI/2

### Rotation: Quaternion
```cpp
mach1Decode.setRotationQuat(float deviceW, float deviceX, float deviceY, float deviceZ);
```

```swift
mach1Decode.setRotationQuat(W: Float(deviceW), X: Float(deviceX), Y: Float(deviceY), Z: Float(deviceZ))
```

```javascript
m1Decode.setRotationQuat(params.deviceW, params.deviceX, params.deviceY, params.deviceZ);
```

 - W: float for device/listener W: [Range: -1.0->1.0]
 - X: float for device/listener X: [Range: -1.0->1.0]
 - Y: float for device/listener Y: [Range: -1.0->1.0]
 - Z: float for device/listener Z: [Range: -1.0->1.0]

## Get Current Time

Returns the current elapsed time in milliseconds (ms) since Mach1Decode object's creation. 

## Get Log

Returns a string of the last log message (or empty string if none) from Mach1DecodeCAPI binary library. Use this to assist in debug with a list of input angles and the associated output coefficients from the used Mach1Decode function.

## Get Current Angle

Use this to get the current angle being processed by Mach1Decode, good for orientation latency checks. 