# Mach1Encode API

Mach1Encode allows you to transform input audio streams into the Mach1Spatial VVBP 8 channel format. Included are functions needed for mono, stereo or quad/FOA audio streams. The input streams are referred to as `Points` in our SDK.

The typical encoding process starts with creating an object of a class Mach1EncodeCore, and setting it up as described below. After that, you're meant to generate Points by calling generatePointResults() on the object of this class. You'll get as many points as there are input channels and as many gains in each point as there are output channels. You then copy each input channel to each output channel with the according gain.

## Summary of Use
The Mach1Encode API is designed to aid in developing tools for inputting to a Mach1 VVBP/SPS format. They give access to common calculations needed for the audio processing and UI/UX handling for panning/encoding Mach1 VVBP/SPS formats via the following common structure:

```cpp
void update(){
    m1Encode.setRotation(rotation);
    m1Encode.setDiverge(diverge);
    m1Encode.setPitch(pitch);
    m1Encode.setStereoRotate(sRotation);
    m1Encode.setStereoSpread(sSpread);
    m1Encode.setAutoOrbit(autoOrbit);
    m1Encode.setIsotropicEncode(enableIsotropicEncode);
    m1Encode.setInputMode(Mach1EncodeInputModeType::Mach1EncodeInputModeMono);
    m1Decode.setDecodeAlgoType(Mach1DecodeAlgoSpatial);

    mtx.lock();
    m1Encode.generatePointResults();

    m1Decode.beginBuffer();
    decoded = m1Decode.decode(decoderRotationY, decoderRotationP, decoderRotationR, 0, 0);
    m1Decode.endBuffer();

    std::vector<float> volumes = this->volumes;
    mtx.unlock();
}
```

```swift
func update(decodeArray: [Float], decodeType: Mach1DecodeAlgoType){
    m1Encode.setRotation(rotation: rotation)
    m1Encode.setDiverge(diverge: diverge)
    m1Encode.setPitch(pitch: height)
    m1Encode.setAutoOrbit(setAutoOrbit: true)
    m1Encode.setIsotropicEncode(setIsotropicEncode: true)
    m1Encode.setStereoSpread(setStereoSpread: stereoSpread)
    m1Encode.setInputMode(inputMode: type)
    m1Encode.setOutputMode(outputMode: type)
    
    m1Encode.generatePointResults()

    //Use each coeff to decode multichannel Mach1 Spatial mix
    var volumes : [Float] = m1Encode.getResultingCoeffsDecoded(decodeType: decodeType, decodeResult: decodeArray)

    for i in 0..<players.count {
        players[i].volume = volumes[i] * volume
    }
```

```javascript
let m1Encode = null;
let m1EncodeModule = Mach1EncodeModule();
m1EncodeModule.onInited = function() {
    m1Encode = new(m1EncodeModule).Mach1Encode();
};
function update() {
    m1Encode.setRotation(params.rotation);
    m1Encode.setDiverge(params.diverge);
    m1Encode.setPitch(params.pitch);
    m1Encode.setStereoRotate(params.sRotation);
    m1Encode.setStereoSpread(params.sSpread);
    m1Encode.setAutoOrbit(params.autoOrbit);
    m1Encode.setIsotropicEncode(params.enableIsotropicEncode);

    m1Encode.generatePointResults();
}
```

## Installation

Import and link the appropriate target device's / IDE's library file. 

## Generate Point Results
Returns the resulting `points` coefficients based on selected and calculated input/output configuration.

```cpp
m1Encode.generatePointResults();
```
```swift
m1Encode.generatePointResults()
```
```javascript
m1Encode.generatePointResults();
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
```swift
var type : Mach1EncodeInputModeType = Mach1EncodeInputModeMono
m1Encode.setInputMode(inputMode: type)

