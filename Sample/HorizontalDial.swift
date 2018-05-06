//
//  KCHorizontalDial.swift
//  KCHorizontalDial
//
//  Created by LeeSunhyoup on 2015. 9. 25..
//  Copyright © 2015년 LeeSunhyoup. All rights reserved.
//

import UIKit

public enum HorizontalDialMagneticOptions {
    case floor
    case round
    case ceil
    case none
}

public enum HorizontalDialAnimateOptions {
    case easeInQuad
    case easeOutQuad
    case easeOutBounce
    case easeOutBack
    case easeOutElastic
}

@objc public protocol HorizontalDialDelegate {
    @objc optional func horizontalDialWillBeginScroll(_ horizontalDial: HorizontalDial)
    @objc optional func horizontalDialDidEndScroll(_ horizontalDial: HorizontalDial)
    @objc optional func horizontalDialWillValueChanged(_ horizontalDial: HorizontalDial)
    @objc optional func horizontalDialDidValueChanged(_ horizontalDial: HorizontalDial)
}

@IBDesignable
public final class HorizontalDial: UIControl {
    @IBInspectable public var enableRange: Bool = false {
        didSet {
            if enableRange == true && value < minimumValue {
                animateWithValueUpdate(minimumValue)
            } else if enableRange == true && value > maximumValue {
                animateWithValueUpdate(maximumValue)
            }
        }
    }
    @IBInspectable public var minimumValue: Double = -100
    @IBInspectable public var maximumValue: Double = 100
    @IBInspectable public var value: Double = 0.0 {
        didSet {
            slidePosition = -value * (Double(frame.width) / Double(markCount)) / tick + Double(frame.width/2)
            setNeedsDisplay()
            delegate?.horizontalDialDidValueChanged?(self)
        }
    }
    @IBInspectable public var tick: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var centerMarkColor: UIColor = UIColor.yellow
    @IBInspectable public var centerMarkWidth: CGFloat = 3.0
    @IBInspectable public var centerMarkHeightRatio: CGFloat = 0.5
    @IBInspectable public var centerMarkRadius: CGFloat = 5.0
    
    @IBInspectable public var markColor: UIColor = UIColor.white
    @IBInspectable public var markWidth: CGFloat = 1.0
    @IBInspectable public var markRadius: CGFloat = 1.0
    @IBInspectable public var markCount: Int = 20
    
    @IBInspectable public var padding: Double = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var verticalAlign: String = "middle" {
        didSet {
            setNeedsDisplay()
        }
    } // e.g.: top, middle, bottom
    
    public var lock: Bool = false
    @IBOutlet public weak var delegate: AnyObject?
    
    public var migneticOption: HorizontalDialMagneticOptions = .round
    public var animateOption: HorizontalDialAnimateOptions = .easeOutBack
    fileprivate(set) var animated: Bool = false
    
    fileprivate var previousValue: Double = 0.0
    fileprivate var previousLocation = CGPoint()
    fileprivate var nextValue: Double = 0.0
    fileprivate var slidePosition: Double = 0.0
    fileprivate var lastTime: TimeInterval = CACurrentMediaTime()
    fileprivate var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        for index in 0...markCount {
            var relativePosition = (CGFloat((frame.width) / CGFloat(markCount)) * CGFloat(index) + CGFloat(slidePosition) - frame.width/2).truncatingRemainder(dividingBy: frame.width)
            if relativePosition < 0 {
                relativePosition += frame.width
            }
            
            let screenWidth = self.bounds.width / 2.0
            let alpha = 1.0 - (abs(relativePosition-screenWidth) / screenWidth)
            ctx.setFillColor(self.markColor.withAlphaComponent(alpha).cgColor)
            
            let x = relativePosition - markWidth/2
            let width = markWidth
            var y: CGFloat = 0
            var height: CGFloat = 0
            
            if verticalAlign.contains("top") {
                y = 0
                height = frame.height - CGFloat(padding*2)
            } else if verticalAlign.contains("bottom") {
                y += CGFloat(padding*2)
                height = frame.height - y
            } else {
                y = CGFloat(padding)
                height = frame.height - CGFloat(padding*2)
            }
            let rect = CGRect(x: x, y: y, width: width, height: height)
            
            let path = UIBezierPath(roundedRect: rect, cornerRadius: markRadius)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
        }
        
