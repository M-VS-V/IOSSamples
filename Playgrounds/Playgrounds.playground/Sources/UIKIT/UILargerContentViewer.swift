import UIKit

extension UIView {
    public func enableLargeContent(title: String? = nil,
                                   image: UIImage? = nil,
                                   scales: Bool = true,
                                   insets: UIEdgeInsets = .zero) {
        guard !showsLargeContentViewer else { return }
        
        showsLargeContentViewer = true
        addInteraction(UILargeContentViewerInteraction())
        
        largeContentTitle = title
        largeContentImage = image
        scalesLargeContentImage = scales
        largeContentImageInsets = insets
    }
}

