//
//  CardfitWidget.swift
//  CardfitWidget
//
//  Created by 서동운 on 6/19/23.
//

import WidgetKit
import SwiftUI
import Intents


// 렌더링할 시기(업데이트 시기)를 알려주는 Timeline을 생성하는 객체
struct Provider: IntentTimelineProvider {
    
    // placeholder를 이용해서 appleWatch나 lockScreen의 민감한 정보들을 숨길수 있음.
    func placeholder(in context: Context) -> MyCardEntry {
        MyCardEntry(date: Date(), userCards: [Card(benefit: Benefits())], configuration: ConfigurationIntent())
    }

    // 단일 timeline 을 반환
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MyCardEntry) -> ()) {
        let entry = MyCardEntry(date: Date(), userCards: [Card(benefit: Benefits())], configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MyCardEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: hourOffset, to: currentDate)!
            let updateTime = Calendar.current.startOfDay(for: entryDate)
            let entry = MyCardEntry(date: updateTime, userCards: [Card(benefit: Benefits())], configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
        
//        do {
//            var cardEntities = [CardEntity]()
//            
//            let userCardEntity = try PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self, predicate: nil).first
//            guard let cardsSet = userCardEntity?.cards else { return }
//            guard let cardsArray = cardsSet.allObjects as? [CardEntity] else { return }
//            
//            for card in cardsArray {
//                cardEntities.append(card)
//            }
//            
//            let cards = try cardEntities.map { cardEntity in
//                let benefit = try JSONDecoder().decode(Benefits.self, from: cardEntity.benefit ?? Data())
//                let card = Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber ?? String(), cardImageURL: cardEntity.cardImageURL, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company, benefit: benefit)
//               
//                return card
//            }
//            
//            let currentDate = Date()
//            let updateTime = Calendar.current.startOfDay(for: currentDate)
//            let entry = MyCardEntry(date: updateTime, userCards: cards, configuration: configuration)
//            let timeline = Timeline(entries: [entry], policy: .never)
//            completion(timeline)
//            
//        } catch {
//            print(error, "사용자등록카드 데이터 불러오기 실패")
//        }
        
        // .atEnd: entry 시간이 모두 끝나면
        // .after(date): date 후에
        // .never: 특정시점에만 업데이트 하도록
    }
}

struct MyCardEntry: TimelineEntry {
    let date: Date
    let userCards: [Card]
    let configuration: ConfigurationIntent
}

struct MyCardView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var selectedCard: Card
    
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemLarge:
            MainBenefitView(card: selectedCard)
        default:
            VStack {
                Text("지원하지 않는 사이즈")
            }
        }
    }
}

struct CardfitWidget: Widget {
    let kind: String = "CardfitWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyCardView(selectedCard: Card(benefit: Benefits()), entry: entry)
        }
        .configurationDisplayName("나의 카드")
        .description("내가 등록한 카드의 상세보기를 빠르게 접근하세요")
        .supportedFamilies([.systemExtraLarge])
    }
}

struct CardfitWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyCardView(selectedCard: Card(benefit: Benefits()), entry: MyCardEntry(date: Date(), userCards: [Card(benefit: Benefits())], configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
