import 'dart:io';

class Product {
  String name;
  int price;

  // Product 클래스 생성자
  Product(this.name, this.price);
}

class ShoppingMall {
  // 상품 목록
  final List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  // 장바구니 및 총 가격 변수
  List<Product> cart = [];
  int totalPrice = 0;

  // 상품 목록 출력 메서드
  void showProducts() {
    // 상품 목록이 비어 있으면 메시지 출력
    if (products.isEmpty) {
      print('\n❌ 현재 판매 중인 상품이 없습니다.');
    } else {
      print('\n---- 상품 목록 ----');
      // 상품 리스트를 출력
      for (var i = 0; i < products.length; i++) {
        print('${i + 1}. ${products[i].name} - ${products[i].price}원');
      }
      print('-------------------');
    }
  }

  // 장바구니에 상품 추가 메서드
  void addToCart(int productIndex, int quantity) {
    // 상품 인덱스와 수량이 올바른지 체크
    if (productIndex >= 1 && productIndex <= products.length && quantity > 0) {
      var selectedProduct = products[productIndex - 1];

      // 상품을 장바구니에 수량만큼 추가
      for (var i = 0; i < quantity; i++) {
        cart.add(selectedProduct);
      }

      // 총 가격 업데이트
      totalPrice += selectedProduct.price * quantity;

      // 추가된 상품 정보 출력
      print('\n🛒 장바구니에 담긴 상품');
      print('상품명: ${selectedProduct.name}');
      print('가격: ${selectedProduct.price}원');
      print('수량: $quantity개');
      print('총 가격: ${selectedProduct.price * quantity}원');
      print('---------------------------------------------');
    } else {
      // 잘못된 입력 값에 대한 예외 처리
      print('❌ 입력값이 올바르지 않아요!');
    }
  }

  // 장바구니의 총 가격 출력 메서드
  void showTotal() {
    // 장바구니가 비어있으면 경고 메시지 출력
    if (cart.isEmpty) {
      print('\n❌ 장바구니에 담긴 상품이 없습니다.');
    } else {
      // 장바구니에 담긴 총 가격 출력
      print('\n🛒 현재 장바구니 총 가격: $totalPrice 원');
    }
  }

  // 장바구니 내용 확인 메서드
  void showCartContents() {
    // 장바구니가 비어 있으면 출력
    if (cart.isEmpty) {
      print('\n❌ 장바구니에 담긴 상품이 없습니다.');
    } else {
      // 장바구니에 담긴 상품들의 이름을 출력
      var productNames = cart.map((product) => product.name).toSet().join(', ');
      print('\n🛒 장바구니에 $productNames 담겨있네요. 총 $totalPrice 원 입니다!');
    }
  }

  // 장바구니 초기화 메서드
  void clearCart() {
    // 장바구니가 비어 있을 경우 경고 메시지 출력
    if (cart.isEmpty) {
      print('\n❌ 이미 장바구니가 비어 있습니다.');
    } else {
      // 장바구니와 총 가격 초기화
      cart.clear();
      totalPrice = 0;
      print('\n🛒 장바구니를 초기화합니다.');
    }
  }
}

void main() {
  var shoppingMall = ShoppingMall();
  bool isRunning = true;

  // 프로그램 실행 상태를 위한 반복문
  while (isRunning) {
    print('\n--- 쇼핑몰 프로그램 ---');
    print('---------------------------------------------');
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 목록 보기');
    print('[4] 종료 / [5] 장바구니 총 가격 보기 / [6] 장바구니 초기화');
    print('---------------------------------------------');
    stdout.write('원하는 작업을 선택하세요: ');

    // 사용자로부터 선택 받기
    var choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        shoppingMall.showProducts(); // 상품 목록 보기
        break;

      case '2':
        // 상품 번호 입력받기
        stdout.write('담고 싶은 상품 번호를 입력하세요: ');
        var productIndex = int.tryParse(stdin.readLineSync()?.trim() ?? '');

        // 숫자 입력값이 올바르지 않은 경우 예외 처리
        if (productIndex == null) {
          print('❌ 올바른 숫자를 입력하세요!');
          break;
        }

        // 상품 번호가 유효한지 체크
        if (productIndex > 0 && productIndex <= shoppingMall.products.length) {
          stdout.write('수량을 입력하세요 (1개 이상): ');
          var quantity = int.tryParse(stdin.readLineSync()?.trim() ?? '');

          // 수량이 유효하지 않으면 예외 처리
          if (quantity == null || quantity <= 0) {
            print('❌ 0개보다 많은 개수의 상품만 담을 수 있어요!');
          } else {
            shoppingMall.addToCart(productIndex, quantity); // 장바구니에 추가
          }
        } else {
          print('❌ 입력값이 올바르지 않아요!');
        }
        break;

      case '3':
        shoppingMall.showCartContents(); // 장바구니 내용 보기
        break;

      case '4':
        // 종료 여부 확인
        stdout.write('정말 종료하시겠습니까? (종료하려면 5 입력): ');
        var exitConfirm = stdin.readLineSync()?.trim();
        if (exitConfirm == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요! 👋');
          isRunning = false; // 종료
        } else {
          print('🚫 종료하지 않습니다.');
        }
        break;

      case '5':
        shoppingMall.showTotal(); // 장바구니 총 가격 보기
        break;

      case '6':
        shoppingMall.clearCart(); // 장바구니 초기화
        break;

      default:
        print('❌ 잘못된 선택입니다. 다시 시도하세요.'); // 잘못된 선택에 대한 처리
    }
  }
}
