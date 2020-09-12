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

public class Alert {
    // MARK: - FlexAlert Confirmation OK - Cancel
    public static func confirmNormal(vc:UIViewController, title:String, message:String, defaultText:String = "OK", cancelText:String = "Cancel", choice:@escaping Choice.ConfirmResult){

        let alert = Builder.FlexAlert(title: title)
            .addButton(title: cancelText, type: FlexAlertVC.ButtonType.normal, onTap: { choice(.cancel) })
            .addButton(title: defaultText, type: FlexAlertVC.ButtonType.strong, onTap: { choice(.ok) })
            .message(message)
            .onClose {}
            .done()
        
        vc.present(alert, animated: true) {}
        
        return
    }
    
    // MARK: - FlexAlert Confirmation DELETE - Cancel
    public static func confirmDanger(vc:UIViewController, title:String, message:String, dangerText:String = "DELETE", cancelText:String = "Cancel", choice:@escaping Choice.ConfirmResult){

        let alert = Builder.FlexAlert(title: title)
            .addButton(title: cancelText, type: FlexAlertVC.ButtonType.normal, onTap: { choice(.cancel) })
            .addButton(title: dangerText, type: FlexAlertVC.ButtonType.danger, onTap: { choice(.ok) })
            .message(message)
            .onClose {}
            .done()
        
        vc.present(alert, animated: true) {}
         
        return
    }
    
    // MARK: - FlexAlert Confirmation Options - Cancel
    public static func confirmOption(vc:UIViewController,
                                     title:String, message:String,
                                     option1text:String = "Option 1",
                                     option2text:String = "Option 2",
                                     cancelText:String = "Cancel",
                                     choice:@escaping Choice.OptionResult){

        let alert = Builder.FlexAlert(title: title)
            
            .addButton(title: cancelText, type: FlexAlertVC.ButtonType.normal, onTap: { choice(.cancel) })
            .addButton(title: option1text, type: FlexAlertVC.ButtonType.strong, onTap: { choice(.opt1) })
            .addButton(title: option2text, type: FlexAlertVC.ButtonType.strong, onTap: { choice(.opt2) })
            
            
            .message(message)
            .onClose {}
            .done()
        
        vc.present(alert, animated: true) {}
        
        return
    }
    
    // MARK: - FlexAlert OK
    public static func displayAlert(vc:UIViewController,
                                    title:String, message:String, _ done:@escaping ClosureBasic){
        
        let alert = Builder.FlexAlert(title: title)
            .addButton(title: "OK", type: FlexAlertVC.ButtonType.normal, onTap: {})
            .message(message)
            .onClose { done() }
            .done()
        
        vc.present(alert, animated: true) {}
    }
}



