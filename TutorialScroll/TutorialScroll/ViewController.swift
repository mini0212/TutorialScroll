//
//  ViewController.swift
//  TutorialScroll
//
//  Created by 김성민 on 2020/07/15.
//  Copyright © 2020 min. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
     IBOutlet으로 scrollView를 선언하게되면
     오토에리아웃이 제약을 잡고있어서
     프레임으로 변경을 하더라고 view의 변경사항을 체크해서 오토레아이웃이 그려진 형태로 동작
     */
    let scrollView: UIScrollView = UIScrollView()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var buttonStart: UIButton!
    private var pageNum: Int = 0
    let titleList: [String] = [
        "펄펄 눈이옵니다",
        "하늘에서 눈이옵니다",
        "하늘나라 선녀님들이",
        "고이고이 하얀눈을",
        "자꾸자꾸 뿌려줍니다"
    ]
    
    var onboardingViews: [OnboardingView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUpSlide(slides: createSlides())
        
    }
    
    private func setScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    
    private func createSlides() -> [OnboardingView] {
        var onboardingViews: [OnboardingView] = []
        
        titleList.forEach {
            guard let onboardingView: OnboardingView = Bundle.main.loadNibNamed("OnboardingView", owner: self, options: nil)?
                .first as? OnboardingView else { return }
            onboardingView.setData(title: $0, subTitle: "서브지롱")
            onboardingViews.append(onboardingView)
        }
        return onboardingViews
    }
    
    private func setUpSlide(slides: [OnboardingView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        
        slides
            .enumerated()
            .forEach { (index, element) in
                let xPostion = view.frame.width * CGFloat(index)
                element.frame = CGRect(x: xPostion, y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(element)
        }
        view.addSubview(scrollView)
        setPageControl()
    }
    
    private func setPageControl() {
        view.bringSubviewToFront(pageControl)
        view.bringSubviewToFront(buttonStart)
        pageControl.numberOfPages = titleList.count
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        updatePage(with: Int(currentPage))
    }
    
    private func updatePage(with page: Int) {
        pageControl.currentPage = page
        if page == titleList.count - 1 {
            buttonStart.isHidden = false
            pageControl.isHidden = true
        } else {
            buttonStart.isHidden = true
            pageControl.isHidden = false
        }
    }
}
