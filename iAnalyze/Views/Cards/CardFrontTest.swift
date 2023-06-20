//
//  CardFrontTest.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 18/06/2023.
//

import SwiftUI

struct LicenseView: View {
    var body: some View {
        VStack {
                   Image("Card") // Replace "credit_card_background" with your own image asset
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 300, height: 180) // Adjust the frame size as needed
                   
                   HStack {
                       VStack(alignment: .leading, spacing: 10) {
                           Text("SDI Open Water Diver License")
                               .font(.title)
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Spacer()
                           
                           Text("License Holder:")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Text("Your Name")
                               .font(.subheadline)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Text("License Number:")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Text("OWD12345")
                               .font(.subheadline)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Text("Certification Date:")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Text("June 18, 2023")
                               .font(.subheadline)
                               .foregroundColor(.white)
                               .padding(.horizontal)
                           
                           Spacer()
                       }
                       .padding(.leading)
                       
                       Spacer()
                   }
                   .padding(.bottom, 20)
               }
               .frame(width: 300, height: 180) // Adjust the frame size as needed
               .cornerRadius(10)
               .shadow(radius: 5)
           }
       }




struct CardFrontTest_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView();
    }
}
