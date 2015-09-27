//
//  ViewController.swift
//  KCJogDial
//
//  Created by LeeSunhyoup on 2015. 9. 25..
//  Copyright © 2015년 LeeSunhyoup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, KCJogDialDelegate {
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var jogDial: KCJogDial?
    @IBOutlet var degreesValueLabel: UILabel?
    @IBOutlet var tickLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        jogDial!.delegate = self
    }
    
    func jogDialDidValueChanged(jogDial: KCJogDial) {
        let degrees = jogDial.value
        let radians = degreesToRadians(degrees)
        degreesValueLabel?.text = "\(round(degrees*100)/100) Degrees"
        imageView?.transform = CGAffineTransformMakeRotation(CGFloat(radians))
    }
    
    @IBAction func reset() {
        jogDial?.animateWithValueUpdate(0, duration: 2)
    }
    
    @IBAction func toMaximumValue() {
        if let maximumValue = jogDial?.maximumValue {
            jogDial?.animateWithValueUpdate(maximumValue, duration: 2)
        }
    }
    
    @IBAction func toMinimumValue() {
        if let minimumValue = jogDial?.minimumValue {
            jogDial?.animateWithValueUpdate(minimumValue, duration: 2)
        }
    }
    
    @IBAction func enableRangeValueChanged(_switch: UISwitch) {
        jogDial?.enableRange = _switch.on
    }
    
    @IBAction func tickValueChanged(stepper: UIStepper) {
        tickLabel?.text = "Tick \(stepper.value)"
        jogDial?.tick = stepper.value
    }
    
    @IBAction func verticalAlignValueChanged(segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            jogDial?.verticalAlign = "top"
        case 1:
            jogDial?.verticalAlign = "middle"
        case 2:
            jogDial?.verticalAlign = "bottom"
        default:
            return
        }
    }
    
    /// private function ///
    private func degreesToRadians(degrees: Double) -> Double {
        return degrees*M_PI/180.0
    }
}

