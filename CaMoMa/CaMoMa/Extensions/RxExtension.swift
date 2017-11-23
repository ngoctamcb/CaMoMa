//
//  RxExtension.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/23/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - Custom operators



precedencegroup DisposablePrecedence {
    lowerThan: DefaultPrecedence
}

// MARK: - Two way binding shorthand
infix operator <~> : DefaultPrecedence
func <~><T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let bindToUIDisposable = variable.asObservable().bind(to: property)
    let bindToVariable = property
        .subscribe(
            onNext: { value in variable.value = value },
            onCompleted: { bindToUIDisposable.dispose() }
    )
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}
func <~><T>(variable: Variable<T>, property: ControlProperty<T>) -> Disposable {
    let bindToUIDisposable = variable.asObservable().bind(to: property)
    let bindToVariable = property.bind(to: variable)
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}

// MARK: - One way binding shorthand
infix operator ~>: DefaultPrecedence
func ~><T>(source: Observable<T>, observer: AnyObserver<T>) -> Disposable {
    return source.bind(to: observer)
}
func ~><T, E>(source: Observable<T>, observer: UIBindingObserver<E, T>) -> Disposable {
    return source.bind(to: observer.asObserver())
}
func ~><T>(variable: Variable<T>, observer: AnyObserver<T>) -> Disposable {
    return variable.asObservable().bind(to: observer)
}
func ~><T, E>(variable: Variable<T>, observer: UIBindingObserver<E, T>) -> Disposable {
    return variable.asObservable().bind(to: observer.asObserver())
}
func ~><T>(source: Observable<T>, variable: Variable<T>) -> Disposable {
    return source.bind(to: variable)
}
func ~><T>(source: Observable<T>, variable: Variable<T?>) -> Disposable {
    return source.bind(to: variable)
}
func ~><T, R>(source: Observable<T>, binder: (Observable<T>) -> R) -> R {
    return source.bind(to: binder)
}
func ~><T>(source: Observable<T>, binder: ControlProperty<T>) -> Disposable {
    return source.subscribe(onNext: { binder.onNext($0) })
}
func ~><T>(event: ControlEvent<T>, variable: Variable<T>) -> Disposable {
    return event.bind(to: variable)
}

// MARK: - Add to dispose bag shorthand
infix operator =>: DisposablePrecedence

func =>(disposable: Disposable?, bag: DisposeBag) {
    disposable?.addDisposableTo(bag)
}

