//
//  MainController.swift
//  SafeAreaTargetContentOffset
//
//  Created by Vsevolod Mashinson on 02/10/2019.
//  Copyright © 2019 MVVM. All rights reserved.
//

import Foundation
import UIKit

class MainController : UIViewController {
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print("additionalSafeAreaInsets \(additionalSafeAreaInsets)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.green
        collectionView.contentInsetAdjustmentBehavior = .never
      
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.backgroundColor = UIColor.black
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: cellHeight)
        collectionView.dataSource = self
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("collectionView = \(collectionView.bounds)")
           print("safeAreaInsets = \(view.safeAreaInsets)")
           let topInset = collectionView.bounds.height - cellHeight - view.safeAreaInsets.bottom
           collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
           print("collectionView.contentsSize = \(collectionView.contentSize)")
           print("collectionView.(min,max) = (\(collectionView.minimumContentOffset.y), \(collectionView.maximumContentOffset.y))")
           print("collectionView.(min,max).byInsets = (\(-topInset), \(-topInset + cellHeight*3)")
    }
    
    private let layout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView
    private let cellHeight = CGFloat(88.0)
}

let reuseIdentifier = "asdf"


extension MainController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.init(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
        return cell
    }
    
}

extension MainController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset = \(scrollView.contentOffset)")
        print("scrollView.contentSize = \(scrollView.contentSize))")
    }
}


public extension UIScrollView {
    public var minimumContentOffset: CGPoint {
        return CGPoint(x: -contentInset.left, y: -contentInset.top)
    }

    public var maximumContentOffset: CGPoint {
       return self.maximumContentOffsetFor(contentSize: self.contentSize)
    }

    public func maximumContentOffsetFor(contentSize: CGSize) -> CGPoint {
        let x = -contentInset.left + max(0.0, contentInset.left + contentSize.width + contentInset.right - self.bounds.width)
        let y = -contentInset.top + max(0.0, contentInset.top + contentSize.height + contentInset.bottom - self.bounds.height)
        return CGPoint(x: x, y: y)
    }
}
