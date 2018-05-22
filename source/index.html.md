---
title: Mach1 SDK Reference & Documentation

language_tabs:
  - cpp
<!--   - cs
  - swift -->
  - shell

toc_footers:
  - <a href='http://www.mach1studios.com/signup'>Sign up for beta workflow tools</a>

includes:
  - mach1encode
  - mach1decode
  - mach1transcode
  - positional
  - commonissues

search: true
---

# Introduction

M1SDK includes APIs to allow developers to design applications that can encode or pan to a spatial audio render from audio streams and/or playback and decode Mach1Spatial 8channel spatial audio mixes with orientation to decode the correct stereo output sum of the user's current orientation. Additionally the M1SDK allows users to safely convert surround/spatial audio mixes to and from the Mach1Spatial or Mach1Horizon **VVBP** formats. 

**VVBP** or *Virtual Vector Based Panning* is a controlled virtual version of traditional **VBAP** (*Vector Based Amplitude Panning*) or **SPS** (*Spatial PCM Sampling*). These formats are designed for simplicity and ease of use & implementation both for the content creators and the developers. The spatial audio mixes are based on only amplitude based coefficients changes for both encoding and decoding, and unlike many other spatial audio approaches, there are no additional signal altering processes (such as room modeling, delays or filters) to create coherent and accurate spatial sound fields and play them back from a first person headtracked perspective. Due to the simplicity of the format and cuboid vector space it relies on, it is also ideal for converting and carrying surround and spatial audio mixes without altering the mix to do so, making it an ideal server side audio middleman container. 

# Contents 

The Mach1 Spatial SDK includes three components and libraries: 

  - **_Mach1Encode lib:_**
    Encode and process input streams/audio into a Mach1Spatial VVBP format.
  - **_Mach1Decode lib:_**
    Decode and process a Mach1Spatial VVBP format with device orientation / headtracking to output directional spatial audio.
  - **_Mach1Transcode lib:_**
    Transcode / convert any audio format (surround/spatial) to or from a Mach1Spatial VVBP format.

