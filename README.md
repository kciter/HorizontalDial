# KCHorizontalDial
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/KCHorizontalDial.svg?style=flat)](http://cocoapods.org/pods/kchorizontaldial)
[![License](https://img.shields.io/cocoapods/l/KCHorizontalDial.svg?style=flat)](http://cocoapods.org/pods/kchorizontaldial)
[![Platform](https://img.shields.io/cocoapods/p/KCHorizontalDial.svg?style=flat)](http://cocoapods.org/pods/kchorizontaldial)

## Preview
<img src="https://github.com/kciter/KCHorizontalDial/raw/master/Images/preview.gif" alt="Preview gif">

## Requirements
* iOS 8.0+
* Swift 3
* Xcode 8.0

## Storyboard support
<img src="https://github.com/kciter/KCHorizontalDial/raw/master/Images/storyboard.png" width="50%" alt="Storyboard Screenshot">

## Installation

### CocoaPods
```ruby
use_frameworks!
pod "KCHorizontalDial"
```
### Manually
To install manually the KCHorizontalDial in an app, just drag the `KCHorizontalDial.swift` file into your project.

## Properties
| Property | Type | Description |
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
|`padding` | `Double` | Vertical offset from bottom in landscape mode |
|`verticalAlign` | `String` | Vertical Align as `top`, `middle`, `bottom` |
|`lock` | `Bool` | User input lock |

## Protocols
| Protocol | Description |
|---|---|---|
|`horizontalDialWillBeginScroll(horizontalDial: KCHorizontalDial)` | This method is called whenever the KCHorizontalDial will begin an animated scroll. |
|`horizontalDialDidEndScroll(horizontalDial: KCHorizontalDial)` | This method is called whenever the KCHorizontalDial will ends an animated scroll. |
|`horizontalDialWillValueChanged(horizontalDial: KCHorizontalDial)` | This method is called whenever the KCHorizontalDial will value changed. |
|`horizontalDialDidValueChanged(horizontalDial: KCHorizontalDial)` | This method is called whenever the KCHorizontalDial did value changed. |

## TODO
* Code refactoring
* Optimizing UI performance
* Add `clipsToRange` property
* Add `unit` property

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
