//
//  SettingInfo.swift
//  CountDownAlpha
//
//  Created by yurina on 2018/08/02.
//  Copyright © 2018年 yurina. All rights reserved.
//

import Foundation

class SettingInfo {

    var number : String = ""
    
    // タイトル
    var title : String = ""
    
    // 設定した日付
    var dateTo : String = ""
    
    // 曜日 ( true:カウントする / false:カウントしない）
    var sunday : Bool = true
    var monday : Bool = true
    var tuesday : Bool = true
    var wednesday : Bool = true
    var thursday : Bool = true
    var friday : Bool = true
    var saturday : Bool = true

    // 祝日
    var horiday : Bool = true
    
//    // その他の除外する日にち
//    public var exceptDays : [String]
    
    init(setData:[String]) {
        
        number = setData[0]
        title = setData[1]
        dateTo = setData[2]
        
        // 0 = カウントしない / 1 = カウントする
        if setData[3] == "0" {
            sunday = false
        }
        if setData[4] == "0" {
            monday = false
        }
        if setData[5] == "0" {
            tuesday = false
        }
        if setData[6] == "0" {
            wednesday = false
        }
        if setData[7] == "0" {
            thursday = false
        }
        if setData[8] == "0" {
            friday = false
        }
        if setData[9] == "0" {
            saturday = false
        }
    }

}
