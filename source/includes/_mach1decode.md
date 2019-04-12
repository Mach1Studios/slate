# Mach1Decode API

Mach1Decode supplies the functions needed to playback the Mach1Spatial VVBP 8channels to a stereo stream based on the device's orientation, this can be used for mobile device windowing or first person based media such as AR/VR/MR without any additional processing effects required.

## Summary Use

The Mach1Decode API is designed to be used the following way:

Setup Step (setup/start):

```cpp
void setup(){
    mach1Decode.setDecodeAlgoType(Mach1DecodeAlgoSpatial);
    mach1Decode.setPlatformType(Mach1PlatformDefault);
    mach1Decode.setFilterSpeed(1.0f);
}
void loop(){
    mach1Decode.beginBuffer();
    mach1Decode.decode(deviceYaw, devicePitch, deviceRoll);
    mach1Decode.endBuffer();
}
```

 - `setAlgorithmType`
 - `setAngularSettingsType`
 - `setFilterSpeed`

Audio Loop:

 - `beginBuffer`
 - `decode`
 - `getCurrentAngle` (debug/optional)
 - `endBuffer`

## Installation

Import and link the appropriate target device's / IDE's library file. 

## Set Platform Type
> Set the Angular Type for the target device via the enum
Use the `setPlatformType` function to set the device's angle order and convention if applicable:

### Preset Types(enum):
 - `Mach1PlatformDefault` = 0
 - `Mach1PlatformUnity` = 1
 - `Mach1PlatformUE` = 2
 - `Mach1PlatformOfEasyCam` = 3
 - `Mach1PlatformAndroid` = 4
 - `Mach1PlatformiOS` = 5

```cpp
mach1Decode.setPlatformType(Mach1PlatformDefault);
```
<!-- ```android
mach1Decode.setPlatformType(Mach1Decode::Mach1PlatformType::Mach1PlatformAndroid);
``` -->

```swift
mach1Decode.setPlatformType(type: Mach1PlatformType.Mach1PlatformiOS)
```

### Angle Order Conventions
1. Order of Yaw, Pitch, Roll (Defined as angle applied first, second and third).
2. Direction of transform around each pole's positive movement (left or right rotation).
3. integer Range before tranform completes 2(PI).

### Euler Angle Orders:
- (yaw-pitch-roll)
- Unity: Left handed x-y-z (pitch-roll-yaw)
- Unreal Engine: Right handed z-y-x 

## Set Filter Speed
Filter speed determines the amount of angle smoothing applied to the orientation angles used for the Mach1DecodeCore class. 1.0 would mean that there is no filtering applied, 0.1 would add a long ramp effect of intermediary angles between each angle sample. It should be noted that you will not have any negative effects with >0.9 but could get some orientation latency when <0.85. The reason you might want angle smoothing is that it might help remove a zipper effect seen on some poorer performing platforms or devices.

```cpp
float filterSpeed = 1.0f;

mach1Decode.setFilterSpeed(filterSpeed);
```

## Set Decoding Algorithm
Use this function to setup and choose the required Mach1 decoding algorithm.

### Mach1 Decoding Algorithm Types:
 - `Mach1DecodeAlgoSpatial` = 0 (default spatial | 8 channels)
 - `Mach1DecodeAlgoAltSpatial` = 1 (periphonic spatial | 8 channels)
 - `Mach1DecodeAlgoHorizon` = 2 (compass / yaw | 4 channels)
 - `Mach1DecodeAlgoHorizonPairs` = 3 (compass / yaw | 4x stereo mastered pairs)
 - `Mach1DecodeAlgoSpatialPairs` = 4 (experimental periphonic pairs | 8x stereo mastered pairs)


```cpp
void setDecodeAlgoType(Mach1DecodeAlgoType newAlgorithmType);
```

#### Mach1DecodeAlgoSpatial
Mach1Spatial. 8 Channel spatial mix decoding from our cuboid configuration. 
This is the default and recommended decoding utilizing isotropic decoding behavior.

#### Mach1DecodeAlgoAltSpatial
Mach1Spatial. 8 Channel spatial mix decoding from our cuboid configuration. 
This is a Periphonic decoding weighted more toward yaw, prone to gimbal lock but can be useful for use cases that only need 2 out of 3 input angle types.

