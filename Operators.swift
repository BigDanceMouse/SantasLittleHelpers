//
//  Santa'sLittleHelpers.swift
//  
//
//  Created by Владимир Елизаров on 18.09.16.
//
//

import Foundation


///Apply function if not nil
infix operator >>=: AdditionPrecedence

func >>=<A,B>(_ val:A?, _ f:(A)->B)->B? {
    
    if let _val = val {
        return f(_val)
    }
    else {
        return nil
    }
}


///Execute when not nil
infix operator +?: AdditionPrecedence

func +?<A>(_ val:A?, _ f:()->Void) -> A? {
    
    if val != nil {
        f()
    }
    return val
}


///Execute when nil
infix operator -?: AdditionPrecedence

func -?<A>(_ val:A?, _ f:()->Void) -> A? {
    
    if val == nil {
        f()
    }
    return val
}


///Function composition
infix operator ..: MultiplicationPrecedence

func ..<A,B,C>(lf:@escaping (A)->B, rf:@escaping (B)->C)->(A)->C {
    return {
        rf(lf($0))
    }
}



///Apply function
infix operator ||>: LogicalDisjunctionPrecedence

func ||><A,B>( _ f:(A)->B, _ x:A)->B {
    return f(x)
}



///Filp
prefix func !<A,B,C>(f:@escaping (A,B)->C)->(B,A)->C {
    return {
        return f($1,$0)
    }
}




