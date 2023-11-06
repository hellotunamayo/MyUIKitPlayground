//
//  SheetFullscreenNavigationViewViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 2023/09/22.
//

import UIKit

class SheetFullscreenNavigationViewViewController: UINavigationController, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {

    var navButton: UIButton?
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set navButton
        navButton = UIButton()
        navButton?.setTitle("모달나와라얍", for: .normal)
        navButton?.translatesAutoresizingMaskIntoConstraints = false
        navButton?.setTitleColor(UIColor.systemBlue, for: .normal)
        navButton?.addTarget(self, action: #selector(callModal), for: .touchUpInside)
        
        view.addSubview(navButton!)
        
        NSLayoutConstraint.activate([
            navButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            navButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func callModal(){
        let vc = ModalViewController(passedString: "Hello World")
        self.present(vc, animated: true)
    }
}

class ModalViewController: UINavigationController, UINavigationControllerDelegate {
    
    var passedString: String?
    
    init(passedString: String) {
        super.init(nibName: nil, bundle: nil)
        self.passedString = passedString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        guard let passedString = self.passedString else { return }
        print(passedString)
        
        let myButton: UIButton = UIButton()
        
        view.backgroundColor = UIColor.white
        
        myButton.setTitle("다음뷰로 드가자", for: .normal)
        myButton.setTitleColor(UIColor.systemBlue, for: .normal)
        myButton.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        myButton.frame = view.frame
        myButton.translatesAutoresizingMaskIntoConstraints = true
        
        view.addSubview(myButton)
        
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myButton.widthAnchor.constraint(equalToConstant: 100),
            myButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushView() {
        self.dismiss(animated: true)
    }
}

class ModalTargetViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemCyan
    }
}

#Preview{
    SheetFullscreenNavigationViewViewController()
}
