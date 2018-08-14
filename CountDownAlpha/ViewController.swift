//
//  ViewController.swift
//  CountDownAlpha
//
//  Created by yurina on 2018/08/01.
//  Copyright © 2018年 yurina. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 設定したデータがある場合、カウントダウンを実行する
        var countDownData : [Int] = []
        let settingData = getSettingData()
        
        if settingData.count != 0 {
            for i in 0..<settingData.count {
                let countDown = CountDown.init(settingInfo: settingData[i])
                
                // カウントダウンの結果を格納
                countDownData.append(countDown.execution())
            }
        }

        print(countDownData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     設定ファイルから設定データを読み込む
     */
    func getSettingData() -> [SettingInfo] {
        // ファイル開く
        let path = Bundle.main.path(forResource: "SettingData", ofType: "csv")
        let dataURL = URL(fileURLWithPath: path!)
        do {
            // ファイル読み込み
            let binaryData = try Data(contentsOf: dataURL, options: [])
            let binaryString = String(data: binaryData, encoding: .utf8)
            
            if binaryString != nil {
                var dataList : [String] = []
                var settingInfoArray : [SettingInfo] = []

                dataList = binaryString!.components(separatedBy: "\n")
                // SettingInfoへセットする
                for i in 0..<dataList.count {
                    if (dataList[i] != "" && dataList[i].count >= 26) {
                        let settingInfo = SettingInfo.init(setData: dataList[i].components(separatedBy: ","))
                        
                        // SettingInfoにセットした設定内容を保持する
                        settingInfoArray.append(settingInfo)
                    }
                }
                
                return settingInfoArray
            }
        } catch {
            print("Failed to read the file.")
        }
        
        return []
    }
}

