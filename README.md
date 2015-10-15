# KCJogDial
![Swift 2.0](https://img.shields.io/badge/Swift-1.2-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/KCJogDial.svg?style=flat)](http://cocoapods.org/pods/KCJogDial)
[![License](https://img.shields.io/cocoapods/l/KCJogDial.svg?style=flat)](http://cocoapods.org/pods/KCJogDial)
[![Platform](https://img.shields.io/cocoapods/p/KCJogDial.svg?style=flat)](http://cocoapods.org/pods/KCJogDial)
[![Build Status](https://travis-ci.org/kciter/KCJogDial.svg?branch=swift1.2)](https://travis-ci.org/kciter/KCJogDial)

## Preview
<img src="https://github.com/kciter/KCJogDial/raw/master/Images/preview.gif" alt="Preview gif">

## Requirements
* iOS 7.0+
* Xcode 6.0+

## Storyboard support
<img src="https://github.com/kciter/KCJogDial/raw/master/Images/storyboard.png" width="50%" alt="Storyboard Screenshot">

## Installation

### iOS 8+
#### Cocoapods
```ruby
use_frameworks!
pod "KCJogDial", :git => 'https://github.com/kciter/KCJogDial.git', :branch => 'swift1.2'
```
### iOS 7
#### Manually
To install manually the KCJogDial in an app, just drag the `KCJogDial.swift` file into your project.

## Properties
| Properties | Type | Description |
|---|---|---|
|`enableRange` | `Bool` | Use range mode |
|`minimumValue` | `Double` | Acceptable minimum value |
|`maximumValue` | `Double` | Acceptable maximum value |
|`value` | `Double` | Value |
|`tick` | `Double` | Increase value |
|`centerMarkColor` | `UIColor` | Set center mark color |
|`centerMarkWidth` | `CGFloat` | Set center mark width |
|`centerMarkHeightRatio` | `CGFloat` | Set center mark height |
|`centerMarkRadius` | `CGFloat` | Set center mark radius |
|`markColor` | `UIColor` | Set mark color |
|`markWidth` | `CGFloat` | Set mark width |
|`markRadius` | `CGFloat` | Set mark radius |
|`markCount` | `Int` | The number of mark in view |
|`padding` | `Double` | Vertical offfset from bottom in landscape mode |
|`verticalAlign` | `String` | Vertical Align as `top`, `middle`, `bottom` |
|`lock` | `Bool` | User input lock |

## Protocols
| Protocol | Description |
|---|---|---|
|`jogDialWillBeginScroll(jogDial: KCJogDial)` | This method is called whenever the KCJogDial will begin an animated scroll. |
|`jogDialDidEndScroll(jogDial: KCJogDial)` | This method is called whenever the KCJogDial will ends an animated scroll. |
|`jogDialWillValueChanged(jogDial: KCJogDial)` | This method is called whenever the KCJogDial will value changed. |
|`jogDialDidValueChanged(jogDial: KCJogDial)` | This method is called whenever the KCJogDial did value changed. |

## License
The MIT License (MIT)

Copyright (c) 2015 Lee Sun-Hyoup

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
