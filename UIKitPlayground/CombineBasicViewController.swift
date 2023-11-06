//
//  CombineBasicViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 10/4/23.
//

import UIKit
import Combine

class CombineBasicViewModel {
    @Published var count: Int = 0
    @Published var count2: Int = 100
    
    func increaseValue() -> Void {
        count += 1
        count2 += 10
    }
}

class CombineBasicViewController: UIViewController {
    
    let vm: CombineBasicViewModel = CombineBasicViewModel()
    let button: UIButton = {
        let button: UIButton = UIButton(type:.system)
        button.configuration = .filled()
        button.configuration?.title = "Increase Count"
        return button
    }()
    let label: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    let label2: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    var cancellable: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupSubViews()
        button.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
    }
    
    func setupSubViews() {
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(label2)
        
        NSLayoutConstraint.activate([
            //label
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 20),
            //label2
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label2.heightAnchor.constraint(equalToConstant: 20),
            label2.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            //button
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
        ])
    }
    
    func bind() -> Void {
        //binding 1
        vm.$count.sink { value in
            self.label.text = "\(value)"
        }.store(in: &cancellable)
        
        //binding 2
        vm.$count2.sink { value in
            self.label2.text = "\(value)"
        }.store(in: &cancellable)
    }
    
    @objc func increaseCount() -> Void {
        vm.increaseValue()
    }
}

#Preview {
    CombineBasicViewController()
}
