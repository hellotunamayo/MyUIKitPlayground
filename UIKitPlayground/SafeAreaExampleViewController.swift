//
//  SafeAreaExampleViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/3/23.
//

import UIKit
import Combine

class SafeAreaExampleViewController: UIViewController, UITextFieldDelegate {

    let exampleButton: UIButton = {
        let eb: UIButton = UIButton()
        eb.setTitle("UIExample Button", for: .normal)
        eb.setTitleColor(UIColor.white, for: .normal)
        eb.configuration = .borderedProminent()
        eb.translatesAutoresizingMaskIntoConstraints = false
        return eb
    }()
    
    let exampleTextField: UITextField = {
        let etf: UITextField = UITextField()
        etf.borderStyle = .roundedRect
        etf.placeholder = "UITextfield"
        etf.translatesAutoresizingMaskIntoConstraints = false
        return etf
    }()
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    //Setup View
    func setupView() -> Void {
        exampleTextField.delegate = self
        exampleButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        
        self.view.backgroundColor = UIColor.systemBackground
        self.view.addSubviews([exampleButton, exampleTextField])
        
        NSLayoutConstraint.activate([
            //example button constraints
            self.exampleButton.widthAnchor.constraint(equalToConstant: 300),
            self.exampleButton.heightAnchor.constraint(equalToConstant: 40),
            self.exampleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            //MARK: KeyboardLayoutGuide와 버튼 앵커포인트 싱크
            self.exampleButton.bottomAnchor.constraint(equalTo: self.view.keyboardLayoutGuide.topAnchor, constant: -10),
            
            //example textfield button constraints
            self.exampleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.exampleTextField.bottomAnchor.constraint(equalTo: exampleButton.topAnchor, constant: -150),
            self.exampleTextField.heightAnchor.constraint(equalToConstant: 40),
            self.exampleTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40)
        ])
    }
    
    @objc func dismissKeyboard() -> Void {
        self.view.endEditing(true)
    }
}

extension UIView {
    func addSubviews(_ uiViews: [UIView]) -> Void {
        uiViews.forEach { view in
            addSubview(view)
        }
    }
}

#Preview{
    SafeAreaExampleViewController()
}
