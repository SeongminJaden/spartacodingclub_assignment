import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  // 상품 목록을 상수로 정의하여 변경이 불필요한 데이터로 처리
  final List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  List<Product> cart = [];
  int totalPrice = 0;

  // 상품 목록을 출력하는 메서드
  void showProducts() {
    print('---- 상품 목록 ----');
    for (var i = 0; i < products.length; i++) {
      print('${i + 1}. ${products[i].name} - ${products[i].price}원');
    }
    print('-------------------');
  }

  // 상품을 장바구니에 담는 메서드
  void addToCart(int productIndex) {
    if (productIndex >= 1 && productIndex <= products.length) {
      var selectedProduct = products[productIndex - 1];
      cart.add(selectedProduct);
      totalPrice += selectedProduct.price;
      print('${selectedProduct.name}가 장바구니에 담겼습니다.');
    } else {
      print('잘못된 상품 번호입니다.');
    }
  }

  // 장바구니 총 가격을 출력하는 메서드
  void showTotal() {
    print('장바구니 총 가격: $totalPrice 원');
  }
}

void main() {
  var shoppingMall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print('\n--- 쇼핑몰 메뉴 ---');
    print('1. 상품 목록 보기');
    print('2. 장바구니에 상품 담기');
    print('3. 장바구니 총 가격 보기');
    print('4. 종료');
    stdout.write('원하는 작업을 선택하세요: ');

    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        shoppingMall.showProducts();
        break;
      case '2':
        stdout.write('담고 싶은 상품 번호를 입력하세요: ');
        var productIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (productIndex != null && productIndex > 0) {
          shoppingMall.addToCart(productIndex);
        } else {
          print('잘못된 입력입니다.');
        }
        break;
      case '3':
        shoppingMall.showTotal();
        break;
      case '4':
        print('프로그램을 종료합니다.');
        isRunning = false;
        break;
      default:
        print('잘못된 선택입니다. 다시 시도하세요.');
    }
  }
}
