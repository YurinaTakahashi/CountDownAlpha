//
//  AddCowntDownSetView.swift
//  CountDownAlpha
//
//  Created by yurina on 2018/08/02.
//  Copyright © 2018年 yurina. All rights reserved.
//

import UIKit
import TextFieldEffects

class AddCountDownSetView : UIViewController {
    
    //    @IBOutlet weak var dataTo: UIPickerView!
    @IBOutlet weak var titleTextField: AkiraTextField!
    @IBOutlet weak var endDateTextField: AkiraTextField!
    
    @IBOutlet weak var titleErrorMsg: UILabel!
    @IBOutlet weak var endDateErrorMsg: UILabel!
    
    @IBOutlet weak var sunday: UISwitch!
    @IBOutlet weak var monday: UISwitch!
    @IBOutlet weak var tuesday: UISwitch!
    @IBOutlet weak var wednesday: UISwitch!
    @IBOutlet weak var thursday: UISwitch!
    @IBOutlet weak var friday: UISwitch!
    @IBOutlet weak var saturday: UISwitch!
    @IBOutlet weak var horiday: UISwitch!
    
    @IBOutlet weak var createBt: UIButton!
    
    var toolBar:UIToolbar!

    
    // 設定データ文字列（0 = カウントしない / 1 = カウントする）
    private var setNo : String = ""
    private var setTitle : String = ""
    private var setDateTo : String = ""
    private var setSunday : String = "1"
    private var setMonday : String = "1"
    private var setTuesday : String = "1"
    private var setWednesday : String = "1"
    private var setThursday : String = "1"
    private var setFriday : String = "1"
    private var setSaturday : String = "1"
    private var setHoriday : String = "1"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 終了日Picker上のtoolbarのdoneボタン
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(self.doneBtn))
        toolBar.items = [toolBarBtn]
        endDateTextField.inputAccessoryView = toolBar
        
        // 終了日の初期値 = 今日
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy.MM.dd";
        endDateTextField.text = dateFormatter.string(from: Date())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     終了日Pickerを表示
     */
    @IBAction func endDateFieldAction(_ sender: UITextField) {
        // Picker生成
        let datePickerView : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.locale = Locale.init(identifier: "ja_JP")
        datePickerView.minimumDate = Date()
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action:  #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy.MM.dd";
        endDateTextField.text = dateFormatter.string(from: sender.date)
    }

    @objc func doneBtn(){
        endDateTextField.resignFirstResponder()
    }
    
    @IBAction func createBtAction(_ sender: Any) {
        let title = titleTextField.text
        let endDate = endDateTextField.text
        
        // テキスト記入チェック
        if title == "" {
            // 終了日が未記入だったら、警告を出す
            titleErrorMsg.isHidden = false
        } else {
            titleErrorMsg.isHidden = true
        }
        
        if endDate == "" || endDate?.count != 10 {
            // 終了日が未記入だったら、警告を出す
            endDateErrorMsg.isHidden = false
        } else {
            endDateErrorMsg.isHidden = true
        }
        
        if title == "" || endDate == "" || endDate?.count != 10 {
            // どれかが未記入だったら以降の処理を実行しない
            return
        }

        setNo = "2"
        setTitle(title: title!)
        setDateTo = endDate!
        setCountDay()

        // 設定データ書き込み処理を開始する
        startCreateData()
    }
    
    /**
     タイトルの文字列を作成する
     */
    private func setTitle(title: String) {
        setTitle = title.replacingOccurrences(of:".", with:"")
    }
    
    /**
     カウントする日を設定する
    */
    private func setCountDay() {
        if sunday.isOn {
            setSunday = "1"
        } else {
            setSunday = "0"
        }
        if monday.isOn {
            setMonday = "1"
        } else {
            setMonday = "0"
        }
        if tuesday.isOn {
            setTuesday = "1"
        } else {
            setTuesday = "0"
        }
        if wednesday.isOn {
            setWednesday = "1"
        } else {
            setWednesday = "0"
        }
        if thursday.isOn {
            setThursday = "1"
        } else {
            setThursday = "0"
        }
        if friday.isOn {
            setFriday = "1"
        } else {
            setFriday = "0"
        }
        if saturday.isOn {
            setSaturday = "1"
        } else {
            setSaturday = "0"
        }
        if horiday.isOn {
            setHoriday = "1"
        } else {
            setHoriday = "0"
        }
    }
    
    private func startCreateData() {

        if setSettingData(setData: createSetData()) {
            // 設定データ書き込み成功
            print("成功")
            
        } else {
            // 設定データ書き込み失敗
            print("失敗")
            let alertView = UIAlertController(title: "",message: "作成に失敗しました。", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
                //        ②-2 OKがクリックされた時の処理
                
                
            }
            alertView.addAction(okAction)
            present(alertView,animated: true,completion: nil)

        }
    }
    
    /**
     設定データを作成する
     */
    private func createSetData() -> String {
        
        var createData : String = ""
        createData.append(setNo + ",")
        createData.append(setTitle + ",")
        createData.append(setDateTo + ",")
        createData.append(setSunday + ",")
        createData.append(setMonday + ",")
        createData.append(setTuesday + ",")
        createData.append(setWednesday + ",")
        createData.append(setThursday + ",")
        createData.append(setFriday + ",")
        createData.append(setSaturday + ",")
        createData.append(setHoriday)

        return createData
    }
    
    /**
     設定ファイルにデータを保存する
     */
    private func setSettingData(setData: String) -> Bool {
        
        // ファイル開く
        let path = Bundle.main.path(forResource: "SettingData", ofType: "csv")
        let dataURL = URL(fileURLWithPath: path!)
        do {
            // ファイル読み込み
            let binaryData = try Data(contentsOf: dataURL, options: [])
            let binaryString = String(data: binaryData, encoding: .utf8)
            
            // 読み込んだデータを配列に格納
            var dataList : [String] = []
            dataList = binaryString!.components(separatedBy: "\n")
            
            // 追加するデータを配列に追加する
            dataList.append(setData)
            
            // ゴミデータであるため、削除する
            var i = 0
            while (i < dataList.count) {
                if dataList[i].count < 26 {
                    dataList.remove(at: i)
                } else {
                    i = i + 1
                }
            }
            
            // No.を基にソートする（昇順）
            dataList.sort()
            
            // 書き込む用にひとつの文字列にする
            var writeData : String = ""
            for i in 0..<dataList.count {
                writeData.append(dataList[i])
                if i+1 < dataList.count {
                    writeData.append("\n")
                }
            }
            
            // ファイル書き込み
            try writeData.write( to: dataURL, atomically: false, encoding: String.Encoding.utf8 )
            
            return true
            
        } catch {
            print("Failed to write the file.")
        }
        
        return false
    }
    
}
