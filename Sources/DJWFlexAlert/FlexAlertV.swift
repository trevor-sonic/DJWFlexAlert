//
//  FlexAlertV.swift
//  UIExp
//
//  Created by dejaWorks on 16/09/2019.
//  Copyright © 2019 dejaWorks. All rights reserved.
//

import UIKit
import SnapKit
import DJWUIBuilder
import DJWBuilderNS
import DJWBindableNS
import DJWCommon

open class FlexAlertV: UIScrollView {

    /// when buttons are vertical
    let buttonWidth:CGFloat = 120
    
    /// when buttons are horizontal
    let buttonHeight:CGFloat = 50
    
    let insideOffset:CGFloat = 12
    
    lazy var holderV = UIViewBuilder()
        .bgColor(.darkGray)
        .round(16)
        .buildAndAdd(on: self)
    
//    lazy var button = Build.Bindable.Button(title: "Close")
//        .bgColor(Styler.lightTrans)
//        .bind { self.onClose() }
//        .buildAndAdd(on: holderV)
    
    
    lazy var titleLabel:UILabel = UILabelBuilder(kind: UIFontBuilder.Kind.xlBold, text: "Popup Title")
        .align(.center)
        .buildAndAdd(on: holderV)
    
    lazy var contentV:UIView = UIViewBuilder()
        .bgColor(.darkGray)
        .buildAndAdd(on: holderV)
    
    lazy var textV:UITextView = {
        let tv = UITextView()
        
        tv.backgroundColor = .clear
        contentV.addSubview(tv)
        
        tv.showsVerticalScrollIndicator = true
        tv.alwaysBounceVertical = true
        tv.text = ""
        tv.textAlignment = .center
        
        tv.font = UIFontBuilder.init(kind: UIFontBuilder.Kind.lRegular).build()
        tv.textColor = .white
        
        tv.snp.makeConstraints({ make in
            make.edges.equalTo(contentV)
        })
        return tv
    }()
    lazy var textField:UITextField = {
        let tf:UITextField = UITextField()
        contentV.addSubview(tf)
        tf.delegate  = self
        tf.becomeFirstResponder()
        tf.font = UIFontBuilder.init(kind: UIFontBuilder.Kind.lRegular).build()
        tf.textColor = .white
        tf.snp.makeConstraints({ make in
            make.top.left.right.equalTo(contentV)
        })
        
        return tf
    }()
    
    lazy var textLabel:UILabel = {
        let lbl:UILabel = UILabelBuilder()
            .font(UIFontBuilder.init(kind: UIFontBuilder.Kind.lRegular).build())
            .textColor(with: .white)
            .buildAndAdd(on: contentV)
    
        lbl.snp.makeConstraints({ make in
            make.top.left.right.equalTo(contentV)
            make.height.equalTo(20)
        })
        
        return lbl
    }()
    
    lazy var stack:UIStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.center)
        .distribution(UIStackView.Distribution.fillEqually)
        .buildAndAdd(on: holderV)
    
    /// to implement in VC
    var onClose:()->Void = {}
    
    var buttons:[Bindable.Button] = []
    
    enum AlertType{
        case portrait
        case landscape
        case unknown
    }
    var lastAlertType:AlertType = .unknown
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        isScrollEnabled = false
        setConstrains()
    }
    func setCustom(ui:UIView){
        contentV.addSubview(ui)
        ui.snp.makeConstraints({ make in
            make.edges.equalTo(contentV)
        })
    }
    
    func getButton(title:String, type:FlexAlertVC.ButtonType , onTap:@escaping ClosureBasic )->Bindable.Button {
        let button = Builder.BButton(title: title)
            .tint(.white)
            .font(UIFontBuilder.init(kind: UIFontBuilder.Kind.lRegular).build())
            .border(1, color: .lightGray)
            .bind { _ in onTap(); self.onClose() }
            .build()
        
        if type == .danger {
            button.tintColor = .red
            button.titleLabel?.font = UIFontBuilder.init(kind: UIFontBuilder.Kind.lBold).build()
        }
        if type == .strong {
            button.titleLabel?.font = UIFontBuilder.init(kind: UIFontBuilder.Kind.lBold).build()
        }
        
        return button
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
   
 
 
    func setConstrains(){
        

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(holderV)
            make.right.equalTo(holderV).offset(0)
            make.top.equalTo(holderV).inset(10)
        }
        buttons.forEach { button in
            stack.addArrangedSubview(button)
            button.snp.makeConstraints({ make in
                make.height.equalTo(50)
            })
        }
        
        resize()
    }
    func resize(keyboardSize:CGSize? = nil){
        
        let keyboardH = keyboardSize?.height ?? 209.0
        print("keyboardH: \(String(describing: keyboardH))")
        print("contentSize: \(String(describing: contentSize))")

        if frame.height == 0 {return}
        //if frame.width < 560 {
        if (frame.height - keyboardH > 320 || frame.width <= 320) {
            // portrait - normal
            lastAlertType = .portrait
            
            holderV.snp.remakeConstraints { make in
                make.width.equalTo(300)
                make.height.equalTo(200)
                make.center.equalTo(self)
            }
            
            
            stack.axis = .horizontal
            stack.snp.remakeConstraints { make in
                make.width.equalTo(holderV).offset(4)
                make.bottom.equalTo(holderV).offset(2)
                make.centerX.equalTo(holderV)
            }
            
            buttons.forEach { button in
                stack.addArrangedSubview(button)
                button.snp.remakeConstraints({ make in
                    make.height.equalTo(buttonHeight)
                })
            }
            
            titleLabel.snp.updateConstraints { make in
                make.right.equalTo(holderV)
            }
            
            contentV.snp.remakeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(insideOffset)
                make.left.equalTo(holderV).offset(insideOffset)
                make.bottom.equalTo(holderV).offset(-buttonHeight - insideOffset)
                make.right.equalTo(holderV).offset(-insideOffset)
            }
            
        }else if lastAlertType != .landscape{
            
            lastAlertType = .landscape
            
            // landscape - thin
            holderV.snp.remakeConstraints { make in
                make.width.equalTo(460)
                make.height.equalTo(120)
                make.center.equalTo(self)
            }
            
            stack.axis = .vertical
            stack.snp.remakeConstraints { make in
                make.height.equalTo(holderV).offset(4)
                make.right.equalTo(holderV).offset(2)
                make.centerY.equalTo(holderV)
                
            }
            
            
            buttons.enumerated().forEach { (i,button) in
                guard let last = buttons.indices.last else {return}
                stack.addArrangedSubview(buttons[last - i])
                button.snp.remakeConstraints({ make in
                    make.width.equalTo(buttonWidth)
                })
            }
            
            titleLabel.snp.updateConstraints { make in
                make.right.equalTo(holderV).offset(-buttonWidth)
            }
            
            contentV.snp.remakeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(insideOffset)
                make.left.equalTo(holderV).offset(insideOffset)
                make.bottom.equalTo(holderV).offset(-insideOffset)
                make.right.equalTo(holderV).offset(-buttonWidth - insideOffset)
            }
        }
        
        
    }
}
extension FlexAlertV:UITextFieldDelegate{}
