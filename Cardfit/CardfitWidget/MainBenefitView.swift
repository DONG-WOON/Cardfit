//
//  MainBenefitView.swift
//  Cardfit
//
//  Created by 서동운 on 6/19/23.
//

import SwiftUI
import WidgetKit

struct CardBenefit {
    let category: String
    let title: String
    let description: String
}

let exBenefit: [CardBenefit] = [
    CardBenefit(category: "1", title: "간편 결제", description: "간편결제시 15% 할인"),
    CardBenefit(category: "2", title: "놀이공원", description: "놀이공원에서 10% 할인"),
    CardBenefit(category: "3", title: "편의점", description: "편의점에서 결제시 5% 할인")
]

struct MainBenefitView: View {
    var benefit: [CardBenefit]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                TitleLabel(title: "국민 Balance 카드", font: .title2)
                    .padding([.top, .leading, .bottom], 15)
                ForEach(benefit, id: \.category) { benefit in
                    MainBenefitViewCell(title: "\(benefit.title): \(benefit.description)")
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
        MainBenefitView(benefit: exBenefit).previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
