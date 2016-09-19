//
//  Santa'sLittleHelpers.swift
//  
//
//  Created by Владимир Елизаров on 18.09.16.
//
//

import Foundation


//MARK: - Charged Conditions

extension Bool {
    
    func onTrue(@noescape f:()->Void)->Bool{
        if self { f() }
        return self
    }
    
    func onFalse(@noescape f:()->Void)->Bool {
        if !self { f() }
        return self
    }
}
