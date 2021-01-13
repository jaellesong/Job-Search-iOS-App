//
//  JobTheme.swift
//  ECA2
//
//  Created by Jaelle Song on 10/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit
import Foundation

// MARK: - colors
extension UIColor {
    static let saveRed = UIColor(red: 234/255.0, green: 93/255.0, blue: 94/255.0, alpha: 1.0)
    static let textGrey = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1.0)
    static let lightGrey =
    UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0) /* #d8d8d8 */
    static let myBlue =
    UIColor(red: 21/255, green: 84/255, blue: 149/255, alpha: 1.0) /* #155495 */
}

// MARK: - Gradient button
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical

    var startPoint : CGPoint {
        return points.startPoint
    }

    var endPoint : CGPoint {
        return points.endPoint
    }

    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}

extension UIView {
    func applyGradient(with colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.cornerRadius = 25
    }

    func applyGradient(with colours: [UIColor], gradient orientation: GradientOrientation) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}
// MARK: - Textfield styles
extension UITextField {
  func useUnderline() -> Void {
    let border = CALayer()
    let borderWidth = CGFloat(2.0) // Border Width
    border.borderColor = UIColor.lightGrey.cgColor
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}

// MARK: - Button Styles
extension UIButton {
    func styleSortBtn(){
        self.layer.cornerRadius = 25
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.myBlue.cgColor
        self.setTitleColor(.myBlue, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.backgroundColor = self.isSelected ? .myBlue : .clear
    }
    func styleFindBtn(){
        self.applyGradient(with: [
        UIColor(red: 55/255, green: 157/255, blue: 203/255, alpha: 1.0) /* #379dcb */,
            UIColor(red: 21/255, green: 84/255, blue: 149/255, alpha: 1.0) /* #155495 */], gradient: .horizontal)
        self.layer.cornerRadius = 20
    }
    func isNegative(){
        self.isSelected = false
        self.backgroundColor = .clear
    }
    func isPositive(){
        self.isSelected = true
        self.backgroundColor = .myBlue
    }
}
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
