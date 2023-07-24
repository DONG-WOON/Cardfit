//
//  CardListView.swift
//  Cardfit
//
//  Created by 서동운 on 6/2/23.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject private var viewModel: CardListViewModel
    
    @State private var isLoading = true
    @State private var buttonIsDisabled = true
    @State private var everyCardIsFetched = false
    
    init(company: CompanyList) {
        self.viewModel = CardListViewModel(company: company)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.cardList, id: \.self) { card in
                    CardListViewCell(isSelected: bindingForCard(card), card: card, company: viewModel.company)
                        .environmentObject(viewModel)
                    
                }
                
                    
                if everyCardIsFetched == false {
                    if buttonIsDisabled == false {
                        Button {
                            Task {
                                buttonIsDisabled = true
                                await loadCardList()
                                buttonIsDisabled = false
                            }
                        } label: {
                            if !buttonIsDisabled {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    } else {
                        VStack {
                            HStack {
                                DotView()
                                DotView(delay: 0.2)
                                DotView(delay: 0.4)
                            }
                            Text("데이터를 불러오는 중입니다.")
                                .font(.title3)
                                .foregroundColor(Color("AppColor"))
                        }
                    }
                } else {
                    Text("카드 더이상 없음.")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.selectedCards.isEmpty {
                    NavigationLink(destination: LoadingView(selectedCards: viewModel.selectedCards).navigationBarBackButtonHidden()) {
                        Text("추가")
                            .foregroundColor(Color("AppColor"))
                    }
                } else {
                    Text("추가")
                        .foregroundColor(.gray)
                }
            }
        }
        .task {
           await loadCardList()
            buttonIsDisabled = false
        }
        .onDisappear {
            viewModel.selectedCards = []
        }
    }
    
    private func bindingForCard(_ card: Card) -> Binding<Bool> {
        Binding<Bool> (
            get: {
                viewModel.selectedCards.contains(card)
            },
            set: { newValue in
                if newValue {
                    viewModel.selectedCards.append(card)
                } else {
                    viewModel.selectedCards.removeAll(where: { $0 == card })
                }
            }
        )
    }
    
    private func loadCardList() async {
        let result = await viewModel.fetchCardList()
        switch result {
        case .success(let cards):
            viewModel.cardList = cards
            isLoading = false
        case .failure(let error):
            print(error)
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView(company: .bc)
        }
    }
}

