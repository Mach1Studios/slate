# Mach1Decode API

Mach1Decode supplies the functions needed to playback the Mach1Spatial VVBP 8channels to a stereo stream based on the device's orientation, this can be used for mobile device windowing or first person based media such as AR/VR/MR without any additional processing effects required.

## Installation
Import and link the appropriate target device's / IDE's library file. 

> shell:

```
rsync -aved  ../../../addons/ofxMach1/libs/lib/osx/libMach1DecodeCAPI.dylib  "$TARGET_BUILD_DIR/$PRODUCT_NAME.app/Contents/Frameworks/";
install_name_tool -change libMach1DecodeCAPI.dylib @executable_path/../Frameworks/libMach1DecodeCAPI.dylib "$TARGET_BUILD_DIR/$PRODUCT_NAME.app/Contents/MacOS/$PRODUCT_NAME";
```
<aside class="notice">OF: when importing ofxMach1 add the following to your post-build script</aside>

## Set Angular Type
> Set the Angular Type for the target device via the enum
Use the `setAngularSettings` function to set the device's angle order and convention if applicable:

### Preset Types(enum):
 - m1Default
 - m1Unity
 - m1UE
 - m1oFEasyCam
 - m1Android
 - m1iOSPortrait
 - m1iOSLandscape

```cpp
mach1Decode.setAngularSettingsType(m1Default);
```
<!-- ```android
mach1Decode.setAngularSettingsType(Mach1Decode::AngularSettingsType::m1Android);
``` -->

```swift
mach1Decode.setAngularSettingsType(type: AngularSettingsType.m1iOSPortrait)
```

### Angle Order Conventions
1. Order of Yaw, Pitch, Roll (Defined as angle applied first, second and third).
2. Direction of transform around each pole's positive movement (left or right rotation).
3. integer Range before tranform completes 2(PI).

| Order        | airplane      | telescope | symbol | angular velocity |
| -------------:| -------------:| ---------:| ------:| ----------------:| 
| applied first | heading | azimuth   | θ (theta) |         yaw         |
| applied second      | attitude      | elevation | φ (phi) | pitch |
| applied last | bank | tilt    | ψ (psi) | roll |

### Euler Angle Orders:
- (yaw-pitch-roll)
- Unity: Left handed x-y-z (pitch-roll-yaw)
- Unreal Engine: Right handed z-y-x 

## Set Filter Speed
Filter speed determines the amount of angle smoothing applied to the orientation angles used for the Mach1Decode class. 1.0 would mean that there is no filtering applied, 0.1 would add a long ramp effect of intermediary angles between each angle sample. It should be noted that you will not have any negative effects with >0.9 but could get some orientation latency when <0.85.

```cpp
float filterSpeed = 1.0f;

mach1Decode.setFilterSpeed(filterSpeed);
```

## Begin Buffer

## End Buffer

## Mach1Spatial Decode
8 Channel spatial mix decoding from our cuboid configuration. 
This is the default and recommended decoding utilizing isotropic decoding behavior.

> Default Isotropic Decoding [recommended]: 

```cpp
mach1Decode.spatialAlgo(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize = 0, int sampleIndex = 0);
```

> Alternative Periphonic Decoding [not recommended]:

```cpp
mach1Decode.spatialAltAlgo(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize = 0, int sampleIndex = 0);
```

Add headlocked / noon-diegetic stereo mix to the output summed coefficients.

## Mach1Horizon Decode
4 channel spatial mix decoding for compass / yaw only configurations.
Also able to decode and virtualize a first person perspective of Quad Surround mixes. 

```cpp
mach1Decode.horizonAlgo(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize = 0, int sampleIndex = 0);
```

Add headlocked / noon-diegetic stereo mix to the output summed coefficients.

## Mach1HorizonPairs Decode
8 channel spatial mix decoding for compass / yaw only that can support headlocked / non-diegetic stereo elements to be mastered within the mix / 8 channels.

```cpp
mach1Decode.horizonPairsAlgo(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize = 0, int sampleIndex = 0);
```

## Mach1SpatialPairs Decode
<aside class="warning">This function of decoding is deprecated and only helpful for experimental use cases!</aside>

> Periphonic stereo pairs decoding [not recommended]

```cpp
mach1Decode.spatialPairsAlgo(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize = 0, int sampleIndex = 0);
```

## Return Coefficients Example
Input orientation angles and return the current sample/buffers coefficients

> Sample based example

```cpp
volumes = mach1Decode.spatialAlgo(deivceYaw, devicePitch, deviceRoll);

for (int i = 0; i < 8; i++) {
    playersLeft[i].setVolume(volumes[i * 2] * overallVolume);
    playersRight[i].setVolume(volumes[i * 2 + 1] * overallVolume);
}
```

```swift
//Send device orientation to m1obj with the preferred algo
let decodeArray: [Float]  = m1obj.spatialAlgo(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))

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
    mach1Decode.spatialAlgo(Yaw, Pitch, Roll, volumes, samples, i);

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

## Get Current Time

Use this to get the current time and correlate it to the incoming audio streams, good for debug. 

## Get Current Angle

Use this to get the current angle being processed by Mach1Decode, good for orientation latency checks. 

## Get Log

Use this to get a list of input angles and the associated output coefficients from the used Mach1Decode function.