        var centerMarkPositionY: CGFloat = 0
        let centerMarkHeight: CGFloat = frame.height*centerMarkHeightRatio
        if verticalAlign.contains("top") {
            centerMarkPositionY = 0
        } else if verticalAlign.contains("bottom") {
            centerMarkPositionY = frame.height - centerMarkHeight
        } else {
            centerMarkPositionY = frame.height/2-centerMarkHeight/2
        }
        let path = UIBezierPath(roundedRect:
            CGRect(x: frame.width/2 - centerMarkWidth/2, y: centerMarkPositionY, width: centerMarkWidth, height: centerMarkHeight), cornerRadius: centerMarkRadius)
        ctx.addPath(path.cgPath)
        
        ctx.setFillColor(centerMarkColor.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
    }
    
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard tick != 0 && lock != true else { return false }
        
        stopAnimation()
        
        previousLocation = touch.location(in: self)
        
        animated = false
        
        delegate?.horizontalDialWillBeginScroll?(self)
        
        return true
    }
    
    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard tick != 0 && lock != true else { return false }
        
        let location = touch.location(in: self)
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = deltaLocation / (Double(frame.width) / Double(markCount)) * tick
        
        previousLocation = location
        
        self.value -= deltaValue
        
        return true
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard tick != 0 && lock != true else { return }
        
        if enableRange == true && value < minimumValue {
            animateWithValueUpdate(minimumValue)
        } else if enableRange == true && value > maximumValue {
            animateWithValueUpdate(maximumValue)
        } else {
            switch migneticOption {
            case .ceil:
                animateWithValueUpdate(ceil(value * (10.0/tick) / 10.0) * (10.0 / (10.0/tick)))
            case .floor:
                animateWithValueUpdate(floor(value * (10.0/tick) / 10.0) * (10.0 / (10.0/tick)))
            case .round:
                animateWithValueUpdate(round(value * (10.0/tick) / 10.0) * (10.0 / (10.0/tick)))
            case .none:
                break
            }
        }
        
        delegate?.horizontalDialDidEndScroll?(self)
    }
    
    public func animateWithValueUpdate(_ nextValue: Double, duration: Double = 1.0) {
        previousValue = value
        self.nextValue = nextValue
        if nextValue == previousValue { return }
        
        stopAnimation()
        animated = true
        lastTime = CACurrentMediaTime()
        timer = Timer(timeInterval:1.0/60.0, target: self, selector: #selector(HorizontalDial.step), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    @objc func step() {
        let currentTime: TimeInterval = CACurrentMediaTime()
        let elapsedTime = currentTime - self.lastTime;
        
        let time: TimeInterval = min(1.0, elapsedTime);
        
        switch animateOption {
        case .easeInQuad:
            value = easeInQuad(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .easeOutQuad:
            value = easeOutQuad(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .easeOutBounce:
            value = easeOutBounce(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .easeOutBack:
            value = easeOutBack(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        case .easeOutElastic:
            value = easeOutElastic(time: time, startValue: previousValue, endValue: nextValue, duration: 1.0)
        }
        
        delegate?.horizontalDialDidValueChanged?(self)
        
        if time >= 1.0 {
            stopAnimation()
        }
    }
    
    fileprivate func stopAnimation() {
        animated = false
        timer?.invalidate()
        timer = nil
    }
}

extension HorizontalDial {
    fileprivate func easeInQuad(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        return c*(t/d)*(t/d) + b
    }
    
    fileprivate func easeOutQuad(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        return -c*(t/d)*(t/d-2) + b
    }
    
    fileprivate func easeOutBounce(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
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
    
    fileprivate func easeOutElastic(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        let π = Double.pi
        var s = 1.70158, p = 0.0, a = c
        
        if (t == 0) { return b }
        if (t/d >= 1) { return b+c }
        if (p == 0) { p = d*0.3 }
        
        if (a < abs(c)) { a = c; s = p/4.0 }
        else { s = p/(2.0*π) * asin(c/a) }
        
        return a*pow(2.0,-10.0*(t/d)) * sin((t-s)*(2.0*π)/p) + c + b
    }
    
    fileprivate func easeOutBack(time t: Double, startValue b: Double, endValue e: Double, duration d: Double) -> Double {
        let c = e - b
        let s = 2.70158
        let t = t/d-1
        return (t*t*((s+1)*t + s) + 1)*c+b
    }
}
