//
//  FlexAlertVC.swift
//  UIExp
//
//  Created by dejaWorks on 16/09/2019.
//  Copyright © 2019 dejaWorks. All rights reserved.
//

import UIKit
import DJWKeyboardTools
import DJWBuilderNS
import DJWUIBuilder
import DJWBindableNS
import DJWCommon

public class FlexAlertVC: UIViewController {

    public enum ButtonType{
        case normal, strong, danger
    }
    
    
    open var flexAlertV:FlexAlertV {return view as! FlexAlertV}
    
    open var onCloseCallback:()->Void = {print("⚠️ Implement onClose")}
    var keyboardSizeManager:KeyboardSizeManager?
    
    var lastSize:CGSize = CGSize.zero
    var lastKeyboardSize:CGSize = CGSize.zero
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // presentation style
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override public func loadView() {
        super.loadView()
        view = FlexAlertV()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardSizer()
        registerForKeyboardNotifications()
        keepPosition()
        
//        Global.later(2) {
//        self.flexAlertV.resize(keyboardSize:self.keyboardSizeManager?.keyboardSize)
//        self.keepPosition()
//        }
        flexAlertV.onClose = { [weak self] in
            self?.close()
        }
        
    
    }
    deinit {
        print("deinit \(self.description)")
        unregisterFromKeyboardNotifications()
    }

    private func close(){
        self.dismiss(animated: true, completion: { [weak self] in
            self?.onCloseCallback()
        })
    }
    
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if lastSize != flexAlertV.bounds.size || lastKeyboardSize != (keyboardSizeManager?.keyboardSize ?? CGSize.zero){
            lastSize = flexAlertV.bounds.size
            lastKeyboardSize = keyboardSizeManager?.keyboardSize ?? CGSize.zero
            
            
            flexAlertV.resize(keyboardSize:keyboardSizeManager?.keyboardSize)
        }
    }
    
    func keepPosition(){
        
        // MARK: - Scroll the screen according to the keyboard size
        keyboardSizeManager?.aView = flexAlertV.holderV
        keyboardSizeManager?.holderWindow = UIApplication.shared.keyWindow
        keyboardSizeManager?.scrollV = flexAlertV
        keyboardSizeManager?.holderView = flexAlertV
        keyboardSizeManager?.scrollToCursor()
        
    }
    
    // MARK: - Transit vars
    var buttons:[DBindable.Button]{
        set{
            flexAlertV.buttons = newValue
        }
        get{
            return flexAlertV.buttons
        }
    }
    func getButton(title:String, type:FlexAlertVC.ButtonType , onTap:@escaping ClosureBasic )->DBindable.Button{
        return flexAlertV.getButton(title: title, type:type , onTap: onTap)
    }
}
extension FlexAlertVC:KeyboardSizeManagerDelegate {
    public func setupKeyboardSizer(){
        keyboardSizeManager = KeyboardSizeManager()
        keyboardSizeManager?.delegate = self
    }
    public func unregisterFromKeyboardNotifications(){
        keyboardSizeManager?.unregisterFromKeyboardNotifications()
        keyboardSizeManager = nil
    }
    public func registerForKeyboardNotifications(){
        keyboardSizeManager?.registerForKeyboardNotifications()
    }
    public func keyboarDidShown(notification: NSNotification){}
    public func keyboardDidHide(notification: NSNotification) {}
}


