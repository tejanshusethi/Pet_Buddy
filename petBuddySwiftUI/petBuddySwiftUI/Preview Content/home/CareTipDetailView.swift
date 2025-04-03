//
//  CareTipDetailView.swift
//  petBuddySwiftUI
//
//  Created by NITIN KALIRAMAN on 22/03/25.
//

import SwiftUI

//struct CareTipDetailView: View {
//    let careTip: CareTip
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                
//                // Image
//                Image(careTip.imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//                    .frame(height : 300)
//                    .cornerRadius(12)
//                
//                // Title
//                Text(careTip.title)
//                    .font(.title)
//                    .bold()
//                    .frame(maxWidth: .infinity, alignment: .center)
//
//                // Tips & Tricks
//                Text("Tips & Tricks")
//                    .font(.headline)
//                    .bold()
//                
//                Text(careTip.tips)
//                    .font(.body)
//                
//                // Benefits Section
//                Text("Benefits of \(careTip.title)")
//                    .font(.headline)
//                    .bold()
//                
//                Text(careTip.benefits)
//                    .font(.body)
//
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationBarTitle("", displayMode: .inline)
//    }
//}



import SwiftUI

struct CareTipDetailView: View {
    var tip: CareTips

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(uiImage: tip.careImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(tip.careTitle)
                    .font(.largeTitle)
                    .bold()

                Text(tip.careDescription)
                    .font(.body)

                Divider()

                Text("Tips")
                    .font(.headline)
                ForEach(tip.careInfo.tips, id: \.self) { tip in
                    Text("• \(tip)")
                }

                Divider()

                Text("Benefits")
                    .font(.headline)
                ForEach(tip.careInfo.benefits, id: \.self) { benefit in
                    Text("✓ \(benefit)")
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(tip.careTitle)
        .toolbar(.hidden, for: .tabBar)
    }
}
