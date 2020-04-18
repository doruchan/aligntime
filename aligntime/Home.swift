//
//  Home.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var core_data: AlignTime
    @State private var selection = 0
    
    @State var showingProfile = false
    @State var isNavigationBarHidden: Bool = true
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 26))
                //.imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        NavigationView {
            TabView(selection: $selection){
                TodayManager()
                   .font(.title)
                   .tabItem {
                        VStack {
                            Text(NSLocalizedString("Today",comment:""))
                            Image(systemName: "bag")
                        }
                   }
                   .tag(0)

               CalendarManager()
                   .font(.title)
                   .tabItem {
                       VStack {
                           Text(NSLocalizedString("Calendar",comment:""))
                           Image(systemName: "calendar")
                       }
                   }
                   .tag(1)
           }
            .accentColor(.blue)
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile, onDismiss:{
                self.core_data.update_today_dates()
                self.core_data.push_user_defaults()
            }) {
                ProfileManager().environmentObject(self.core_data)
            }
            .gesture(DragGesture()
//            .onEnded({ (value) in
//                if (value.translation.width > 0){
//                    if (value.translation.width > 100) && (self.selection>=1){
//                        self.selection-=1
//                    }
//                }
//                else{
//                    if (value.translation.width < -100) && (self.selection<=1){
//                        self.selection+=1
//                    }
//                }
//            })
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
