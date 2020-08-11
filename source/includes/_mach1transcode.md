# Mach1Transcode CommandLine

Mach1Transcode includes functions for use cases that utilizing Mach1Spatial's agnostic abilities and allows 1:1 VBAP style conversions from any surround or spatial audio format and to any other surround or spatial audio format. This is very helpful for apps that have certain input requirements but different output requirements based on whether the app is launched for VR/AR/MR or just mobile use without completely redesigning the application's structure for audio. This is also a recommended method of carrying one master spatial audio container and at endpoints converting it as needed without adverse signal altering effects seen in other spatial audio formats. 

## Usage
Rapidly offline render to and from Mach1 formats.

> Example in command line for converting Mach1Spatial mix to First Order ambisonics: ACNSN3D

```
m1-transcode fmtconv -in-file /path/to/file.wav -in-fmt M1Spatial -out-fmt ACNSN3D -out-file /path/to/output.wav -out-file-chans 0
```

> Example in command line for converting 7.1 film mix to Mach1Spatial

```
m1-transcode fmtconv -in-file /path/to/file.wav -in-fmt SevenOnePT_Cinema -out-fmt Mach1Spatial -out-file /path/to/output.wav
```

> Example in command line for converting Mach1Spatial to Mach1HorizonPairs (quad-binaural compliant)

```
m1-transcode fmtconv -in-file /path/to/file.wav -in-fmt M1Spatial -out-fmt Mach1HorizonPairs -out-file /path/to/output.wav -out-file-chans 2
```

## Suggested Metadata Spec [optional]

> Mach1 Spatial = `mach1spatial-8`


> Mach1 Spatial+ = `mach1spatial-12`


> Mach1 Spatial++ = `mach1spatial-16`


> Mach1 StSP = `mach1stsp-2`


> Mach1 Horizon = `mach1horizon-4`


> Mach1 Horizon Pairs = `mach1horizon-8`

Metadata is not required for decoding any Mach1 VVBP format, and often it is not recommended to rely on auto-detection methods but instead rely on UI/UX for user input upon uploading a Mach1 multichannel audio file for safest handling. This is due to their being several possible 8 channel formats and unless there are proper methods to filter and detect and handle each one, user input will be a safer option. There are many oppurtunities for transcoding or splitting a multichannel audio file all of which could undo metadata or apply false-positive metadata due to the many audio engines not built to handle multichannel solutions safely. 

If autodetection is still required, use the following suggested specifications which will be applied to mixes that run out of M1-Transcoder and soon m1-transcode directly:

<aside class="notice">Implemented via ICMT/comment of common codec tags</aside>

> Example:

```
  Metadata:
    comment         : mach1spatial-8
```

## Examples of Metadata Spec
ffmpeg (wav output): `-metadata ICMT="mach1spatial-8"`

ffmpeg (vorbis output): `-metadata spatial-audio='mach1spatial-8'`

ffmpeg (aac output): `-metadata comment='mach1spatial-8'`

libsndfile (wav output): `outfiles[i].setString(0x05, "mach1spatial-8");`

## Formats Supported

### Mach1 Formats

 - M1Horizon (Mach1 Horizon / Quad) - L R Ls Rs
 - M1Horizon+S (Mach1 Horizon / Quad) - L R Ls Rs StereoL StereoR
 - M1HorizonPairs (Mach1 Horizon / Quad-Binaural) - FrontPair, LeftPair, RearPair, RightPair
 - M1Spatial (Mach1Spatial) - Upper L R Ls Rs, Lower L R Ls Rs
 - M1Spatial+S (Mach1Spatial) - Upper L R Ls Rs, Lower L R Ls Rs, StereoL StereoR
 - M1SpatialPairs (Mach1Spatial Pairs) - Upper front, left, rear, right, pairs, then lower same
 - M1SpatialFaces - Encoder for mono to cube faces

