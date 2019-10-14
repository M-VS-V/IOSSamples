import Foundation

public typealias Action = () -> ()
public typealias Action1<T> = (T) -> ()
public typealias Action2<T1,T2> = (T1,T2) -> ()

public typealias Func<T> = () -> T
public typealias Func1<T1,T> = (T1) -> T
