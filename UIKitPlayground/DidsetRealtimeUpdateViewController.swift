//
//  ViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 2023/08/29.
//

//Didset으로 뷰 업데이트하기 예제

import UIKit
import Combine

class DidsetRealtimeUpdateViewModel {
    var number: Int = 0
    func increase() {
        self.number += 1
    }
}

class DidsetRealtimeUpdateViewController: UIViewController {
    let vm: DidsetRealtimeUpdateViewModel = DidsetRealtimeUpdateViewModel()
    let uiLabel: UILabel = UILabel()
    var counting: Int = 0 {
        didSet {
            uiLabel.text = "\(counting)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiLabel.text = "\(counting)"

        let button: UIButton = UIButton()
        
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Tap", for: .normal)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        view.addSubview(button)
        view.addSubview(uiLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: uiLabel.bottomAnchor, constant: 50),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 50),
            uiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func tapAction() -> Void {
        vm.increase()
        counting = vm.number
    }
}

#Preview{
    DidsetRealtimeUpdateViewController()
}
