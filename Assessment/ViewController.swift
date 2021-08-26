//
//  ViewController.swift
//  Assessment
//
//  Created by Akanksha pakhale on 24/08/21.
//

import UIKit

class ViewController: UIViewController {
  
    
    var playersData:[String:[[String:Any]]]?
    var countries:[String]=[String]()
    @IBOutlet weak var tablev: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        httpRequest()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tablev.dataSource = self
        tablev.delegate = self
    }
    private func httpRequest() {

        //create the url with NSURL
        let url = URL(string: "http://test.oye.direct/players.json")!

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {

                    self.playersData = (json as! [String:[[String:Any]]])
                    self.countries = Array(json.keys)
                    DispatchQueue.main.async {
                        self.tablev.reloadData()
                    }

                }
            } catch let error {
                print(error.localizedDescription)
            }

        })
        task.resume()
    }

}

     
     

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.countries[indexPath.row]
        return cell
    }
    
    
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let k = self.countries[indexPath.row]
        newViewController.players = self.playersData![k]
       
                self.present(newViewController, animated: true, completion: nil)
    }
}
