//
//  ClassExampleViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/9/23.
//

import UIKit

class ClassExampleViewController: UIViewController, UITextFieldDelegate {
    
    let textFieldLabel: UILabel = {
        let tfLabel: UILabel = UILabel()
        tfLabel.text = "Name"
        tfLabel.translatesAutoresizingMaskIntoConstraints = false
        return tfLabel
    }()
    
    let textField: UITextField = {
        let tf: UITextField = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Give your name here..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let textButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("Button", for: .normal)
        btn.configuration = .borderedProminent()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let sendButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("send", for: .normal)
        btn.configuration = .borderless()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.systemBackground
        self.view.addSubview(textField)
        self.view.addSubview(textButton)
        self.view.addSubview(sendButton)
        self.view.addSubview(textFieldLabel)
        
        NSLayoutConstraint.activate([
            textFieldLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            textFieldLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            
            textButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
    }
}

class ClassExampleScrollView: UIViewController {
    
    let topView: ClassExampleViewController = ClassExampleViewController()
    let topView2: ClassExampleViewController = ClassExampleViewController()
    
    let scrollView: UIScrollView = {
        let sv: UIScrollView = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let dummyView: UIView = {
        let dummy: UIView = UIView()
        dummy.backgroundColor = UIColor.systemGray6
        dummy.translatesAutoresizingMaskIntoConstraints = false
        return dummy
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(topView)
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.systemBackground
        self.topView.view.translatesAutoresizingMaskIntoConstraints = false
        self.topView2.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(topView.view)
        self.scrollView.addSubview(topView2.view)
        self.scrollView.addSubview(dummyView)
        
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: 100),
            
            topView.view.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            topView.view.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20),
            topView.view.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20),
            topView.view.heightAnchor.constraint(equalToConstant: 150),
            
            topView2.view.topAnchor.constraint(equalTo: topView.view.bottomAnchor),
            topView2.view.heightAnchor.constraint(equalToConstant: 150),
            topView2.view.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20),
            topView2.view.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20)
        ])
    }
}

#Preview {
    ClassExampleScrollView()
}
