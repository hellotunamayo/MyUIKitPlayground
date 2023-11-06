//
//  CombineViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 2023/09/22.
//

import UIKit
import Combine

class CombineViewModel {
    @Published var myInteger: Int = 0
    
    func increaseInteger() -> Void {
        self.myInteger += 1
    }
}

class CombineViewController: UIViewController {
    
    let vm: CombineViewModel = CombineViewModel()
    var cancellables: Set<AnyCancellable> = []
    let myLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        let myButton: UIButton = UIButton()
        
        //setup Button
        myButton.setTitle("increase", for: .normal)
        myButton.setTitleColor(UIColor.systemBlue, for: .normal)
        myButton.addTarget(self, action: #selector(increaseNumber), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        //setup Label
        myLabel.text = "not yet binded"
        myLabel.textColor = UIColor.black
        myLabel.font = UIFont.systemFont(ofSize: 40)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myButton)
        view.addSubview(myLabel)
        
        NSLayoutConstraint.activate([
            //button
            myButton.widthAnchor.constraint(equalToConstant: 100),
            myButton.heightAnchor.constraint(equalToConstant: 50),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //label
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.bottomAnchor.constraint(equalTo: myButton.topAnchor, constant: -10)
        ])
    }
    
    func bind() {
        vm.$myInteger.sink { [weak self] integer in
            self?.myLabel.text = "\(integer)"
        }.store(in: &cancellables)
    }
    
    @objc func increaseNumber() {
        vm.increaseInteger()
    }
}

#Preview{
    CombineViewController()
}
