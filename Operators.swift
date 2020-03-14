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

public func >>=<A,B>(_ val:A?, _ f:(A)->B)->B? {
    
    if let _val = val {
        return f(_val)
    }
    else {
        return nil
    }
}


///Execute when not nil
infix operator +?: AdditionPrecedence

public func +?<A>(_ val:A?, _ f:()->Void) -> A? {
    
    if val != nil {
        f()
    }
    return val
}


///Execute when nil
infix operator -?: AdditionPrecedence

public func -?<A>(_ val:A?, _ f:()->Void) -> A? {
    
    if val == nil {
        f()
    }
    return val
}


///Function composition
infix operator ..: MultiplicationPrecedence

public func ..<A,B,C>(lf:@escaping (A)->B, rf:@escaping (B)->C)->(A)->C {
    return {
        rf(lf($0))
    }
}



///Apply function
infix operator ||>: LogicalDisjunctionPrecedence

public func ||><A,B>( _ f:(A)->B, _ x:A)->B {
    return f(x)
}



///Filp
public prefix func !<A,B,C>(f:@escaping (A,B)->C)->(B,A)->C {
    return {
        return f($1,$0)
    }
}


infix operator ~>>: LogicalConjunctionPrecedence

/// Оператор применяет аргумент слева к функции с права
/// а затем возвращает аргумент таким образом что
/// ```
/// let x = ...
/// let y = x ~>> foo
/// x == y
/// ```
@discardableResult @inline(__always)
public func ~>><T> (_ x: T, _ f: (T) -> Void) -> T {
    f(x)
    return x
}


precedencegroup ApplyingLeftPrecedence {
    assignment: true
    associativity: left
    lowerThan: TernaryPrecedence
    higherThan: AssignmentPrecedence
}

infix operator |>>: ApplyingLeftPrecedence

/// Применяет аргумент `x` к функции `f`
/// Вызов `x |>> f` равносилен `f(x)`
@discardableResult @inline(__always)
public func |>><T, U>(_ x: T, _ f: (T) -> U) -> U {
    return f(x)
}

precedencegroup ApplyingRightPrecedence {
    assignment: true
    associativity: right
    lowerThan: TernaryPrecedence
    higherThan: AssignmentPrecedence
}

infix operator <<|: ApplyingRightPrecedence

/// Применяет аргумент `x` к функции `f`
/// Вызов `f <<| x` равносилен `f(x)`
@discardableResult @inline(__always)
public func <<|<T, U>(_ f: (T) -> U, _ x: T) -> U {
    return f(x)
}

precedencegroup MonadicLeftPrecedence {
    assignment: true
    associativity: left
    higherThan: LogicalConjunctionPrecedence, NilCoalescingPrecedence
}

infix operator >>-: MonadicLeftPrecedence

/// bind
/// Пытается развернуть значение в неопциональное и если оно существует (не nil)
/// применяет его к функции f
@discardableResult @inline(__always)
func >>-<T, U>(_ x: T?, _ f: (T) -> U?) -> U? {
    if let x = x {
        return f(x)
    } else {
        return nil
    }
}


infix operator <*>: MonadicLeftPrecedence

/// Аппликативный функтор
/// В случае если есть и значение x и функция f применит
/// значение к функции и вернет результат
/// Иначе - вернет nil
@discardableResult @inline(__always)
func <*><T, U>(_ x: T?, _ f: ((T) -> U?)?) -> U? {
    if let x = x {
        return f?(x)
    } else {
        return nil
    }
}
