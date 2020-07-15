//
//  OnboardingView.swift
//  TutorialScroll
//
//  Created by 김성민 on 2020/07/15.
//  Copyright © 2020 min. All rights reserved.
//

import UIKit

class OnboardingView: UIView {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    func setData(title: String?, subTitle: String?) {
        labelTitle.text = title
        labelSubTitle.text = subTitle
    }

}
