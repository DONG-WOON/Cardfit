//
//  MainBenefitView.swift
//  Cardfit
//
//  Created by 서동운 on 6/19/23.
//

import SwiftUI
import WidgetKit

struct MainBenefitView: View {
    let card: Card
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                TitleLabel(title: card.cardName ?? String(), font: .title2)
                    .padding([.top, .leading, .bottom], 15)
                ForEach(card.benefit, id: \.self) { benefit in
                    MainBenefitViewCell(title: "\(benefit.keys.first): \(benefit.values)")
                }
                .padding([.leading, .trailing], 15)
                .padding(.bottom, 5)

                Spacer()
                Divider()
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    TitleLabel(title: "브랜드", font: .title3)
                    LogoHStack(brands: [""])
                    
                }
                .padding(15)
            }
        
            CardImageView(name: "CardImage")
        }
    }
}

struct LogoHStack: View {
    
    let brands: [String]
    
    var body: some View {
        HStack(spacing: -5) {
            ForEach(0..<10) { index in
                //Image(brand[index])
                
                Circle()
                    .foregroundColor(Color.randomColor())
                    .frame(width: 35, height: 35)
            }
        }
    }
}

struct MainBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        MainBenefitView(card: Card(benefit: Benefits())).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
