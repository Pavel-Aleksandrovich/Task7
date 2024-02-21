//
//  ViewController.swift
//  Task7
//
//  Created by pavel mishanin on 21/2/24.
//

import UIKit

final class ViewController: UIViewController {

    private let headerImageView = UIImageView(image: UIImage(named: "im"))
    private let vScrollView = UIScrollView()
    
    private var imageHeightConstraint = NSLayoutConstraint()
    private var imageTopConstraint = NSLayoutConstraint()
    
    private let imageHeight: CGFloat = 270
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(vScrollView)
        vScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            vScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        vScrollView.delegate = self
        
        let contentHeight: CGFloat = UIScreen.main.bounds.height + imageHeight
        
        let contentView = UIView()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        vScrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: contentHeight),
            contentView.topAnchor.constraint(equalTo: vScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: vScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        contentView.addSubview(headerImageView)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        imageTopConstraint = headerImageView.topAnchor.constraint(equalTo: view.topAnchor)
        imageTopConstraint.isActive = true
        
        imageHeightConstraint = headerImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        imageHeightConstraint.isActive = true
        
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let newImageHeight = imageHeight - scrollView.contentOffset.y - view.safeAreaInsets.top
        imageHeightConstraint.constant = max(270, newImageHeight)
        

        let topPadding = -scrollView.contentOffset.y - view.safeAreaInsets.top
        imageTopConstraint.constant = min(topPadding, 0)
        
        let topInset = max(newImageHeight, imageHeight) - view.safeAreaInsets.top
        vScrollView.verticalScrollIndicatorInsets = .init(top: topInset, left: 0, bottom: 0, right: 0)
    }
}

