//
//  ViewController.swift
//  KCHorizontalDial
//
//  Created by LeeSunhyoup on 2015. 9. 25..
//  Copyright © 2015년 LeeSunhyoup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, HorizontalDialDelegate {
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var horizontalDial: HorizontalDial?
    @IBOutlet var degreesValueLabel: UILabel?
    @IBOutlet var tickLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func horizontalDialDidValueChanged(_ horizontalDial: HorizontalDial) {
        let degrees = horizontalDial.value
        let radians = degreesToRadians(degrees)
        degreesValueLabel?.text = "\(round(degrees*100)/100) Degrees"
        imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
    }
    
    @IBAction func reset() {
        horizontalDial?.animateWithValueUpdate(0, duration: 2)
    }
    
    @IBAction func toMaximumValue() {
        guard let maximumValue = horizontalDial?.maximumValue else { return }
        horizontalDial?.animateWithValueUpdate(maximumValue, duration: 2)
    }
    
    @IBAction func toMinimumValue() {
        guard let minimumValue = horizontalDial?.minimumValue else { return }
        horizontalDial?.animateWithValueUpdate(minimumValue, duration: 2)
    }
    
    @IBAction func enableRangeValueChanged(_ _switch: UISwitch) {
        horizontalDial?.enableRange = _switch.isOn
    }
    
    @IBAction func tickValueChanged(_ stepper: UIStepper) {
        tickLabel?.text = "Tick \(stepper.value)"
        horizontalDial?.tick = stepper.value
    }
    
    @IBAction func verticalAlignValueChanged(_ segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            horizontalDial?.verticalAlign = "top"
        case 1:
            horizontalDial?.verticalAlign = "middle"
        case 2:
            horizontalDial?.verticalAlign = "bottom"
        default:
            return
        }
    }
    
    /// private function ///
    fileprivate func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * Double.pi / 180.0
    }
}

