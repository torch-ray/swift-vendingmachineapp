# Vending Machine App

## iPad 프로젝트 설정
- General - Deployment Info: 
	- Devices: iPad
	- Device Orientation: Landscape Left, Landscape Right 만 체크
- 시뮬레이터: 아이패드 프로 10.5

### 레벨2 VendingMachine 코드 복사
- **기존 코드**들은 대부분 **Model 역할**을 담당
- iOS 앱 구조는 MVC 중에서도 우선 **ViewController-Model 관계부터 집중**하고, ViewController-View 관계는 다음 단계에서 개선한다.

### 기본 자판기 모델 적용
- 레벨 2에서 구현한 ActivateMode 프로토콜, 프로토콜을 채택한 AdminMode, UserMode 구조체 제거
	- 모드 및 모드별 메뉴를 입력받아 선택된 메뉴의 기능 수행하고 출력(InputView, OutputView)하는 역할이었으나, UI로 대체할 수 있는 부분이므로 제거함
- ViewController 클래스에서 VendingMachine 객체를 사용하여 음료 객체를 추가하고 재고목록을 출력
	- ActivateMode 타입이 제거되어 VendingMachine의 함수를 그대로 사용함

### 학습 내용

>- **[앱 인터페이스와 구성요소](https://github.com/undervineg/swift-vendingmachineapp/blob/vending-step2/md/app_interfaces.md)**
>- **[시스템 프레임워크 - 1. 앱 초기화 과정](https://github.com/undervineg/swift-vendingmachineapp/blob/vending-step2/md/app_initialization.md)**
>- **[시스템 프레임워크 - 2. 메인 런 루프](https://github.com/undervineg/swift-vendingmachineapp/blob/vending-step2/md/main_run_loop.md)**
>- **[시스템 프레임워크 - 3. MVC 패턴구조](https://github.com/undervineg/swift-vendingmachineapp/blob/vending-step2/md/mvc_structure.md)**
>- **[시스템 프레임워크 - 4. 앱 생명주기](https://github.com/undervineg/swift-vendingmachineapp/blob/vending-step2/md/app_lifecycle.md)**
>- **[시스템 프레임워크 - 5. iOS와 코코아 터치 프레임워크](https://github.com/undervineg/swift-vendingmachineapp/blob/vending-step2/md/cocoatouch_framework.md)**

2017-01-09 (작업시간: 1일)

<br/>

## 자판기 앱 화면(view) 구현

![](img/2_vendingmachine_v1.png)

### 화면 구성
>- 각 상품에 대한 이미지를 추가한다.
>- 각 상품에 대한 재고 추가 버튼을 추가한다.
>- 각 상품에 대한 재고 레이블을 추가한다.
>- 100원, 500원, 1000원 금액을 입력하는 버튼을 추가한다.
>- 현재 잔액을 표시할 레이블을 추가한다.

- 각 상품과 라벨 등을 Stack View에 넣어 오토레이아웃 적용
- 중복되는 아웃렛들을 IBOutletCollection으로 만들고 tag를 부여하여 사용

#### IBOutletCollection 사용하기
1. 중복되는 요소들 중 하나를 View Controller로 끌어서 IBOutletCollection 만듦
2. 만든 IBOutletCollection 옆의 동그라미(+) 버튼을 Main.storyboard의 중복되는 요소들로 드래그하여 UI 객체배열 완성
3. 각 요소를 구분하기 위한 tag 부여
4. IBAction을 하나 만들어서 각 요소와 연결
5. IBAction 내에서 IBOutletCollection으로 만든 배열 사용
	- 예시:

		```swift
		@IBAction func buttonTapped(_ sender: UIButton) {
			for button in starButtons {
				// 액션이 일어난 버튼의 태그와 같거나 작은 버튼들에
				if button.tag <= sender.tag {
					button.setImage(UIImage.init(named: “star_selected”), 				for: .normal)
				} else {
					button.setImage(UIImage.init(named: “star_normal”), for: .normal)
				}
			}
		}
		```

>- IBOutletCollection은 순서를 보장하지 않는다.
>- 연결된 ViewController에는 NSArray로 생성된다.

[참고: What is an IBOutletCollection in iOS](https://medium.com/@abhimuralidharan/what-is-an-iboutletcollection-in-ios-78cfbc4080a1)

#### 라벨 내 마진 주기
- UILabel에 배경색을 주면 콘텐츠(텍스트)와 배경색 사이에 공간이 없어 보기 좋지 않음.
- **UILabel에는 마진을 줄 수 없다.**
- **버튼을 라벨 대신 사용한다 :**
    - Accessibility > **User Interaction Enabled 체크 해제**
    - Accessibility > **Static Text 체크**
    - View > **User Interaction Enabled 체크 해제**
    - Size Inspector > **Content Insets** 값 정의

![](img/2_margin.png)

#### UI 요소에 테두리/색상테두리/둥근테두리 주기
- Identity Inspector > User Defined Runtime Attributes에 키 추가 :
    - 테두리: **layer.borderWidth** (Number)
    - 테두리색상: **layer.borderUIColor** (Color) 
    - 둥근테두리: **layer.cornerRadius** (Number)

![](img/2_runtime_attribute.png)

#### StackView에 spacing을 주면 이미지가 올라감
- Baseline Relative 체크

![](img/2_baseline.png)

#### 이미지뷰와 재고라벨에 Set vertical compression resistance priority to 123 에러가 남
- 문제원인: stackview에 spacing을 주면 콘텐츠가 무너질 수도 있기 때문에 나타나는 에러로 추정.
- 해결방법: 재고라벨에 Height 제약을 줌.

<img src="img/2_height.png" width="30%"></img>

#### 이미지뷰 크기 동일하게 고정하기(150x150)
- 자기자신에게 제약조건 width, height를 주면 됨

<img src="img/2_width_height.png" width="40%"></img>

<br/>

### 기능 구현
>- 각 상품의 재고 추가 버튼을 누르면 각 상품 재고를 추가하도록 코드를 구현한다.
>- 재고 추가 버튼을 누르고 나면 전체 레이블을 다시 표시한다.
>- 금액 입력 버튼을 누르면 해당 금액을 추가하도록 코드를 구현한다.
>- 금액을 추가하고 나면 잔액 레이블을 다시 표시한다.

#### 프로토콜 UserServable에 insertMoney(_ money: MoneyManager.Unit) 정의 시, MoneyManager 클래스에 제네릭 제약조건이 필요
- 문제사항: 
	- insertMoney() 함수의 파라미터로 쓰이는 MoneyManager 클래스가 (Machine을 제네릭으로 가지는) 제약조건을 가짐. 
	- 하지만, 프로토콜 정의 시 `MoneyManager<Machine>.Unit`으로 적으면 `Using 'Machine' as a concrete type conforming to protocol 'Machine' is not supported` 에러 발생. 
	- 하지만 따로 associatedtype을 정의해주기에는 부수적인 제약조건 문제가 생길 가능성이 큼.
- 해결방법: `insertMoney(_ money: MoneyManager<Self>.Unit)`로 정의. UserServable은 Machine 클래스를 상속받으므로, <Self>를 사용하여 자기자신 타입(Self)을 넣어줘도 됨.

#### Model 업데이트 시, NotificationCenter 사용
- MVC에 맞추어 함수 설계
    - **View ➔ Controller**: **IBAction** 사용
    - **Controller ➔ Model**: Model 객체의 메소드 사용
    - **Model ➔ Controller**: **NotificationCenter.default.post()** 사용
        - 처음에는 ViewController의 View 업데이트 함수를 직접 호출하도록 만듦
        - iOS에서 Model은 직접 ViewController에 메시지를 보내지 않음 ➔ NotificationCenter 를 사용하는 방법으로 변경
    - **Controller ➔ View**: **update 함수** 정의, **NotificationCenter.default.addObserver()**로 Model에서 post한 Notification.Name에 해당하는 노티 발생 시, update 함수에 연결.

##### 문제점: 뷰 업데이트가 안 됨
- 문제원인: NotificationCenter.default 메소드들의 **object 파라미터 값**을 잘못 넣음
	- **addObserver 메소드의 object**: 노티를 **받을** 객체. nil인 경우, 어느 객체에서 보내든 상관 안 함
	- **post 메소드의 object**: 노티를 **보내는** 객체. 보통 post를 보내는 객체인 자기자신, **self**를 넣는다. nil인 경우, 보내는 객체가 어딘지 전달하지 않음.
	- **addObserver의 object가 정의되면, post의 object도 같이 정의해야 한다. 아니면 둘 다 nil로 정의해야 한다.**

#### NSUnknownKeyException 에러발생
- 에러코드: VendingMachineApp[37705:2367314] *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: **'[<VendingMachineApp.ViewController 0x7fef47508040> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key productImages.'**
- 문제원인: 뷰컨트롤러에 연결한 IBOutlet을 지우고나서 연결을 끊지 않음

2017-01-14 (작업시간: 1일)

<br/>

### Feedback
#### 스토리보드보다 코드로 객체를 만들고 표현하는 연습을 하는 편이 동작 방식을 이해하는 데 좋다. 
- `layer.cornerRadius` 값을 디자인 타임에 적용해서 확인하는 것도 좋지만, 코드로 속성을 어디에 넣어야 바뀌는지 공부하고 동작 방식을 이해하는 게 더 중요함
- 개선사항: 기존에 스토리보드의 Identity Inspector > User Defined Runtime Attributes에 줬던 `layer.cornerRadius`를 viewController에서 작성

#### 하나의 파일로 extension을 합치면 어떤 장단점이 있을까요?
- 익스텐션을 각 타입에 따라 여러 파일로 분리해놓는게 필요한 경우에만 선택적으로 확장할 수 있는 장점이 있다.

#### Notification.Name(enum.rawValue) 형태보다는 Notification.Name() 자체를 만들어두고 활용한다.
- 기존: 

	```swift
	enum Notifications: CustomStringConvertible {
	    case didUpdateInventory = "didUpdateInventory"
	    case didUpdateBalance = "didUpdateBalance"
	    var name: Notification.Name {
	        return Notification.Name(self.description)
	    }
	    var description: String {
	        switch self {
	        case .didUpdateInventory: return
	        case .didUpdateBalance: return
	        }
	    }
	}
	```
	사용 시: `Notification.Name(NotificationNames.didUpdateBalance.description)`
- 개선: 

	```swift
	enum Notifications: String {
	    case didUpdateInventory
	    case didUpdateBalance
	    var name: Notification.Name {
	        return Notification.Name(self.rawValue)
	    }
	}
	```
	사용 시: `Notifications.didUpdateBalance.name`
	
#### ★ 화면 요소와 데이터를 매칭해야 하는 경우는 항상 발생한다.
- 직접적으로 스토리보드에서 태그값을 넣어놓고 sender.tag 에 접근하기 보다는 화면요소와 데이터를 매칭할 수 있는 데이터 구조를 갖고 있는 것이 좋다.
- 값을 바꾸거나 데이터 구조가 변경되면 이에 따라 화면 요소까지 바꿔야 하기 때문이다.
	
	``` swift
	@objc func insertMoney(_ sender: UIButton) {
		// 버튼 태그에 따라 특정 금액 삽입.
		machine.insertMoney(MoneyManager<VendingMachine>.Unit(rawValue: sender.tag)!)
	}	
	```
- 개선사항: Mapper 구조체를 작성하여 UI요소인 sender의 tag에 따라 특정 model 값을 리턴하는 함수들 추가

	```swift
	struct Mapper {
	    static func mappingUnit(with sender: UIButton) -> MoneyManager<VendingMachine>.Unit? {
	        var unit = MoneyManager<VendingMachine>.Unit(rawValue: 100)
	        switch sender.tag {
	        case 1: unit = MoneyManager<VendingMachine>.Unit(rawValue: 100)
	        case 2: unit = MoneyManager<VendingMachine>.Unit(rawValue: 500)
	        case 3: unit = MoneyManager<VendingMachine>.Unit(rawValue: 1000)
	        default: break
	        }
	        return unit
    	}
   	 	...
    }
	```
	>- UIButton, UILabel 등을 같은 타입으로 받으려면 **UIView**를 쓰면 된다.

#### 하드코딩해서 단위를 붙이지 않는다.
- 단위를 붙일 때, 여러 국가를 지원할 때를 고려해서 하드코딩 값을 넣기보다는 Formatter를 만드는 편이 좋다.
- 기존:

	```swift
	@objc func updateBalanceLabel() {
		if let balance = machine.showBalance().currency() {
			balanceLabel.text = balance + "원"
		}
	}	
	```
- 개선: Formatter 열거형 정의

	```swift
	enum Formatter {
	    case kor(Int)
	    case eng(Int)
	    var moneyUnit: String {
	        switch self {
	        case .kor(let value):
	            guard let valueInCurrencyFormat = value.currency() else { return "원" }
	            return valueInCurrencyFormat + "원"
	        case .eng(let value):
	            guard let valueInCurrencyFormat = value.currency() else { return "won" }
	            return valueInCurrencyFormat + "원"
	        }
    }
	```	
	사용 시: `Formatter.kor(machine.showBalance()).moneyUnit`