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
    
    // if user’s choose to hide sensitive
    // information on Apple Watch or the iPhone Lock Screen.
    func placeholder(in context: Context) -> MyCardEntry {
        MyCardEntry(date: Date(), configuration: ConfigurationIntent())
    }

    // 단일 timeline 을 반환
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MyCardEntry) -> ()) {
        let entry = MyCardEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MyCardEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: hourOffset, to: currentDate)!
            let updateTime = Calendar.current.startOfDay(for: entryDate)
            let entry = MyCardEntry(date: updateTime, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .never)
        // .atEnd: entry 시간이 모두 끝나면
        // .after(date): date 후에
        // .never: 특정시점에만 업데이트 하도록
        completion(timeline)
    }
}

struct MyCardEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MyCardView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    var benefit: [CardBenefit]

    var body: some View {
        switch widgetFamily {
        case .systemExtraLarge:
            MainBenefitView(benefit: benefit)
        default:
            VStack {
                Text(entry.date, style: .date)
                Text(entry.date, style: .time)
            }
        }
    }
}

struct CardfitWidget: Widget {
    let kind: String = "CardfitWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyCardView(entry: entry, benefit: exBenefit)
        }
        .configurationDisplayName("나의 카드")
        .description("내가 등록한 카드의 상세보기를 빠르게 접근하세요")
        .supportedFamilies([.systemExtraLarge])
    }
}

struct CardfitWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyCardView(entry: MyCardEntry(date: Date(), configuration: ConfigurationIntent()), benefit: exBenefit)
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
