//
//  ViewController.swift
//  API123
//
//  Created by Govind Sen on 15/07/24.
//

import UIKit

//struct Products: Codable {
//    let id: Int
//    let title: String
//    let price: Double
//    let description: String
//    let category: String
//    let image: String
//    let rating: Rate
//}
//
//struct Rate: Codable {
//    let rate: Double
//    let count: Int
//}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Products] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        setupTableview()
        
    }
    
    func apiCall() {
        let url = URL(string: "https://fakestoreapi.com/products")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print("Error")
                return
            }
            guard let data = data else { return }
            
            do {
                let products = try JSONDecoder().decode([Products].self, from: data)
                print("Posts: ", products)
                
                DispatchQueue.main.async {
                    self.products = products
                    self.tableView.reloadData() // Reload table view data
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "productCell", bundle: nil), forCellReuseIdentifier: "productCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? productCell else { return UITableViewCell() }
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
//        cell.image1.image = UIImage(named: image)
        // Download and set the image
               if let imageURL = URL(string: product.image) {
                   let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                       if let data = data, let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                               cell.image1.image = image
                           }
                       } else {
                           print("Failed to load image")
                       }
                   }
                   task.resume()
               } else {
                   print("Invalid image URL")
               }
        
        return cell
    }
}