### Traditional / Surround Formats

 - Stereo - L & R spatialized
 - Stereo_Cinema - L & R spatialized, forward focus
 - LCR - L & R spatialized with C mono
 - FiveOh - L C R Ls Rs
 - FiveOneFilm (Pro Tools default) - L C R Ls Rs LFE
 - FiveOneFilm_Cinema (Pro Tools default) - L C R Ls Rs LFE, forward focus
 - FiveOneSmpte (SMPTE/ITU for Dolby Digital - L R C LFE Ls Rs
 - FiveOneDts (DTS) - L R Ls Rs C LFE
 - SevenOnePt (Pro Tools default) - L C R Lss Rss Lsr Rsr LFE
 - SevenOnePt_Cinema (Pro Tools default) - L C R Lss Rss Lsr Rsr LFE, forward focus
 - SevenZero_Cinema - L C R Lss Rss Lsr Rsr, forward focus
 - SevenOneSDDS (Sony SDDS) - L Lc C Rc R Ls Rs LFE
 - SevenZeroSDDS (Sony SDDS) - L Lc C Rc R Ls Rs
 - FiveOneTwo - L C R Lss Rss Lsr Rsr FLts FRts BLts BRts
 - FiveZeroTwo - L C R Lss Rss Lsr Rsr FLts FRts BLts BRts
 - FiveOneFour - L C R Lss Rss Lsr Rsr FLts FRts BLts BRts
 - FiveZeroFour - L C R Lss Rss Lsr Rsr FLts FRts BLts BRts
 - SevenOneTwo - L C R Lss Rss Lsr Rsr LFE Lts Rts
 - SevenZeroTwo - L C R Lss Rss Lsr Rsr Lts Rts
 - SevenOneFour - L C R Lss Rss Lsr Rsr LFE FLts FRts BLts BRts
 - SevenZeroFour - L C R Lss Rss Lsr Rsr FLts FRts BLts BRts
 - NineOne 
 - NineZero
 - 16.0 - 16 channel Surround 3D layout

 <aside class="notice">Additional formats available upon request.</aside>

### Ambisonic Formats (special thanks to [VVAudio](https://www.vvaudio.com/))

 - ACNSN3D - 1st order B-format, ACN order and SN3D weighting
 - FuMa - 1st order B-format, Furse-Malham order and weighting
 - ACNSN3DO2A - 2nd order B-format, AmbiX ACN order and SN3D weighting
 - FuMaO2A - 2nd order B-format, Furse-Malham order and weighting
 - TBE - Facebook360 Hybrid 2nd order
 - ACNSN3DO3A - 3rd order B-format, AmbiX ACN order and SN3D weighting
 - FuMaO3A - 3rd order B-format, Furse-Malham order and weighting
 - ACNSN3D1oa(maxRE) - 1st order, Ambix ACN order and SN3D-MaxRE from IEM
 - ACNSN3D2oa(maxRE) - 2nd order, Ambix ACN order and SN3D-MaxRE from IEM
 - ACNSN3D3oa(maxRE) - 3rd order, Ambix ACN order and SN3D-MaxRE from IEM
 - ACNSN3D4oa(maxRE) - 4th order, Ambix ACN order and SN3D-MaxRE from IEM
 - ACNSN3D5oa(maxRE) - 5th order, Ambix ACN order and SN3D-MaxRE from IEM
 - ACNSN3D6oa(maxRE) - 6th order, Ambix ACN order and SN3D-MaxRE from IEM
 - ACNSN3D7oa(maxRE) - 7th order, Ambix ACN order and SN3D-MaxRE from IEM

### Custom Format/Configuration

```
./m1-transcode fmtconv -in-file /path/to/16channel.wav -in-fmt TTPoints -in-json /path/to/16ChannelDescription.json -out-file /path/to/output-m1spatial.wav -out-fmt M1Spatial -out-file-chans 0
```

Input JSON description of the surround/spatial soundfield setup per your design and input it with the `-in-json` arguement for any custom input or output transcoding.

To use this set the `-in-fmt` or `-out-fmt` as `TTPoints`

## Additional Features

### LFE/SUB Channel Filter

> Example of low pass filtering every channel but the Front-Right of the Mach1 Spatial mix and outputting it to stereo.

```
./m1-transcode fmtconv -in-file /path/to/input-m1spatial.wav -in-fmt M1Spatial -out-file /path/to/output-stereo.wav -lfe-sub 0,2,3,4,6,7 -out-fmt Stereo -out-file-chans 0
```

Use `-lfe-sub` arguement to indicate which input channels you want to apply a Low Pass Filter to, the arguement exapects a list of ints with commas to separate them.

### Spatial Downmixer

```
./m1-transcode fmtconv -in-file /path/to/input-fiveOne.wav -in-fmt FiveOneFilm_Cinema -spatial-downmixer 0.9 -out-file /path/to/output-m1spatial.wav -out-fmt M1Spatial -out-file-chans 0
```

For scaling audio outputting to streaming use cases of Mach1Decode and use cases using the Mach1 Spatial output from Mach1Transcode we have included a way to compare the top vs. bottom of the input soundfield, if the difference is less than the set threshold (float) output format will be Mach1 Horizon. This is to allow soundfields that do not have much of a top vs bottom difference to output to a lesser channel Mach1 Horizon format to save on filesize while streaming.

`-spatial-downmixer` arguement can be used to set this, the float after this arguement will be used as the threshold. If used this will effectively add an additional transoding after anything outputting to `Mach1 Spatial` to then transcode from `Mach1 Spatial` to `Mach1 Horizon` while respecting the content of the soundfield. 

### Metadata Extractor

```
./m1-transcode fmtconv -in-file /path/to/input-ADM.wav -in-fmt SevenOneFour -out-file /path/to/output.wav -extract-metadata -out-fmt M1Spatial -out-file-chans 0
```

An ADM metadata reader and parser is embedded into m1-transcode binary executable to help with custom pipelines using Mach1Encode API to render Object Audio Soundfields into Mach1 Spatial mixes/renders for easier handling. 

`-extract-metadata` will dump any found XML ADM metadata in the audio binary as a textfile with the same output name and path.

# Mach1Transcode API

Mach1Transcode leverages the benefits of the Mach1 Spatial virtual vector based panning (VVBP) priniciples to enable faster than real time multichannel audio format conversions safely to retain the soundfield and not use any additional processing effects for simulation. Lack of processing effects ensures transparent input and output soundfields during conversion and the lightweight modular design of the API allows use with any audio handler or media library already natively installed. 

Multichannel audio development and creative use currently has a lot of challenges plagued by legacy surround implementations, the Mach1Transcode API can be used to help customize multichannel and spatial audio pipelines in development and garner control without requiring adoption of legacy practices. 

## Summary of Use

The Mach1Transcode API is designed openly by supplying a coefficient matrix for conversion, intepreted as needed. 
However, the following will be an example of setting up Mach1Transcode for any input and for direct conversion to Mach1Spatial to be decoded with orientation to stereo for spatial previewing applications:

```cpp
static void* decode(void* v);
Mach1Transcode m1Transcode;
static std::vector<std::vector<float>> m1Coeffs; //2D array, [input channel][input channel's coeff]
Mach1TranscodeFormatType inputMode;
Mach1TranscodeFormatType outputMode;

// Mach1 Transcode Setup
inputMode = Mach1TranscodeFormatACNSN3DmaxRE3oa;
outputMode = Mach1TranscodeFormatM1Spatial;

//resize coeffs array to the size of the current output
m1Transcode.setOutputFormat(outputMode);
for (int i = 0; i < m1Coeffs.size(); i++){
    m1Coeffs[i].resize(m1Transcode.getOutputNumChannels(), 0.0f);
}

m1Transcode.setInputFormat(inputMode);
m1Transcode.setOutputFormat(outputMode);

// Called to update Mach1Transcode
m1Transcode.setSpatialDownmixer();
m1Transcode.processConversionPath();
m1Coeffs = m1Transcode.getMatrixConversion();
```
```swift
import Mach1SpatialAPI
private var m1Decode = Mach1Decode()
private var m1Transcode = Mach1Transcode()

// Mach1 Transcode Setup
m1Transcode.setInputFormat(inFmt: Mach1TranscodeFormatType)
m1Transcode.setOutputFormat(outFmt: Mach1TranscodeFormatM1Spatial)
m1Transcode.processConversionPath()
matrix = m1Transcode.getMatrixConversion()
// Mach1 Decode Setup
m1Decode.setPlatformType(type: Mach1PlatformiOS)
m1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
m1Decode.setFilterSpeed(filterSpeed: 1.0)

// Called when updating InputFormat for Mach1Transcode
m1Decode.beginBuffer()
m1Decode.setRotationDegrees(newRotationDegrees: Mach1Point3D(x: 0, y: 0, z: 0))
let result: [Float] = m1Decode.decodeCoeffsUsingTranscodeMatrix(matrix: matrix, channels: m1Transcode.getInputNumChannels())
m1Decode.endBuffer()

// Called when updating input orientation for Mach1Decode
m1Decode.beginBuffer()
m1Decode.setRotationDegrees(newRotationDegrees: Mach1Point3D(x: Float(deviceYaw), y: Float(devicePitch), z: Float(deviceRoll)))
let result: [Float] = m1Decode.decodeCoeffsUsingTranscodeMatrix(matrix: matrix, channels: m1Transcode.getInputNumChannels())
m1Decode.endBuffer()
```

## Installation

Import and link the appropriate target device's / IDE's library file and headers. 

## Set / Get Input Format

## Set / Get Output Format

## Set / Get Spatial Downmixer

## Set LFE / Sub Channels

## Set Input as JSON

## Set Input as TT Points

## Set Input as ADM

## Process Normalization

## Process Master Gain

## Process Conversion Path

## Process Conversion
