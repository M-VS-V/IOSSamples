import Foundation

public enum Environment {
    public static var swiftVersion: String {
        #if swift(>=6.0)
            return "Hello, Swift 6.x"
        #elseif swift(>=5.0)
            return "Hello, Swift 5.x"
        #elseif swift(>=4.1)
            return"Hello, Swift 4.1.x"
        #elseif swift(>=4.0)
            return"Hello, Swift 4.x"
        #elseif swift(>=3.0)
            return"Hello, Swift 3.x"
        #else
            return"Hello, Swift 2.2"
        #endif
    }
}

