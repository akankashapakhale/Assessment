//
//  DetailViewController.swift
//  Assessment
//
//  Created by Akanksha pakhale on 25/08/21.
//

import UIKit

class DetailViewController: UIViewController {
    var players:[[String:Any]]?
   
    @IBOutlet weak var tableView: UITableView!
    @IBAction func sortByLastNameAction(_ sender: Any) {

        var items = players
        items = items!.sorted(by: { (item1, item2) -> Bool in
            return getLasstName(name: (item1["name"] as! String))!.compare(getLasstName(name: (item2["name"] as! String))!) == ComparisonResult.orderedAscending
            })
        self.players = items
        tableView.reloadData()
    }
    func getLasstName(name:String?)->String?{
        if let fullName = name{
            let nameParts = fullName.components(separatedBy: " ")
           if nameParts.count > 0{
            let lName = nameParts.last
              return lName
           }
           
        }

        return nil
    }
    @IBAction func sortByName(_ sender: Any) {
        var items = players

        items = items!.sorted(by: { (item1, item2) -> Bool in
                return (item1["name"] as! String).compare(item2["name"] as! String) == ComparisonResult.orderedAscending
            })
self.players = items
    
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
      
        
    }
    

}
extension DetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        let data = players?[indexPath.row]
        cell.textLabel?.text = data!["name"] as? String
               if data!["captain"] as! Bool{
                   cell.textLabel?.textColor = .orange

               }else{
                   cell.textLabel?.textColor = .darkText
               }
        return cell
    }
    
    
}

