//
//  ViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 2023/09/22.
//

import UIKit
import Combine

struct PostModel: Codable{
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

final class ViewControllerViewModel {
    @Published var postData: PostModel?
    
    init(){
        fetchPostData(postId: 1)
    }

    func fetchPostData(postId: Int) -> Void {
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(postId)"
        guard let url: URL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            let decoder = JSONDecoder()
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let jsonData = try? decoder.decode(PostModel.self, from: data) else { return }
            
            self.postData = jsonData
            
        }).resume()
    }
}

class CombineUpdateViewViewController: UIViewController {
    let vm: ViewControllerViewModel = ViewControllerViewModel()
    let titleLabel: UILabel = UILabel()
    let bodyLabel: UILabel = UILabel()
    let fetchButton: UIButton = UIButton(type: .system)
    let textField: UITextField = UITextField()
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        bind()
        setupView()
    }
    
    func setupView() {
        fetchButton.configuration = .filled()
        fetchButton.configuration?.title = "Change Data"
        fetchButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
        
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(fetchButton)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bodyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20)
        ])
    }
    
    func bind() {
        vm.$postData.sink { [weak self] postdata in
            DispatchQueue.main.async {
                self?.titleLabel.text = postdata?.title
                self?.bodyLabel.text = postdata?.body
            }
        }.store(in: &cancellable)
    }
    
    @objc func increaseCount() -> Void {
        guard let postIdValue = Int(textField.text ?? "0") else { return }
        vm.fetchPostData(postId: postIdValue)
    }
}

#Preview{
    CombineUpdateViewViewController()
}