if(soundFiles[soundIndex].count == 1) {
    type = Mach1EncodeInputModeMono
}
else if(soundFiles[soundIndex].count == 2) {
    type = Mach1EncodeInputModeStereo
}
else if (soundFiles[soundIndex].count == 4) {
	if (quadMode){
		type = Mach1EncodeInputModeQuad
	}
	if (aFormatMode){
		type = Mach1EncodeInputModeAFormat
	}
	if (bFormatMode){
		type = Mach1EncodeInputModeBFormat
	}
}
```
```javascript
if (params.inputKind == 0) { // Input: MONO
    m1Encode.setInputMode(m1Encode.Mach1EncodeInputModeType.Mach1EncodeInputModeMono);
}
if (params.inputKind == 1) { // Input: STERO
    m1Encode.setInputMode(m1Encode.Mach1EncodeInputModeType.Mach1EncodeInputModeStereo);
}
if (params.inputKind == 2) { // Input: Quad
    m1Encode.setInputMode(m1Encode.Mach1EncodeInputModeType.Mach1EncodeInputModeQuad);
}
if (params.inputKind == 3) { // Input: AFORMAT
    m1Encode.setInputMode(m1Encode.Mach1EncodeInputModeType.Mach1EncodeInputModeAFormat);
}
if (params.inputKind == 4) { // Input: BFORMAT
    m1Encode.setInputMode(m1Encode.Mach1EncodeInputModeType.Mach1EncodeInputModeBFormat);
}
```

## Set Output Mode
Sets the output spatial format, Mach1Spatial or Mach1Horizon

 - OUTPUT_4CH (Mach1Horizon) [Yaw only]
 - OUTPUT_8CH (Mach1Spatial) [Yaw, Pitch, Roll]

```cpp
if (outputKind == 0) { // Output: 4CH Mach1Horizon
    m1Encode.outputMode = M1Encode::OUTPUT_4CH;
}
if (outputKind == 1) { // Output: 8CH Mach1Spatial
    m1Encode.outputMode = M1Encode::OUTPUT_8CH;
}
```
```swift
if (outputKind == 0) { // Output: 4CH Mach1Horizon
    m1Encode.setOutputMode(outputMode: Mach1EncodeOutputMode4Ch)
}
if (outputKind == 1) { // Output: 8CH Mach1Spatial
    m1Encode.setOutputMode(outputMode: Mach1EncodeOutputMode8Ch)
}
```
```javascript
if (params.outputKind == 0) { // Output: Mach1Horizon / Quad
    m1Encode.setOutputMode(m1Encode.Mach1EncodeOutputModeType.Mach1EncodeOutputMode4Ch);
}
if (params.outputKind == 1) { // Output: Mach1Spatial / Cuboid
    m1Encode.setOutputMode(m1Encode.Mach1EncodeOutputModeType.Mach1EncodeOutputMode8Ch);
}
```

## Set Rotation
```cpp
m1Encode.setRotation = rotation;
```
```swift
m1Encode.setRotation(rotation: rotation)
```
```javascript
m1Encode.setRotation(params.rotation);
```
Rotates the point(s) around the center origin of the vector space.
> UI value range: 0.0 -> 1.0 (0-360)

## Set Diverge
```cpp
m1Encode.setDiverge = diverge;
```
```swift
m1Encode.setDiverge(diverge: diverge)
```
```javascript
m1Encode.setDiverge(params.diverge);
```
Moves the point(s) to/from center origin of the vector space.
> UI value range: -1.0 -> 1.0

## Set Pitch/Height
```cpp
m1Encode.setPitch = pitch;
```
```swift
m1Encode.setPitch(pitch: height)
```
```javascript
m1Encode.setPitch(params.pitch);
```
Moves the point(s) up/down the vector space.
> UI value range: -1.0 -> 1.0

## Set Stereo Rotation
```cpp
m1Encode.setStereoRotate = sRotation;
```
```swift
m1Encode.setStereoRotate(setStereoRotate: stereoRotate)
```
```javascript
m1Encode.setStereoRotate(params.sRotation);
```
Rotates the two stereo points around the axis of the center point between them.
> UI value range: -180.0 -> 180.0

## Set Stereo Spread
```cpp
m1Encode.setStereoSpread = sSpread;
```
```swift
m1Encode.setStereoSpread(setStereoSpread: stereoSpread)
```
```javascript
m1Encode.setStereoSpread(params.sSpread);
```
Increases or decreases the space between the two stereo points. 
> UI value range: 0.0 -> 1.0

## Set Auto Orbit
```cpp
m1Encode.setAutoOrbit = autoOrbit;
```
```swift
m1Encode.setAutoOrbit(setAutoOrbit: true)
```
```javascript
m1Encode.setAutoOrbit(params.autoOrbit);
```
When active both stereo points rotate in relation to the center point between them so that they always triangulate toward center of the cuboid.
> default value: true

## Set Isotropic / Periphonic
```cpp
m1Encode.setIsotropicEncode = enableIsotropicEncode;
```
```swift
m1Encode.setIsotropicEncode(setIsotropicEncode: true)
```
```javascript
m1Encode.setIsotropicEncode(params.enableIsotropicEncode);
```
When active encoding behavior acts evenly with distribution across all azimuth/rotation angles and all altitude/pitch angles.
> default value: true

## Inline Mach1Encode Object Decoder
```cpp
//Use each coeff to decode multichannel Mach1 Spatial mix
volumes = m1Encode.getResultingCoeffsDecoded(decodeType, decodeArray)

for (int i = 0; i < 8; i++) {
    players[i].volume = volumes[i] * volume
}
```
```swift
//Use each coeff to decode multichannel Mach1 Spatial mix
var volumes : [Float] = m1Encode.getResultingCoeffsDecoded(decodeType: decodeType, decodeResult: decodeArray)

for i in 0..<players.count {
    players[i].volume = volumes[i] * volume
}
```
This function allows designs where only previewing or live rendering to decoded audio output is required without any step of rendering or exporting to disk. This enables designs where developers can stack and sum multiple Mach1Encode object's decoded outputs instead of using Mach1Encode objects to write to a master 8 channel intermediary file. Allowing shorthand versions of Mach1Encode->Mach1Decode->Stereo if only live playback is needed. 

This can also be used to add object audio design to your application from the Mach1 Spatial APIs and add further control to an application to layer pre-rendered spatial audio and runtime spatial audio as needed.