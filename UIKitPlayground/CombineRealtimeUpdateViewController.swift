//
//  ViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 2023/08/29.
//

//Combine 으로 업데이트하는 예제

import UIKit
import Combine

class CombineRealtimeUpdateViewModel: ObservableObject {
    @Published var name: String = "John Doe"
    @Published var secondName: String = "Hong Gildong"
    
    func changeFirstName(name: String){
        self.name = name
    }
    
    func changeSecondName(name: String){
        self.secondName = name
    }
}

class CombineRealtimeUpdateViewController: UIViewController {
    let vm: CombineRealtimeUpdateViewModel = CombineRealtimeUpdateViewModel()
    let uiLabel: UILabel = UILabel()
    let secondUILabel: UILabel = UILabel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.backgroundColor = UIColor.systemBackground
        
        vm.$name.sink { [weak self] value in
            self?.uiLabel.text = value
        }.store(in: &cancellables)
        
        vm.$secondName.sink { [weak self] value in
            self?.secondUILabel.text = value
        }.store(in: &cancellables)
        
        let button: UIButton = UIButton()
        
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Tap to change name", for: .normal)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        view.addSubview(button)
        view.addSubview(uiLabel)
        view.addSubview(secondUILabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        secondUILabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: secondUILabel.bottomAnchor, constant: 10),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 50),
            uiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondUILabel.centerXAnchor.constraint(equalTo: uiLabel.centerXAnchor),
            secondUILabel.topAnchor.constraint(equalTo: uiLabel.bottomAnchor, constant: 10)
        ])
    }

    @objc func tapAction() -> Void {
        vm.changeFirstName(name: "Mary Jane")
        vm.changeSecondName(name: "Go Gildong")
    }
}

#Preview {
    CombineRealtimeUpdateViewController()
}
