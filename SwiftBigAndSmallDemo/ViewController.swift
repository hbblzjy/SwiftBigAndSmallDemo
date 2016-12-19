//
//  ViewController.swift
//  SwiftBigAndSmallDemo
//
//  Created by healthmanage on 16/12/16.
//  Copyright © 2016年 healthmanager. All rights reserved.
//双指扩大和缩小图片

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    var imageVi:UIImageView! = nil
    var myScrollV:UIScrollView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageVi = UIImageView.init(image: UIImage.init(named: "liwu.jpg"))
        setUpScrollView()
        myScrollV.delegate = self
        setZoomScaleFor(srollViewSize: myScrollV.bounds.size)
        myScrollV.zoomScale = myScrollV.minimumZoomScale
        recenterImage()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setZoomScaleFor(srollViewSize: myScrollV.bounds.size)
        
        if myScrollV.zoomScale < myScrollV.minimumZoomScale {
            myScrollV.zoomScale = myScrollV.minimumZoomScale
        }
        
        recenterImage()
    }
    private func recenterImage() {
        
        let scrollViewSize = myScrollV.bounds.size
        let imageViewSize = imageVi.frame.size
        let horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.width) / 2.0 :0
        
        myScrollV.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace)
        
    }
    private func setZoomScaleFor(srollViewSize: CGSize) {
        
        let imageSize = imageVi.bounds.size
        let widthScale = srollViewSize.width / imageSize.width
        let heightScale = srollViewSize.height / imageSize.height
        let minimunScale = min(widthScale, heightScale)
        
        myScrollV.minimumZoomScale = minimunScale
        myScrollV.maximumZoomScale = 3.0
        
    }
    private func setUpScrollView() {
        
        myScrollV = UIScrollView(frame: view.bounds)
        myScrollV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myScrollV.backgroundColor = UIColor.clear
        myScrollV.contentSize = imageVi.bounds.size
        myScrollV.addSubview(imageVi)
        self.view.addSubview(myScrollV)
        
    }
    //MARK:---------UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageVi
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.recenterImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

