//
//  CountDown.swift
//  CountDownAlpha
//
//  Created by yurina on 2018/08/02.
//  Copyright © 2018年 yurina. All rights reserved.
//

import Foundation
import CalculateCalendarLogic

class CountDown {
    
    private let settingInfo : SettingInfo
    
    init(settingInfo: SettingInfo) {
        self.settingInfo = settingInfo
    }
    
    /**
    カウントダウンを実行する
     */
    func execution() -> Int {
        
        let formatters = DateFormatter()
        formatters.dateFormat = "yyyyMMdd"
        formatters.timeZone = TimeZone.ReferenceType.local
        
        let calendar = Calendar.current
        
        // 今日の日付を取得
        let dateFromStr = formatters.string(from: Date()) // yyyyMMdd
        let dateFromSplit = splitDayString(targetDay: dateFromStr) // [yyyy, MM, dd]に文字列を分割
        let dateFrom = calendar.date(from: DateComponents(year: Int(dateFromSplit[0]), month: Int(dateFromSplit[1]), day: Int(dateFromSplit[2])))! // 今日の日付
        
        // 設定した日付を取得
        let dateToStr = settingInfo.dateTo
        let dateToSplit = splitDayString(targetDay: dateToStr)
        let dateTo = calendar.date(from: DateComponents(year: Int(dateToSplit[0]), month: Int(dateToSplit[1]), day: Int(dateToSplit[2])))! // 設定した日付
        
        /// カウントダウン（最大値）
        var comps: DateComponents
        comps = calendar.dateComponents([.day], from: dateFrom, to: dateTo)
        
        var result : [String] = []
        
        var components = DateComponents()
        let calendars = Calendar(identifier: Calendar.Identifier.gregorian)
        
        
        // 今日から設定日までの対象日をリスト化
        for i in 0..<comps.day! {
            
            components.setValue(i + 1,for: Calendar.Component.day)
            let wk = calendars.date(byAdding: components, to: dateFrom)!
            let weekDay = calendars.component(.weekday, from: wk) // 1:日 2:月 3:火 4:水 5:木 6:金 7:土
            let wkStr = formatters.string(from: wk)

            // 祝祭日チェック
            if !settingInfo.horiday && !checkTargetHoriday(targetDay: wkStr) {
                // 祝祭日であるため、カウントしない
                continue
            }
            
            // 曜日チェック
            if !checkTargetWeekday(weekDay: weekDay) {
                // カウント対象の曜日でないため、カウントしない
                continue
            }
            
            // カウントする
            result.append(wkStr)
        }
        
        print(result)
                
        return result.count
    }

    // 文字列の抜き出し（setStartIndex 〜 setTargetIndex）
    private func splitDayString(targetDay:String) -> [String] {
        let year = String(targetDay[targetDay.index(targetDay.startIndex, offsetBy: 0)..<targetDay.index(targetDay.startIndex, offsetBy: 4)]) // yyyy
        let month = String(targetDay[targetDay.index(targetDay.startIndex, offsetBy: 4)..<targetDay.index(targetDay.startIndex, offsetBy: 6)]) // MM
        let day = String(targetDay[targetDay.index(targetDay.startIndex, offsetBy: 6)..<targetDay.index(targetDay.startIndex, offsetBy: 8)]) // dd
        
        return [year, month, day]
    }
    
    // 祝祭日チェック
    private func checkTargetHoriday(targetDay:String) -> Bool {
        let horiday = CalculateCalendarLogic.init()
        let targetDaySplit = splitDayString(targetDay: targetDay) // [yyyy, MM, dd]に文字列を分割

        if horiday.judgeJapaneseHoliday(year: Int(targetDaySplit[0])!, month: Int(targetDaySplit[1])!, day: Int(targetDaySplit[2])!) {
            // 祝祭日である
            return false
        } else {
            // 祝祭日でない
            return true
        }
    }
    
    // 曜日チェック
    private func checkTargetWeekday(weekDay:Int) -> Bool {
        // 除外する曜日設定を取得 [日、月、火、水、木、金、土]
        let weekDaySettingInfo = [settingInfo.sunday, settingInfo.monday, settingInfo.tuesday, settingInfo.wednesday, settingInfo.thursday, settingInfo.friday, settingInfo.saturday]
        
        if weekDaySettingInfo[weekDay - 1] {
            // カウント対象の曜日である
            return true
        }
        // カウント対象の曜日でない
        return false
    }
    

}
