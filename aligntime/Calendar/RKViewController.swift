//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//
import SwiftUI


struct RKViewController: View {
    @EnvironmentObject var core_data: AlignTime
    @State private var monthOffset = 0
    //@Binding var isPresented: Bool
    @State var isPresented: Bool = false
    @State private var isAnimation = false
    @State private var eege = Edge.trailing
    @State var direction:Bool = true
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    func getMonthHeader2() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = self.core_data.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: self.core_data.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = self.monthOffset
        
        return self.core_data.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
    }
    
    func RKFirstDateMonth() -> Date {
        var components = self.core_data.calendar.dateComponents(calendarUnitYMD, from: core_data.minimumDate)
        components.day = 1
        
        return self.core_data.calendar.date(from: components)!
    }
    
    var body: some View {
        Group() {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.accentColor)
                VStack {
                    HStack {
                        Spacer()
                        HStack{
                            Button("<  ") {
                                self.monthOffset -= 1;
                                self.direction = false
                                withAnimation {
                                    self.isAnimation.toggle()
                                }
                            }
                            .foregroundColor(Color(UIColor.systemBackground))
                            Button("  >") {
                                self.monthOffset += 1;
                                self.direction = true
                                withAnimation {
                                    self.isAnimation.toggle()
                                }
                            }
                            .foregroundColor(Color(UIColor.systemBackground))
                        }
                        Spacer()
                        Text(self.getMonthHeader2())
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size:20))
                            .frame(width: 170)
                            .padding(.horizontal,10)
                    }
                    Divider()
                    RKWeekdayHeader()
                    if isAnimation {
                        RKMonth(isPresented: self.$isPresented, monthOffset: self.monthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    else
                    {
                        RKMonth(isPresented: self.$isPresented, monthOffset: self.monthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    Spacer()
                }
                .padding(.top,10)
            }
            .padding(.horizontal,20)
            .frame(height: 320)
        }
    }
    
    func numberOfMonths() -> Int {
        
        return core_data.calendar.dateComponents([.month], from: core_data.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = core_data.calendar.dateComponents([.year, .month, .day], from: core_data.maximumDate)
        components.month! += 1
        components.day = 0
        
        return core_data.calendar.date(from: components)!
    }
}
