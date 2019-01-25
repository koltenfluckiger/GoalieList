//
//  PointsViewControllerExtension.swift
//  GoalList
//
//  Created by Kolten Fluckiger on 7/4/18.
//  Copyright © 2018 Kolten Fluckiger. All rights reserved.
//

import Foundation
import UIKit

extension PointsViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pointsTextField {
            let currentText = pointsTextField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let changedText = currentText.replacingCharacters(in: stringRange, with: string)
            return changedText.count <= 4
        }
        return true
    }
}
