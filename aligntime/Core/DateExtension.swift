//
//  DateExtension.swift
//  aligntime
//
//  Created by Ostap on 12/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

extension Date {
    public func setTime(hour: Int, min: Int, sec: Int) -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        //components.timeZone = .current
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
    
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
    
    public func fromTimestamp(_ time: Int64) -> Date {
        return Date(timeIntervalSince1970:TimeInterval(time/1000))
    }
    
    
    public func belongTo(date: Date, toGranularity: Calendar.Component = .day) -> Bool {
       return (Calendar.current.isDate(self, inSameDayAs: date))
    }
    
    func timestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
