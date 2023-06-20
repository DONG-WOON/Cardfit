//
//  TitleLabel.swift
//  Cardfit
//
//  Created by 서동운 on 6/20/23.
//

import SwiftUI

struct TitleLabel: View {
    let title: String
    let font: Font
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(font)
                .bold()
                .padding(5)
            Spacer()
        }
    }
}

struct TitleLabel_Previews: PreviewProvider {
    static var previews: some View {
        TitleLabel(title: "", font: .body)
    }
}
