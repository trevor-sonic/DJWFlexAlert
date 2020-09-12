//
//  SectionMenuList.swift
//  Stage2
//
//  Created by dejaWorks on 14/11/2018.
//  Copyright © 2018 dejaWorks. All rights reserved.
//

import Foundation

open class Choice{
    
    public typealias MenuResult = ((Choice.Menu)->())
    public enum Menu{
        case selection(Int)
        case cancel
    }
    
    /// Popup for OK | Cancel OR Delete | Cancel kind confirmation
    public typealias ConfirmResult = ((Choice.Confirm)->())
    public enum Confirm{
        case ok
        case cancel
    }
    
    /// Popup for Option1 | Option 2 | Cancel
    public typealias OptionResult = ((Choice.Option)->())
    public enum Option{
        case opt1
        case opt2
        case cancel
    }
    
    /// RM Result ok | cancel
    public typealias BasicResult = ((Choice.Result)->())
    public enum Result {
        case success
        case error
        case cancel
    }
    
//    /// Add Channel
//    typealias AddChannelResult = ((Choice.ChannelType)->())
//    enum ChannelType {
//        case audio
//        case midi
//        case cancel
//    }
}
