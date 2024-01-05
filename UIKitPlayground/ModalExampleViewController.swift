//
//  ModalExampleViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/30/23.
//

import UIKit

class ModalExampleViewController: UIViewController {

    let callModalButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.configuration = .borderedTinted()
        btn.setTitle("Call Modal", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() -> Void {
        self.view.backgroundColor = UIColor.systemBackground
        self.view.addSubview(callModalButton)
        
        self.callModalButton.addTarget(self, action: #selector(callModal), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.callModalButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.callModalButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    @objc func callModal(_ sender: UIButton) -> Void {
        self.present(ModalViewExample(), animated: true)
    }
}

class ModalViewExample: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemMint
    }
}
