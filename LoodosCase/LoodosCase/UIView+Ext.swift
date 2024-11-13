//
//  UIView+Ext.swift
//  LoodosCase
//
//  Created by fulden onan on 13.11.2024.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Eğer önceden bir gradient layer varsa, onu kaldır
        if let oldGradientLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
