//
//  File.swift
//  
//
//  Created by dejaWorks on 11/07/2020.
//
import UIKit
import DJWBuilderNS
import DJWUIBuilder
import DJWCommon

public extension Builder {
    
    /// Returns FlaexAlerVC
    class FlexAlert{
    
        let fa:FlexAlertVC
        
        public init(title:String) {
            fa = FlexAlertVC()
            fa.flexAlertV.titleLabel.text = title
        }
        
        public func addButton(title:String, type:FlexAlertVC.ButtonType, onTap:@escaping ClosureBasic)->Self{
            let button = fa.getButton(title: title, type: type, onTap: onTap)
            fa.buttons.append(button)
            return self
        }
        public func message(_ text:String)->Self{
            fa.flexAlertV.textV.text = text
            return self
        }
        public func custom(ui:UIView)->Self{
            fa.flexAlertV.setCustom(ui: ui)
            return self
        }
        public func textField(text:String)->Self{
            fa.flexAlertV.textField.text = text
            return self
        }
        public func textLabel(text:String)->Self{
            fa.flexAlertV.textLabel.text = text
            return self
        }
        public func onClose(done:@escaping ()->Void ) -> Self {
            fa.onCloseCallback = done
            return self
        }
        public func done()->FlexAlertVC{
            return fa
        }
    }
}
