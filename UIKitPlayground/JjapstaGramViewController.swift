//
//  JjapstaGramViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/13/23.
//

import UIKit

//Data Model
class JjapstaGramModel {
    
    let id: String
    let userProfileImage: UIImage
    let uploadedImage: UIImage
    let userName: String
    let userLocation: String
    let bodyText: String
    
    init(userProfileImage: UIImage, uploadedImage: UIImage, userId: String, userLocation: String, bodyText: String) {
        self.id = UUID().uuidString
        self.userProfileImage = userProfileImage
        self.uploadedImage = uploadedImage
        self.userName = userId
        self.userLocation = userLocation
        self.bodyText = bodyText
    }
}

class JjapstagramSinglePostViewController: UIViewController {
    
    //model data
    let postData: JjapstaGramModel = JjapstaGramModel(userProfileImage: UIImage(named: "leo")!, uploadedImage: UIImage(named:"sampleImage")!, userId: "LeoDecaprio", userLocation: "Hollywood, California", bodyText: "Lorem Ipsum Dolor Sit Amet")
    
    //properties
    var profileImage: UIImageView = UIImageView()
    var userName: UITextView = UITextView()
    var userLocation: UITextView = UITextView()
    var uploadedImageView: UIImageView = UIImageView()
    var bodyText: UITextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setupView()
    }
    
    private func setupData() -> Void {
        self.profileImage.image = postData.userProfileImage
        self.userName.text = postData.userName
        self.userLocation.text = postData.userLocation
        self.uploadedImageView.image = postData.uploadedImage
        self.bodyText.text = postData.bodyText
    }
    
    private func setupView() -> Void {
        
        self.view.backgroundColor = UIColor.systemBackground
        
        //disable autolayout
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.userName.translatesAutoresizingMaskIntoConstraints = false
        self.userLocation.translatesAutoresizingMaskIntoConstraints = false
        self.uploadedImageView.translatesAutoresizingMaskIntoConstraints = false
        self.bodyText.translatesAutoresizingMaskIntoConstraints = false
        
        //add subviews
        self.view.addSubview(profileImage)
        self.view.addSubview(userName)
        self.view.addSubview(userLocation)
        self.view.addSubview(uploadedImageView)
        self.view.addSubview(bodyText)
        
        //profileImage
        self.profileImage.layer.cornerRadius = 30
        self.profileImage.clipsToBounds = true
        self.profileImage.contentMode = .scaleAspectFit
        self.profileImage.backgroundColor = UIColor.systemGray6
        
        //username text
        self.userName.font = UIFont.systemFont(ofSize: 18)
        self.userName.backgroundColor = .clear
        
        //userlocation text
        self.userLocation.font = UIFont.systemFont(ofSize: 16)
        self.userLocation.backgroundColor = .clear
        
        //uploaded image
        self.uploadedImageView.contentMode = .scaleAspectFill
        self.uploadedImageView.clipsToBounds = true
        
        //setup layout constraints
        NSLayoutConstraint.activate([
            //user profile image
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            profileImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            
            //username text
            userName.topAnchor.constraint(equalTo: profileImage.topAnchor),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            userName.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            userName.heightAnchor.constraint(equalToConstant: 30),
            
            //location text
            userLocation.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: -5),
            userLocation.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userLocation.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            userLocation.heightAnchor.constraint(equalToConstant: 30),
            
            //uploaded image
            uploadedImageView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            uploadedImageView.widthAnchor.constraint(equalTo: self.view .widthAnchor),
            uploadedImageView.heightAnchor.constraint(equalTo: self.uploadedImageView.widthAnchor)
            
        ])
    }
}

class JjapstaGramViewController: UIViewController {
    
    let scrollView: UIScrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(JjapstagramSinglePostViewController())
        self.addChild(UICollectionViewExample())
//        print(self.children)
        self.setupView()
    }
    
    private func setupView() -> Void {
        self.view.backgroundColor = UIColor.systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.children[0].view.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self.children[0].view)
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
//            scrollView.contentLayoutGuide.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, constant: 100),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.children[0].view.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.children[0].view.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.children[0].view.widthAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.widthAnchor),
        ])
    }
}

#Preview{
    JjapstaGramViewController()
}
