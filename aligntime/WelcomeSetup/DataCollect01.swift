//
//  DataCollect01.swift
//  aligntime
//
//  Created by Ostap on 26/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI
import UIKit


struct DataCollect01: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var user_data: AlignTime
    @State var view_mode:Bool = true
        
    var body: some View {
        Section() {
            VStack(alignment: .leading){
                VStack(alignment: .center){
                    Text(NSLocalizedString("How many aligners do you require?",comment:""))
                        .font(.headline)
                        .foregroundColor(.blue)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.required_aligners_total)")
                        Stepper("", value: $user_data.required_aligners_total, in: 1...200)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                //.padding(.top, 30)
                VStack(alignment: .center){
                    Text(NSLocalizedString("Number of days for each aligners",comment:""))
                        .font(.headline)
                        //.fontWeight(.regular)
                        .foregroundColor(.blue)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.aligners_wear_days)")
                        Stepper("", value: $user_data.aligners_wear_days, in: 1...31)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom)
                VStack(alignment: .center){
                    Text(NSLocalizedString("Preferred aligners wear hours per day",comment:""))
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .foregroundColor(.blue)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.wear_hours)")
                        Stepper("", value: $user_data.wear_hours, in: 12...24)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom)
                
                Spacer()
                if self.view_mode{
                    DataCollectControllButton01()
                        .padding(.horizontal,20)
                        .padding(.bottom,5)
                }
            }
        }
        //.navigationBarTitle("")
        .navigationBarBackButtonHidden(view_mode)
        //.navigationBarHidden(view_mode)
    }
}

struct DataCollectControllButton01: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var user_data: AlignTime

    var body: some View {
        HStack(alignment: .center,spacing: 0){
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(height: 40)
                        .foregroundColor(Color.secondary)
                        .opacity(0.5)
                    Text(NSLocalizedString("Back",comment:""))
                        .foregroundColor(Color.white)
                }
            }
            NavigationLink(destination: DataCollect02()) {
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(height: 40)
                        .padding(0)
                    Text(NSLocalizedString("Next",comment:""))
                        .foregroundColor(.white)
                }
            }
        }
    }
}
