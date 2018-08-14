//
//  AddCowntDownSetView.swift
//  CountDownAlpha
//
//  Created by yurina on 2018/08/02.
//  Copyright © 2018年 yurina. All rights reserved.
//

import UIKit

class AddCountDownSetView : UIViewController {
    
//    @IBOutlet weak var dataTo: UIPickerView!

    
    
    // 設定データ文字列（0 = カウントしない / 1 = カウントする）
    private var setNo : String = ""
    private var setTirtle : String = ""
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
        
        if setSettingData(setData: createSetData()) {
            // 設定データ書き込み成功
            
        } else {
            // 設定データ書き込み失敗
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createSetData() -> String {
        
        
        var createData : String = ""
        createData.append(setNo + ",")
        createData.append(setTirtle + ",")
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
