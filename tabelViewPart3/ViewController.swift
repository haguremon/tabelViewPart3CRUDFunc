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
    
    @IBOutlet weak var button: UIButton!
    
    var todos = [String]()     //String型の空配列の準備
    @IBOutlet weak var addToTodoTextField: UITextField!
    @IBAction func createButton(_ sender: UIButton) {
        //todos.append("\(count)")
        //count += 1
        UserDefaults.standard.set(todos, forKey: "todos")
        //
        if let text1 = addToTodoTextField.text {
            if text1.count > 0 {
                todos.append(text1)
            } else {
                return
            }
        }
        tableView.reloadData()
//            if text.isEmpty && todos.isEmpty {//もっと簡潔にできそう泣く
//                //button.isEnabled = false
//                //todos.append(text)
//            } else if text.isEmpty {
//                button.isEnabled = false
//            } else {
//                todos.append(text)
//            }
    
            
        
    }
    //tachTextFieldの入力次第でbuttonが押せるかどうかに実装する7/9
    @IBAction func tachTextField(_ sender: UITextField) {
        button.isEnabled = true
//        if addToTodoTextField.text?.count == 0 {
//            button.isEnabled = false
//        } else {
//            button.isEnabled = true
//        }
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
        self.button.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }
    //keybordのReturnが押された時に値を配列に追加してセルに表示すると
    //ここを押しても保存するようにする
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()//キーボードを閉じて
        if addToTodoTextField.text!.count > 0 {
        todos.append(addToTodoTextField.text!)//addToTodoTextField.textの値を入れる
        }
            tableView.reloadData()//セルに表示して
        addToTodoTextField.text! = ""//addToTodoTextFieldの値を空にして閉じると
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //ここから下は削除機能
    //この二つでスライドしてセルを削除する機能を作ることができる
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete { //editingStyleが指定されてない時があるのでif分を使う
            tableView.beginUpdates()
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)//deleteRowsを決めてdeleteするアニメションを.fadeに指定
            tableView.endUpdates()
        }
    }
    
   
    
    //一番下のセルを削除
    @IBAction func deleteButton(_ sender: UIButton) {
//        guard todos.isEmpty else {
//            todos.removeLast()
//            return
//        }
//        tableView.reloadData()
                if todos.isEmpty {
            //label.text = "セルが空ですよー"
            //tableView.reloadData()
        } else {
            //count -= 1
            todos.removeLast()//remove要素がないとエラーが出る
            //todos.remove(at: tableView.indexPath(for: <#T##UITableViewCell#>))
            tableView.reloadData()
        }
    }
//reloadData()でtableViewに表示することができる
    //    @IBAction func upDateButton(_ sender: UIButton) {
//        tableView.reloadData()
//    }
   
    
    //全消去にメッセージを流す  dialogを促す機能を実装7/9/13:00
    @IBAction func allDeleteButton(_ sender: UIButton) {
        let dialog = UIAlertController(title: "全消去", message: "全てのセルを消去しますか？", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        dialog.addAction(cancel)
        let ok = UIAlertAction(title: "OK", style: .default) { (alert) in
            
            self.todos.removeAll()
            UserDefaults.standard.removeObject(forKey: "todos")//セルに保存されてる値を全て削除
            self.tableView.reloadData()
        }
        dialog.addAction(ok)
        present(dialog, animated: true)
    }
    
    @IBAction func displayAnyCellDate(_ sender: UIButton) {
      
    //todosの中身がからのときにエラーが出るからこれを押したとこいにから文字が入ってるもっといい方法があるはずだけど
        if todos.count > 6{
            let f = DateFormatter()
            f.setTemplate(.full)
            let now = Date()
            todos[5] = f.string(from: now)
            let indexPaths = [IndexPath(row: 5, section: 0)]//ここでindexPathを指定
            let animations: [UITableView.RowAnimation] = [.automatic,.bottom,.fade,.left,.middle,.none,.right,.top]
        
            let animation = animations.randomElement()
            tableView.reloadRows(at: indexPaths, with: animation!)
            
        }else {
            tableView.reloadData()
            
        }
        
        
      
    }

    //accessoryButtonがTapされたら遷移させるー
    //この二つじゃないといけないらしい.detailButton .detailDisclosureButton
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //performSegue(withIdentifier: "toSegue", sender: self)//これで遷移できないから下で
        let view2 = self.storyboard?.instantiateViewController(identifier: "view2") as! View2Controller
        self.present(view2, animated: true)
            
        
    }
    @IBAction func exit(seuge: UIStoryboardSegue){}
    
}
extension DateFormatter {
    enum Template: String {
        case date = "yMd"     // 2021/1/1
        case time = "Hms"     // 12:39:22
        case full = "yMdkHms" // 2021/1/1 12:39:22
        case onlyHour = "k"   // 17時
        case era = "GG"       // "西暦" (default) or "平成" (本体設定で和暦を指定している場合)
        case weekDay = "EEEE" // 日曜日
    }

    func setTemplate(_ template: Template) {
        // optionsは拡張用の引数だが使用されていないため常に0
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}

