//
//  DelegateExampleViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/6/23.
//

import UIKit

//Protocol(Delegate)
protocol DeleateExampleDelegate {
    func didSelectedItem(label: String)
}

//Sheet View
class DelegateExampleViewSheetViewController: UIViewController {
    
    var delegate: DeleateExampleDelegate?
    
    let changeLabelTextButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.configuration = .borderedProminent()
        btn.setTitle("change text", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() -> Void {
        self.view.addSubview(changeLabelTextButton)
        self.view.backgroundColor = UIColor.systemBackground
        changeLabelTextButton.addTarget(self, action: #selector(changeText), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            changeLabelTextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            changeLabelTextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            changeLabelTextButton.widthAnchor.constraint(equalToConstant: 150),
            changeLabelTextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func changeText() -> Void {
        delegate?.didSelectedItem(label: "text changed!")
    }
}

//Main View
class DelegateExampleViewController: UIViewController, DeleateExampleDelegate {
        
    var sheetView: DelegateExampleViewSheetViewController = DelegateExampleViewSheetViewController()
    
    let callModalButton: UIButton = {
        let cmb: UIButton = UIButton()
        cmb.setTitle("Call Modal", for: .normal)
        cmb.configuration = .borderedProminent()
        cmb.translatesAutoresizingMaskIntoConstraints = false
        return cmb
    }()
    
    let resultLabel: UILabel = {
        let rl: UILabel = UILabel()
        rl.text = "not yet changed"
        rl.translatesAutoresizingMaskIntoConstraints = false
        return rl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        setupView()
    }
    
    func setupView() -> Void {
        let uiViews: [UIView] = [callModalButton, resultLabel]
        uiViews.forEach { view in
            self.view.addSubview(view)
        }
        self.view.backgroundColor = UIColor.systemBackground
        callModalButton.addTarget(self, action: #selector(callModal), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callModalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            callModalButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50),
            callModalButton.widthAnchor.constraint(equalToConstant: 150),
            callModalButton.heightAnchor.constraint(equalToConstant: 40),
            resultLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    func didSelectedItem(label: String) {
        self.resultLabel.text = label
//        dismiss(animated: true)
    }
    
    @objc func callModal() -> Void {
        sheetView.modalPresentationStyle = .pageSheet
        sheetView.sheetPresentationController?.detents = [.medium()]
        self.present(sheetView, animated: true)
    }
}
