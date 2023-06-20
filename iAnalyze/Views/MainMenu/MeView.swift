//
//  MeView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 12/03/2023.
//

import SwiftUI

struct MeView: View {
    
    @State private var first_name = ""
    @State private var last_name = ""
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $first_name)
                TextField("First Name", text: $last_name)
            }
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
