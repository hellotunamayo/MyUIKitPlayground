//
//  CombineSecondaryViewController.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 10/2/23.
//

import UIKit
import Combine

struct SecondaryPostModel: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class CombineSecondaryViewModel {
//    @Published var postData: SecondaryPostModel = SecondaryPostModel(userId: 0, id: 0, title: "title here", body: "body here")

    func fetchPostData(postId: Int) -> AnyPublisher<SecondaryPostModel, Error>? {
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(postId)"
        if let url: URL = URL(string: urlString) {
            return URLSession
                .shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: SecondaryPostModel.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } else {
            return nil
        }
    }
}

class CombineSecondaryViewController: UIViewController {
    let vm: CombineSecondaryViewModel = CombineSecondaryViewModel()
    let titleLabel: UILabel = UILabel()
    let bodyLabel: UILabel = UILabel()
    let fetchButton: UIButton = UIButton(type: .system)
    let textField: UITextField = UITextField()
    var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        //binding
        bind()
        
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
    
    func bind(){
        vm.fetchPostData(postId: 1).flatMap(<#T##transform: (AnyPublisher<SecondaryPostModel, Error>) throws -> U?##(AnyPublisher<SecondaryPostModel, Error>) throws -> U?#>)
    }
    
    @objc func increaseCount() -> Void {
        guard let postIdValue = Int(textField.text ?? "0") else { return }
        vm.fetchPostData(postId: postIdValue) { data in
            print(data)
            self.vm.postData = data
        }
    }
}

#Preview {
    CombineSecondaryViewController()
}
