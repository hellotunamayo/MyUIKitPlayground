//
//  TypographySpecViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/29/23.
//

import UIKit

class TypographySpecViewController: UIViewController {

    let myText: String = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dignissim feugiat justo eget eleifend. Aliquam id dolor erat. Proin a justo ornare, dignissim mauris eget, mattis tortor. Aliquam erat volutpat. In a elit tincidunt, aliquam urna ac, bibendum libero. Phasellus sagittis, eros eu efficitur mattis, leo nibh gravida nunc, et malesuada purus justo non odio. Aenean quis felis ac velit laoreet blandit. Ut dapibus erat sit amet augue auctor, sed placerat ipsum ornare. Pellentesque non laoreet tellus. Suspendisse molestie nisl nulla, eget facilisis nisl eleifend id. Vestibulum vestibulum elit lobortis rhoncus fermentum. Nam semper sapien quis ultrices vulputate.
"""
    let textView: UITextView = UITextView()
    let checkButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() -> Void {
        //font size
        let fontSize: CGFloat = 24.0
        
        //paragraph style settings
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.paragraphStyle : paragraphStyle]
        let attributedString: NSAttributedString = NSAttributedString(string: self.myText, attributes: attributes)
        
        //VC view settings
        self.view.backgroundColor = UIColor.systemBackground
        self.view.addSubview(textView)
        self.view.addSubview(checkButton)
        
        //textview settings
        self.textView.attributedText = attributedString
        self.textView.font = UIFont.systemFont(ofSize: fontSize)
        self.textView.isEditable = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        
        //checkbutton settings
        self.checkButton.configuration = .borderedTinted()
        self.checkButton.setTitle("Check Paragraph Property", for: .normal)
        self.checkButton.addTarget(self, action: #selector(checkAttribute), for: .touchUpInside)
        self.checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.textView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.textView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.textView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -40),
            self.textView.heightAnchor.constraint(equalToConstant: 300),
            self.checkButton.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 30),
            self.checkButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc func checkAttribute(_ sender: UIButton) -> Void {
        guard let font = self.textView.font else { return }
        print("\(font.descender)")
    }
}
