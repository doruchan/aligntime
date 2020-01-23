//
//  Calendar.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI


struct CalendarManager: View {

    @State var multipleIsPresented = true
       
    var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*30), mode: 3)
   
    var body: some View {
        VStack(alignment: .center) {
            RKViewController(isPresented: self.$multipleIsPresented, rkManager: self.rkManager1)
            IntervalFields()
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .animation(.spring())
            Spacer()
        }.onAppear(perform: startUp)
    }
       
    func startUp() {
        //self.multipleIsPresented.toggle()
        
         //let testOnDates = [Date().addingTimeInterval(60*60*24), Date()]
         //rkManager1.selectedDates.append(contentsOf: testOnDates)
         
         // example of some foreground colors
         rkManager1.colors.weekdayHeaderColor = Color.white
         rkManager1.colors.monthHeaderColor = Color.green
         rkManager1.colors.textColor = Color.blue
         rkManager1.colors.disabledColor = Color.red
       }
}

#if DEBUG
struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarManager()
    }
}
#endif