#### Mach1DecodeAlgoHorizon
Mach1Horizon. 4 channel spatial mix decoding for compass / yaw only configurations.
Also able to decode and virtualize a first person perspective of Quad Surround mixes. 

#### Mach1DecodeAlgoHorizonPairs 
Mach1HorizonPairs. 8 channel spatial mix decoding for compass / yaw only that can support headlocked / non-diegetic stereo elements to be mastered within the mix / 8 channels. Supports and decodes Quad-Binaural mixes.

#### Mach1DecodeAlgoSpatialPairs
Mach1SpatialPairs. Periphonic stereo pairs decoding.
This function of decoding is deprecated and only helpful for experimental use cases!

## Begin Buffer
Call this function before reading from the Mach1Decode buffer.

```cpp
mach1Decode.beginBuffer();
```

```swift
mach1Decode.beginBuffer()
```

## End Buffer
Call this function after reading from the Mach1Decode buffer.

```cpp
mach1Decode.endBuffer();
```

```swift
mach1Decode.endBuffer()
```

## Decoding

The decode function's purpose is to give you updated volumes for each input audio channel for each frame in order for spatial effect to manifest itself. There are two versions of this function - one for cases when you might not need very low latency or couldn't include C/C++ directly, and another version for C/C++ high performance use.

If using on audio thread, high performance version is recommended if possible.

> Default Isotropic Decoding [recommended]: 

> lower performance version for non audio thread operation or for use in managed languages

```cpp
std::vector<float> volumes = mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRoll);
```

> you can get a per sample volumes frame if you specify the buffer size and the current sample index

```cpp
std::vector<float> volumes = mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRollint bufferSize, int sampleIndex);

// high performance version is meant to be used on the audio thread, it puts the resulting channel volumes
// into a float array instead of allocating a result vector. Notice the pointer to volumeFrame array passed. The array itself has to have a size of 18 floats

float volumeFrame [18];

mach1Decode.decode(float deviceYaw, float devicePitch, float deviceRoll, float *volumeFrame, bufferSize, int sampleIndex);
```

## Example of Using Decoded Coefficients
Input orientation angles and return the current sample/buffers coefficients

> Sample based example

```cpp
volumes = mach1Decode.decode(deivceYaw, devicePitch, deviceRoll);

for (int i = 0; i < 8; i++) {
    playersLeft[i].setVolume(volumes[i * 2] * overallVolume);
    playersRight[i].setVolume(volumes[i * 2 + 1] * overallVolume);
}
```

```swift
//Send device orientation to m1obj with the preferred algo
let decodeArray: [Float]  = m1obj.decode(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))

//Use each coeff to decode multichannel Mach1 Spatial mix
for i in 0...7 {

    players[i * 2].volume = Double(decodeArray[i * 2])
    players[i * 2 + 1].volume = Double(decodeArray[i * 2 + 1])
    
    print(String(players[i * 2].currentTime) + " ; " + String(i * 2))
    print(String(players[i * 2 + 1].currentTime) + " ; " + String(i * 2 + 1))
}
```

> Buffer based example

```cpp
//16 coefficients of spatial, 2 coefficients of headlocked stereo
float volumes[18];

mach1Decode.beginBuffer();
for (size_t i = 0; i < samples; i++)
{
    mach1Decode.decode(Yaw, Pitch, Roll, volumes, samples, i);

    for (int j = 0; j < 8; j++)
    {
        sndL += volumes[j * 2 + 0] * buffer[j][idx];
        sndR += volumes[j * 2 + 1] * buffer[j][idx];
    }

    buf[i * 2 + 0] = (short) (sndL * (SHRT_MAX-1));
    buf[i * 2 + 1] = (short) (sndR * (SHRT_MAX-1));
}
mach1Decode.endBuffer();
bufferRead += samples;
```

<!-- ## Get Current Time

Use this to get the current time and correlate it to the incoming audio streams, good for debug. 

## Get Current Angle

Use this to get the current angle being processed by Mach1Decode, good for orientation latency checks. 

## Get Log

Use this to get a list of input angles and the associated output coefficients from the used Mach1Decode function. -->