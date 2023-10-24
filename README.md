# Cardfit
![image](https://github.com/DONG-WOON/Cardfit/assets/80871083/09ce394f-c821-4785-be9b-ef26ccd1a199)

## 멤버
    🍊Huko: https://github.com/ykm989
    🍅Domb: https://github.com/DONG-WOON
## 기간
23/05 ~ 23/06 (2개월)

## 구현화면
<img src="https://github.com/DONG-WOON/Cardfit/assets/80871083/5f88b0f4-0b5c-420e-8894-c6854a879746" width=220>
<img src="https://github.com/DONG-WOON/Cardfit/assets/80871083/242631ad-1af7-43f9-b61c-9d40628623d9" width=220>
<img src="https://github.com/DONG-WOON/Cardfit/assets/80871083/94ce7fb6-719d-49f9-92a5-b8e68af09762" width=220>
<img src="https://github.com/DONG-WOON/Cardfit/assets/80871083/be2a94e8-f6fd-441b-89e4-9c4d7c0e9411" width=220>
<img src="https://github.com/DONG-WOON/Cardfit/assets/80871083/f65ee5d3-4e54-4952-b95d-a6f722240308" width=220>
<img src="https://github.com/DONG-WOON/Cardfit/assets/80871083/d47b05d5-ca0a-4457-8f21-a28732b6064c" width=220>


## 사용기술

iOS
|  아키텍처      | 프레임워크 | 라이브러리           |
|    --          |     --     |     --               |
|   MVVM         |  SwiftUI   | Firebase Firestore   |
|                |  WidgetKit | Firebase Storage     | 
|                |  Combine   |         Realm        |


BE
|   프레임워크  |        라이브러리       |
|     --     |           --         |
|  Selenium  |  Beautiful Soup      |
|            | Firebase Firestore   |
|            | Firebase Storage     | 

## 핵심경험

#### *Widget Intent Configuration*
> 위젯에서 보여줄 카드를 선택할 수 있도록 편집 기능 제공

#### *Database*
> 카드 데이터 초기에만 네트워크 통신, 데이터베이스에 저장하여
> 데이터 통신 비용 절감

#### *Bind<Value>*
> 프로퍼티 Binding, Observable 프로퍼티로 변경
```swift
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
```

#### *@Namespace / matchedGeometryEffect() 애니메이션 동기화*
> 계층이 다른 뷰의 동일한 애니메이션 효과 부여

### *Github Actions (CI)*
> 협업시 프로젝트의 개발 브랜치 통합과정에서 테스트, 프로젝트의 병합 충돌 방지

### Database Migration
> 추푸 플랫폼 대응을 위한 DB Migration 작업 realm
> 유지보수향상
> DB 처리속도 향상

## 트러블 슈팅

Issue 1. 메인화면의 부자연스러운 애니메이션 
-> SwiftUI의 View는 State 기반으로, 데이터 변경시, View가 새롭게 그려짐
-> Animation 로직과 충돌
-> ViewModel에 Iamge를 저장하여 해결
-> 하지만!! ViewModel이 UI 요소를 저장하고 있는것은 부자연스럽다고 판단
-> 다르게 처리할 수 있는 방식은 없는지, 데이터 변경 로직을 변경할 수는 없는지 고민중.

Issue 2. 위젯에서 모델과 데이터 공유
> 모델
    App과 Widget에서 동일한 모델을 사용, Wiget, Intent Extension과 Scope 문제
    -> Widget과 Intent Extension에서 접근 가능하도록 file target 처리
> 데이터
    App Group 사용하여 데이터 Sharing
