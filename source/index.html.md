---
title: Mach1 SDK Reference & Documentation

language_tabs:
  - cpp
  - swift
  - javascript

toc_footers:
  - <a href='http://dev.mach1.xyz/research/Mach1SpatialSystem-WhitePaper_180523.pdf'>Research Paper</a>

includes:
  - mach1encode
  - mach1decode
  - mach1decodepositional
  - mach1transcode
  - commonissues
  - credit

search: true
---

# Introduction

M1SDK includes APIs to allow developers to design applications that can encode or pan to a spatial audio render from audio streams and/or playback and decode Mach1Spatial 8channel spatial audio mixes with orientation to decode the correct stereo output sum of the user's current orientation. Additionally the M1SDK allows users to safely convert surround/spatial audio mixes to and from the Mach1Spatial or Mach1Horizon **VVBP** formats. 

**VVBP** or *Virtual Vector Based Panning* is a controlled virtual version of traditional **VBAP** (*Vector Based Amplitude Panning*) or **SPS** (*Spatial PCM Sampling*). These formats are designed for simplicity and ease of use & implementation both for the content creators and the developers. The spatial audio mixes are based on only amplitude based coefficients changes for both encoding and decoding, and unlike many other spatial audio approaches, there are no additional signal altering processes (such as room modeling, delays or filters) to create coherent and accurate spatial sound fields and play them back from a first person headtracked perspective. Due to the simplicity of the format and cuboid vector space it relies on, it is also ideal for converting and carrying surround and spatial audio mixes without altering the mix to do so, making it an ideal server side audio middleman container. Bringing controlled post-produced spatial audio into new mediums easily.

# Overview 

The Mach1 Spatial SDK includes three components and libraries: 

  - **_Mach1Encode lib:_**
    Encode and process input streams/audio into a Mach1Spatial VVBP format.
  - **_Mach1Decode lib:_**
    Decode and process a Mach1Spatial VVBP format with device orientation / headtracking to output directional spatial audio.
  - **_Mach1DecodePositional lib:_**
    Add additional optional decoding layer to decode spatial mixes with 6DOF for positional and orientational decoding. 
  - **_Mach1Transcode lib:_**
    Transcode / convert any audio format (surround/spatial) to or from a Mach1Spatial VVBP format.

Mach1Encode and Mach1Decode are supported on OSX 10.7+, Windows 10+, iOS 9.0+ and Android API 19+. Unity 4.0+ and Unreal Engine 4.10+ examples are available and said engines are supported too on the aforementioned platforms. 

Mach1Transcode is supported on macOS, linux and Windows, game engine support coming soon.

# Mach1 Internal Angle Standard
### Positional 3D Coords
  -  X+ = strafe right
  -  X- = strafe left
  -  Y+ = up
  -  Y- = down
  -  Z+ = forward
  -  Z- = backward

### Orientation Euler
  -  Yaw[0]+ = rotate right [Range: 0->360 | -180->180]
  -  Yaw[0]- = rotate left [Range: 0->360 | -180->180]
  -  Pitch[1]+ = rotate up [Range: -90->90]
  -  Pitch[1]- = rotate down [Range: -90->90]
  -  Roll[2]+ = tilt right [Range: -90->90]
  -  Roll[2]- = tilt left [Range: -90->90]