# Mach1Decode API

## Create
> Create a Mach1Decode object

```cpp
Mach1Decode::Mach1Decode()
{
  Mach1Decode = Mach1DecodeCAPI_create();
}
```

```swift
init() {
    Mach1Decode = Mach1DecodeCAPI_create()
}
```

## Delete
> Remove a Mach1Decode object

```cpp
Mach1Decode::~Mach1Decode()
{
  Mach1DecodeCAPI_delete(Mach1Decode);
} 
```

```swift
deinit {
    Mach1DecodeCAPI_delete(Mach1Decode)
}
```

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
void Mach1Decode::setAngularSettingsType(AngularSettingsType type)
{
  Mach1DecodeCAPI_setAngularSettingsType(Mach1Decode, (int)type);
}
```
<!-- ```android
mach1Decode.setAngularSettingsType(Mach1Decode::AngularSettingsType::m1Android);
``` -->

```swift
mach1Decode.setAngularSettingsType(type: AngularSettingsType.m1iOSPortrait)
```

## Begin Buffer

## End Buffer

## Mach1Spatial Decode
8 Channel spatial mix decoding from our cuboid configuration. 
This is the default and recommended decoding utilizing isotropic decoding behavior.

> Default Isotropic Decoding: 

```cpp
mach1Decode.spatialAlgo(float deviceYaw, float devicePitch, float deviceRoll, int bufferSize = 0, int sampleIndex = 0);
```

> Alternative Periphonic Decoding:

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

## Get Log