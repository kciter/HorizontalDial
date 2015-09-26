//
//  KCJogDial.swift
//  KCJogDial
//
//  Created by LeeSunhyoup on 2015. 9. 25..
//  Copyright © 2015년 LeeSunhyoup. All rights reserved.
//

import UIKit

enum KCJogDialMagneticOptions {
    case Floor
    case Round
    case Ceil
    case None
}

enum KCJogDialAnimateOptions {
    case EaseInQuad
    case EaseOutQuad
    case EaseOutBounce
    case EaseOutBack
    case EaseOutElastic
}

protocol KCJogDialDelegate: class {
    func jogDialDidStartedScroll(jogDial: KCJogDial)
    func jogDialDidFinishedScroll(jogDial: KCJogDial)
    func jogDialShouldValueChanged(jogDial: KCJogDial)
    func jogDialWillValueChanged(jogDial: KCJogDial)
    func jogDialDidValueChanged(jogDial: KCJogDial)
}
extension KCJogDialDelegate {
    func jogDialDidStartedScroll(jogDial: KCJogDial) {}
    func jogDialDidFinishedScroll(jogDial: KCJogDial) {}
    func jogDialShouldValueChanged(jogDial: KCJogDial) {}
    func jogDialWillValueChanged(jogDial: KCJogDial) {}
    func jogDialDidValueChanged(jogDial: KCJogDial) {}
}

@IBDesignable
class KCJogDial: UIControl {
    @IBInspectable var enableRange: Bool = false {
        didSet {
            if enableRange == true && value < minimumValue {
                animateWithValueUpdate(minimumValue)
            } else if enableRange == true && value > maximumValue {
                animateWithValueUpdate(maximumValue)
            }
        }
    }
    @IBInspectable var minimumValue: Double = -100
    @IBInspectable var maximumValue: Double = 100
    @IBInspectable var value: Double = 0.0 {
        didSet {
            slidePosition = -value * (Double(frame.width) / Double(markCount)) / tick + Double(frame.width/2)
            setNeedsDisplay()
            delegate?.jogDialDidValueChanged(self)
        }
    }
    @IBInspectable var tick: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var centerMarkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var centerMarkWidth: CGFloat = 3.0
    @IBInspectable var centerMarkHeightRatio: CGFloat = 0.5
    @IBInspectable var centerMarkRadius: CGFloat = 5.0
    
    @IBInspectable var markColor: UIColor = UIColor.whiteColor()
    @IBInspectable var markWidth: CGFloat = 1.0
    @IBInspectable var markRadius: CGFloat = 1.0
    @IBInspectable var markCount: Int = 20
    
    @IBInspectable var padding: Double = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var verticalAlign: String = "middle" {
        didSet {
            setNeedsDisplay()
        }
    } // e.g.: top, middle, bottom
    
    var lock: Bool = false
    var delegate: KCJogDialDelegate? = nil
    
    var migneticOption: KCJogDialMagneticOptions = .Round
    var animateOption: KCJogDialAnimateOptions = .EaseOutBack
    private(set) var animated: Bool = false
    
    private var previousValue: Double = 0.0
    private var previousLocation = CGPoint()
    private var nextValue: Double = 0.0
    private var slidePosition: Double = 0.0
    private var lastTime: NSTimeInterval = CACurrentMediaTime()
    private var timer: NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        for index in 0...markCount {
            var relativePosition = (CGFloat((frame.width) / CGFloat(markCount)) * CGFloat(index) + CGFloat(slidePosition) - frame.width/2) % frame.width
            if relativePosition < 0 {
                relativePosition += frame.width
            }
            
            let screenWidth = self.bounds.width / 2.0
            let alpha = 1.0 - (abs(relativePosition-screenWidth) / screenWidth)
            CGContextSetFillColorWithColor(ctx, self.markColor.colorWithAlphaComponent(alpha).CGColor)
            
            let x = relativePosition - markWidth/2
            let width = markWidth
            var y: CGFloat = 0
            var height: CGFloat = 0
            
            if verticalAlign.containsString("top") {
                y = 0
                height = frame.height - CGFloat(padding*2)
            } else if verticalAlign.containsString("bottom") {
                y += CGFloat(padding*2)
                height = frame.height - y
            } else {
                y = CGFloat(padding)
                height = frame.height - CGFloat(padding*2)
            }
            let rect = CGRect(x: x, y: y, width: width, height: height)
            
            let path = UIBezierPath(roundedRect: rect, cornerRadius: markRadius)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
        }
        
