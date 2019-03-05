//
//  Extension.swift
//  AshwiniMachineTask
//


import Foundation
import UIKit



extension UIView{
    func addShadow(radius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.shadowRadius = radius

    }
}
