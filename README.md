# KCJogDial
![Swift 2.0](https://img.shields.io/badge/Swift-2.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/kcjogdial.svg?style=flat)](http://cocoapods.org/pods/kcjogdial)
[![License](https://img.shields.io/cocoapods/l/kcjogdial.svg?style=flat)](http://cocoapods.org/pods/kcjogdial)
[![Platform](https://img.shields.io/cocoapods/p/kcjogdial.svg?style=flat)](http://cocoapods.org/pods/kcjogdial)

## Preview
![Preview gif](https://raw.github.com/kciter/KCJogDial/master/Screenshot/kcjogdial_preview.gif)

## Requirements
* iOS 8.0+
* Xcode 7.0

## Storyboard support
![Storyboard Screenshot](https://raw.github.com/kciter/KCJogDial/master/Screenshot/storyboard.png)

## Installation

### Cocoapods
```ruby
use_frameworks!
pod "KCJogDial"
```
### Manually
To install manually the KCJogDial in an app, just drag the `KCJogDial.swift` file into your project.

## Properties
| Properties | Type | Description |
|---|---|---|
| `enableRange` | `Bool` | Use range mode |
| `minimumValue` | `Double` | Acceptable minimum value |
| `maximumValue` | `Double` | Acceptable maximum value |
| `value` | `Double` | Value |
| `tick` | `Double` |  |
| `centerMarkColor` | `UIColor` | Set center mark color |
|` centerMarkWidth` | `CGFloat` | Set center mark width |
|` centerMarkHeightRatio` | `CGFloat` | Set center mark height |
|` centerMarkRadius` | `CGFloat` | Set center mark radius |
|` markColor` | `UIColor` | Set mark color |
|` markWidth` | `CGFloat` | Set mark width |
|` markRadius` | `CGFloat` | Set mark radius |
|` markCount` | `Int` | The number of mark in view |
|` padding` | `Double` | Vertical offfset from bottom in landscape mode |
|` verticalAlign` | `String` | Vertical Align as `top`, `middle`, `bottom` |

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