        var centerMarkPositionY: CGFloat = 0
        let centerMarkHeight: CGFloat = frame.height*centerMarkHeightRatio
        if verticalAlign.containsString("top") {
            centerMarkPositionY = 0
        } else if verticalAlign.containsString("bottom") {
            centerMarkPositionY = frame.height - centerMarkHeight
        } else {
            centerMarkPositionY = frame.height/2-centerMarkHeight/2
        }
        let path = UIBezierPath(roundedRect:
            CGRectMake(frame.width/2 - centerMarkWidth/2, centerMarkPositionY, centerMarkWidth, centerMarkHeight), cornerRadius: centerMarkRadius)
        CGContextAddPath(ctx, path.CGPath)
        
        CGContextSetFillColorWithColor(ctx, centerMarkColor.CGColor)
        CGContextAddPath(ctx, path.CGPath)
        CGContextFillPath(ctx)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        guard tick != 0 && lock != true else { return false }
        
        stopAnimation()
        
        previousLocation = touch.locationInView(self)
        
        animated = false
        
        delegate?.jogDialDidStartedScroll(self)
        
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        guard tick != 0 && lock != true else { return false }
        
        let location = touch.locationInView(self)
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = deltaLocation / (Double(frame.width) / Double(markCount)) * tick
        
        previousLocation = location
        
        self.value -= deltaValue
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        guard tick != 0 && lock != true else { return }
        
        if enableRange == true && value < minimumValue {
            animateWithValueUpdate(minimumValue)
        } else if enableRange == true && value > maximumValue {
            animateWithValueUpdate(maximumValue)
        } else {
            switch migneticOption {
            case .Ceil:
                animateWithValueUpdate(ceil(value * (10.0/tick) / 10.0) * (10.0 / (10.0/tick)))
            case .Floor:
                animateWithValueUpdate(floor(value * (10.0/tick) / 10.0) * (10.0 / (10.0/tick)))
            case .Round:
                animateWithValueUpdate(round(value * (10.0/tick) / 10.0) * (10.0 / (10.0/tick)))
            case .None:
                break
            }
        }
        
        delegate?.jogDialDidFinishedScroll(self)
    }
    
    func animateWithValueUpdate(nextValue: Double, duration: Double = 1.0) {
        previousValue = value
        self.nextValue = nextValue
        if nextValue == previousValue { return }
        
        stopAnimation()
        animated = true
        lastTime = CACurrentMediaTime()
        timer = NSTimer(timeInterval:1.0/60.0, target: self, selector: "step", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
    }
    
    func step() {
        let currentTime: NSTimeInterval = CACurrentMediaTime()
        let elapsedTime = currentTime - self.lastTime;
        
        let time: NSTimeInterval = min(1.0, elapsedTime);
        
        switch animateOption {
        case .EaseInQuad:
            value = easeInQuad(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .EaseOutQuad:
            value = easeOutQuad(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .EaseOutBounce:
            value = easeOutBounce(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .EaseOutBack:
            value = easeOutBack(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .EaseOutElastic:
            value = easeOutElastic(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        }
        
        delegate?.jogDialDidValueChanged(self)
        
        if time >= 1.0 {
            stopAnimation()
        }
    }
    
    private func stopAnimation() {
        animated = false
        timer?.invalidate()
        timer = nil
    }
}

extension KCJogDial {
    private func easeInQuad(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        return c*(t/d)*(t/d) + b
    }
    
    private func easeOutQuad(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        return -c*(t/d)*(t/d-2) + b
    }
    
    private func easeOutBounce(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        if ((t/d) < (1/2.75)) {
            return c*(7.5625*t/d*t/d) + b
        } else if (t/d < (2/2.75)) {
            return c*(7.5625*(t/d-(1.5/2.75))*(t-(1.5/2.75)) + 0.75) + b
        } else if (t < (2.5/2.75)) {
            return c*(7.5625*(t/d-(2.25/2.75))*(t-(2.25/2.75)) + 0.9375) + b
        } else {
            return c*(7.5625*(t/d-(2.625/2.75))*(t-(2.625/2.75)) + 0.984375) + b
        }
    }
    
    private func easeOutElastic(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        let π = M_PI
        var s = 1.70158, p = 0.0, a = c
        
        if (t == 0) { return b }
        if (t/d >= 1) { return b+c }
        if (p == 0) { p = d*0.3 }
        
        if (a < abs(c)) { a = c; s = p/4.0 }
        else { s = p/(2.0*π) * asin(c/a) }
        
        return a*pow(2.0,-10.0*(t/d)) * sin((t-s)*(2.0*π)/p) + c + b
    }
    
    private func easeOutBack(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        let s = 2.70158
        let t = t/d-1
        return (t*t*((s+1)*t + s) + 1)*c+b
    }
}
