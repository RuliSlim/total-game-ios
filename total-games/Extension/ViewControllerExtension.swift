//
//  ViewControllerExtension.swift
//  total-games
//
//  Created by Ruli on 12/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentNext(_ viewControllerTarget: UIViewController) {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromRight
        transition.duration = 0.5
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerTarget, animated: false, completion: nil)
    }
    
    func presentSecondary(_ viewControllertarget: UIViewController) {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromLeft
        transition.duration = 0.5
        
        guard let currentPresentedVC = presentedViewController else { return }
        
        currentPresentedVC.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllertarget, animated: false, completion: nil)
        }
    }
    
    func goBack() {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromLeft
        transition.duration = 0.5
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
