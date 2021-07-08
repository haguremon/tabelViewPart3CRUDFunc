//
//  ViewController.swift
//  tabelViewPart3
//
//  Created by IwasakIYuta on 2021/07/08.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
   

    @IBOutlet weak var tableView: UITableView!
    var items = [String]() //String型の空配列の準備
    var count = 1
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    @IBAction func createButton(_ sender: UIButton) {
        items.append("\(count)")
        count += 1
        tableView.reloadData()
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        if items.isEmpty {
            label.text = "セルが空ですよー"
            //tableView.reloadData()
        } else {
            count -= 1
            items.removeLast()//remove要素がないとエラーが出る
            tableView.reloadData()
        }
    }
//reloadData()でtableViewに表示することができる
    //    @IBAction func upDateButton(_ sender: UIButton) {
//        tableView.reloadData()
//    }
    
    @IBAction func allDeleteButton(_ sender: UIButton) {
        items.removeAll()
        tableView.reloadData()
    }
    
}

