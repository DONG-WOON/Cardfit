//
//  MainBenefitViewCell.swift
//  Cardfit
//
//  Created by 서동운 on 6/20/23.
//

import SwiftUI

struct MainBenefitViewCell: View {
    let title: String
    
    var body: some View {
        Button(title) {
            print(title)
        }
        .disclosureGroupStyle(AutomaticDisclosureGroupStyle())
        .buttonStyle(.plain)
        .font(.subheadline)
        .fontWeight(.semibold)
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.1))
        }
    }
}

struct MainBenefitViewCell_Previews: PreviewProvider {
    static var previews: some View {
        MainBenefitViewCell(title: "")
    }
}
