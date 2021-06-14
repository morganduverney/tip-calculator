//
//  ViewController.swift
//  TipCalculator
//
//  Created by Morgan Duverney on 6/14/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardAsNeeded()
        numberFormatter.numberStyle = .currency
        billAmount.delegate = self
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValueLabel.text = "\(Int(sender.value))%"
        updateValues(sliderValue: sender.value)
    }
    
    private func updateValues(sliderValue: Float) {
        guard let billAmounText = billAmount.text,
              let billValue = Double(billAmounText) else {
            return
        }
        let tipPercentage = sliderValue
        let tipValue = billValue * Double(tipPercentage / 100)
        tipAmount.text = numberFormatter.string(for: tipValue)
        total.text = numberFormatter.string(for: tipValue+billValue)
    }
    
    private func dismissKeyboardAsNeeded() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateValues(sliderValue: slider.value)
    }
}
