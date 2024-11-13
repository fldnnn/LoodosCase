//
//  UIViewController+Ext.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitle: String = "Okey", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
