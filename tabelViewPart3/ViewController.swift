//
//  ViewController.swift
//  tabelViewPart3
//
//  Created by IwasakIYuta on 2021/07/08.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, UITextFieldDelegate {
   

    @IBOutlet weak var tableView: UITableView!
    //var count = 1
    @IBOutlet weak var label: UILabel!
    
    
    var todos = [String]()     //String型の空配列の準備
    @IBOutlet weak var addToTodoTextField: UITextField!
    @IBAction func createButton(_ sender: UIButton) {
        //todos.append("\(count)")
        //count += 1
        UserDefaults.standard.set(todos, forKey: "todos")
        if let text = addToTodoTextField.text {
            todos.append(text)
        } else {
            print("")
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //保存してる値がある場合は
        if (UserDefaults.standard.array(forKey: "todos") != nil) {
            todos = UserDefaults.standard.array(forKey: "todos") as! [String]
        }
            tableView.dataSource = self
            tableView.delegate = self
            addToTodoTextField.delegate = self
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }
    //keybordのReturnが押された時に値を配列に追加してセルに表示する
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()//キーボードを閉じて
        todos.append(addToTodoTextField.text!)//addToTodoTextField.textの値を入れる
        tableView.reloadData()//セルに表示して
        addToTodoTextField.text! = ""//addToTodoTextFieldの値を空にして閉じると
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //
   
    @IBAction func deleteButton(_ sender: UIButton) {
        if todos.isEmpty {
            label.text = "セルが空ですよー"
            //tableView.reloadData()
        } else {
            //count -= 1
            todos.removeLast()//remove要素がないとエラーが出る
            //items.remove(at: tableView.indexPath(for: <#T##UITableViewCell#>))
            tableView.reloadData()
        }
    }
//reloadData()でtableViewに表示することができる
    //    @IBAction func upDateButton(_ sender: UIButton) {
//        tableView.reloadData()
//    }
    
    @IBAction func allDeleteButton(_ sender: UIButton) {
        todos.removeAll()
        tableView.reloadData()
    }
    
}

