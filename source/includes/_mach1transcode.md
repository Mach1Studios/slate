# Mach1Transcode API

Mach1Transcode includes functions for use cases that utilizing Mach1Spatial's agnostic abilities and allows 1:1 VBAP style conversions from any surround or spatial audio format and to any other surround or spatial audio format. This is very helpful for apps that have certain input requirements but different output requirements based on whether the app is launched for VR/AR/MR or just mobile use without completely redesigning the application's structure for audio. This is also a recommended method of carrying one master spatial audio container and at endpoints converting it as needed without adverse signal altering effects seen in other spatial audio formats. 

## Usage
Rapidly offline render to and from Mach1 formats. Supports expansion of more formats and more cross-conversions if requested.

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
 - SevenOnePT (Pro Tools default) - L C R Lss Rss Lsr Rsr LFE
 - SevenOnePT_Cinema (Pro Tools default) - L C R Lss Rss Lsr Rsr LFE, forward focus
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

### Ambisonic Formats (special thanks to VVAudio):

 - ACNSN3D - 1st order B-format, ACN order and SN3D weighting
 - FuMa - 1st order B-format, Furse-Malham order and weighting
 - ACNSN3DO2A - 2nd order B-format, AmbiX ACN order and SN3D weighting
 - FuMaO2A - 2nd order B-format, Furse-Malham order and weighting
 - TBE - Facebook360 Hybrid 2nd order
 - ACNSN3DO3A - 3rd order B-format, AmbiX ACN order and SN3D weighting
 - FuMaO3A - 3rd order B-format, Furse-Malham order and weighting


